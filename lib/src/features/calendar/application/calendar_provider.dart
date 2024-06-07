import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../common_widgets/application/common_provider.dart';
import '../data/calendar_repositories.dart';
import '../domain/calendar.dart';
import 'image_provider.dart';

final calendarStateProvider = StateNotifierProvider.autoDispose.family<CalendarState, Calendar, Calendar>(
        (ref, calendar){
          return CalendarState(ref, calendar);
        }
);

class CalendarState extends StateNotifier<Calendar>{
  Ref ref;
  Calendar calendar;
  CalendarState(this.ref, this.calendar) : super(calendar);

  void saveTitle(String title){
    final calendar = state.copyWith(title: title);
    state = calendar;
  }

  void saveDescription(String description) {
    final calendar = state.copyWith(description: description);
    state = calendar;
  }

  void savePublicPreference(bool public) {
    final calendar = state.copyWith(publicPreference: public);
    state = calendar;
  }

  void savePassword(String password) {
    final calendar = state.copyWith(password: password);
    state = calendar;
  }

  Future<String?> createCalendar() async{
    String? calendarId;
    String? error = await validationCheck(null);
    if(error != null){
      return error;
    }
    try {
      Map<String, dynamic> data = getCalendarState(true);
      calendarId = await ref.read(calendarRepositories).createCalendar(data);
      if (calendarId != null) {
        await ref.read(imageStateProvider.notifier).uploadFile(calendarId);
      }
    }catch (e){
      if(calendarId != null){
        await ref.read(calendarRepositories).deleteCalendar(calendarId);
      }
      return '保存に失敗しました。';
    }

    return null;
  }

  Future<String?> editCalendar(String docId) async{
    final imageState = ref.read(imageStateProvider);
    String? error = await validationCheck(null);
    if(error != null){
      return error;
    }
    try {
      Map<String, dynamic> data = getCalendarState(false);
      await ref.read(calendarRepositories).editCalendar(data, docId);
      if (imageState != null) {
        await ref.read(imageStateProvider.notifier).uploadFile(docId);
      }
    }catch (e){
      return e.toString();
    }

    return null;
  }

  Future<String?> validationCheck(String? docId) async{
    if(state.title == null || state.title!.isEmpty){
      return 'カレンダー名を入力してください。';
    }
    if(state.description == null || state.description!.isEmpty){
      return '概要を入力してください。';
    }
    if(!state.publicPreference! && (state.password == null || state.password!.isEmpty)){
      return '限定公開の場合は、パスワードを入力してください。';
    }
    if(!state.publicPreference! && state.password != null){
      String? id = await ref.read(calendarRepositories).getSameCalendar(state.title!,state.password!);
      if(docId == null){
        if(id != null){
          return 'カレンダー名とパスワードが一致するものが既に存在します。';
        }
      }else{
        if(id != null && id != docId){
          return 'カレンダー名とパスワードが一致するものが既に存在します。';
        }
      }
    }
    return null;
  }

  Map<String, dynamic> getCalendarState(bool create){
    List<String> searchIndex = createSearchIndex();
    List<String> calendarOwner = [state.author!];
    String? password = state.publicPreference! ? null : state.password;
    Map<String, dynamic> data = {
      'author': state.author,
      'title': state.title,
      'description': state.description,
      'image': state.image,
      'fileName': state.fileName,
      'publicPreference': state.publicPreference,
      'password': password,
      'updated': DateTime.now(),
      'searchIndex': searchIndex,
    };
    
    if(create){
      data.addAll({
        'created': DateTime.now(),
        'followsCount': 0,
        'calendarOwner': calendarOwner,
      });
    }

    return data;
  }

  List<String> createSearchIndex(){
    String title = state.title!;
    List<String> searchIndex = [];
    var titleLength = title.length;//5

    for(int i = 0; i < titleLength; i++){
      for(int j = 0; j <= i; j++){
        int diff = titleLength - i;
        searchIndex.add(title.substring(j, j + diff));
      }
    }

    return searchIndex;
  }
}