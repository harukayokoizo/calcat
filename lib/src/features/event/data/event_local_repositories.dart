import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_calendar/src/features/event/application/event_provider.dart';
import 'package:share_calendar/src/features/event/data/database.dart';

import '../../../common_widgets/application/common_provider.dart';
import '../../authentication/domain/fcm_token.dart';
import '../../notification/data/personal_event_notification_repositories.dart';
import '../../search_value/domain/search_value.dart';
import '../../tab_value/domain/tab_value.dart';
import '../application/event_list_provider.dart';
import '../domain/event_document.dart';
import '../domain/event.dart';
import '../domain/local_event.dart';

final eventLocalRepositories = Provider((ref) => EventLocalRepositories(ref));

class EventLocalRepositories{
  Isar? isar;
  Ref ref;

  EventLocalRepositories(this.ref);

  //Isarデータベースを開く
  Future<void> connectIsar() async{
    try {
      final dir = await getApplicationDocumentsDirectory();
      if (Isar.instanceNames.isNotEmpty) {
        // 既存のインスタンスを取得
        isar = Isar.getInstance('myInstance');
      } else {
        isar ??= await Isar.open(
          [FcmTokenSchema, SearchValueSchema, TabValueSchema, LocalEventSchema],
          directory: dir.path,
          name: 'myInstance',
        );
      }
    }catch (e){
      throw e.toString();
    }
  }

  //personal_eventコレクションからイベントを取得する
  Stream<List<EventDocument>> getEvent(String calendarMonth) async*{
    if (isar == null) {
      await connectIsar();
    }
    final query = isar!.localEvents.filter().calendarMonthEqualTo(calendarMonth).build();
    yield* query.watch(fireImmediately: true).map((eventList){
      return eventList.map((localEvent) {
        Map<String, dynamic> event = localEvent.toJson();
        Event personalEvent = Event.fromLocalEventJson(event);
        EventDocument eventDocument = EventDocument(event: personalEvent, docId: event['docId']);
        return eventDocument;
      }).toList();
    });
  }

  //同じイベントのものを消す時に使用する関数
  Future<List<int>> getSameEvent(String sameEventId) async{
    final events = await isar!.localEvents.filter()
        .sameEventIdEqualTo(sameEventId)
        .idProperty()
        .findAll();

    return events;
  }

  //同じイベントの開始日を取得する。
  Future<List<DateTime>> getSameEventDate(String sameEventId) async{
    List<DateTime> events = [];
    await isar!.localEvents.filter()
        .sameEventIdEqualTo(sameEventId)
        .findAll()
        .asStream()
        .forEach((eventList) {
          for(var event in eventList){
            DateTime from = DateTime.utc(event.from!.year,event.from!.month, event.from!.day);
            events.add(from);
          }
        });

    return events;
  }

  //LocalEventsのデータベースに、データを新規作成する。
  Future<void> createEvent(List events) async{
    final String? sameEventId = generateFireStoreId();
    for(var data in events){
      data['sameEventId'] = sameEventId;
      final localEvent = LocalEvent()
        ..title = data['title']
        ..overview = data['overview']
        ..color = data['color']
        ..url = data['url']
        ..location = data['location']
        ..isAllDay = data['isAllDay']
        ..to = data['to']
        ..from = data['from']
        ..repeat = data['repeat']
        ..endDate = data['endDate']
        ..createdAt = data['createdAt']
        ..updatedAt = data['updatedAt']
        ..sameEventId = data['sameEventId']
        ..number = data['number']
        ..notificationExist = data['notificationExist']
        ..calendarMonth = data['calendarMonth'];

      await isar!.writeTxn(() async {
        await isar!.localEvents.put(localEvent);
      });
    }

  }

  // IDに紐づくデータを取得する。
  Future<LocalEvent> getSingleEvent(String docId) async{
    final id = await isar!.localEvents.filter().docIdEqualTo(docId).idProperty().findFirst();
    final event = await isar!.localEvents.get(id!);
    return event!;
  }

  Future<void> updateEvent(Map<String, dynamic> data, String docId) async{
    if (isar == null) {
      await connectIsar();
    }
    await isar!.writeTxn(() async {
      LocalEvent event = await getSingleEvent(docId);
      event.title = data['title'];
      event.overview = data['overview'];
      event.color = data['color'];
      event.url = data['url'];
      event.location = data['location'];
      event.isAllDay = data['isAllDay'];
      event.to = data['to'];
      event.from = data['from'];
      event.repeat = data['repeat'];
      event.endDate = data['endDate'];
      event.createdAt = data['createdAt'];
      event.updatedAt = data['updatedAt'];
      event.sameEventId = data['sameEventId'];
      event.number = data['number'];
      event.notificationExist = data['notificationExist'];
      event.calendarMonth = data['calendarMonth'];
      await isar!.localEvents.put(event);
    });
  }

  //第一引数のイベントを削除する。
  //第二引数のイベントを削除する。
  Future<void> deleteAndUpdateEvent(List<int> deleteEvents, List createEvents) async{
    if (isar == null) {
      await connectIsar();
    }
    await isar!.writeTxn(() async {
      await isar!.localEvents.deleteAll(deleteEvents);
    });

    await createEvent(createEvents);
  }

  //単一のイベントを削除する
  Future<void> deleteEvent(EventDocument eventDoc) async{
    if (isar == null) {
      await connectIsar();
    }
    await isar!.writeTxn(() async {
      LocalEvent event = await getSingleEvent(eventDoc.docId!);
      await isar!.localEvents.delete(event.id!);
    });
  }

  //同じイベントをすべて削除する。
  Future<void> deleteSameEvents(EventDocument eventDoc) async{
    if (isar == null) {
      await connectIsar();
    }
    List<int> deleteEvents = await getSameEvent(eventDoc.event!.sameEventId!);
    await isar!.writeTxn(() async {
      await isar!.localEvents.deleteAll(deleteEvents);
    });
  }

  //すべてのイベントを削除する
  Future<void> deleteAllEvent() async{
    if (isar == null) {
      await connectIsar();
    }
    await isar!.writeTxn(() async {
      await isar!.localEvents.clear();
    });
  }
}