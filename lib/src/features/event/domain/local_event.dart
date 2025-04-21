import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:isar/isar.dart';
import 'dart:math';
part 'local_event.g.dart';

@collection
class LocalEvent {
  Id? id = Isar.autoIncrement;
  // Id? id = Isar.autoIncrement;
  String? docId = generateFireStoreId();
  String? title;
  String? overview;
  int? color;
  String? url;
  String? location;
  bool? isAllDay;
  DateTime? to;
  DateTime? from;
  int? repeat;
  DateTime? endDate;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? sameEventId;//ランダムの値を自動生成する
  int? number;
  bool? notificationExist;
  String? calendarMonth;

  @ignore
  Timestamp? get toTimestamp => to != null ? Timestamp.fromDate(to!) : null;
  @ignore
  Timestamp? get fromTimestamp => from != null ? Timestamp.fromDate(from!) : null;
  @ignore
  Timestamp? get endDateTimestamp => endDate != null ? Timestamp.fromDate(endDate!) : null;
  @ignore
  Timestamp? get createdAtTimestamp => createdAt != null ? Timestamp.fromDate(createdAt!) : null;
  @ignore
  Timestamp? get updatedAtTimestamp => updatedAt != null ? Timestamp.fromDate(updatedAt!) : null;

  Map<String, dynamic> toJson(){
    return {
      'id': id,
      'docId': docId,
      'title': title,
      'overview': overview,
      'color': color,
      'url': url,
      'location': location,
      'isAllDay': isAllDay,
      'to': to,
      'from': from,
      'repeat': repeat,
      'endDate': endDate,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'sameEventId': sameEventId,
      'number': number,
      'notificationExist': notificationExist,
      'calendarMonth': calendarMonth,
      'toTimestamp': toTimestamp,
      'fromTimestamp': fromTimestamp,
      'endDateTimestamp': endDateTimestamp,
      'createdAtTimestamp': createdAtTimestamp,
      'updatedAtTimestamp': updatedAtTimestamp,
    };
  }
}

String? generateFireStoreId(){
  const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
  final rand = Random();
  return List.generate(20, (index)=>chars[rand.nextInt(chars.length)]).join();
}