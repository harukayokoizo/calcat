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
    String? error = await validationCheck(null);
    if(error != null){
      return error;
    }
    Map<String, dynamic> data = await getCalendarState();
    ref.read(calendarRepositories).createCalendar(data);
  }

  Future<String?> editCalendar(String docId) async{
    String? error = await validationCheck(docId);
    if(error != null){
      return error;
    }
    Map<String, dynamic> data = await getCalendarState();
    ref.read(calendarRepositories).editCalendar(data, docId);
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
  }

  Future<Map<String, dynamic>> getCalendarState() async{
    final image = ref.read(imageStateProvider);
    List<String> searchIndex = createSearchIndex();
    String? password = state.publicPreference! ? null : state.password;
    Map<String, dynamic> data = {
      'author': state.author,
      'title': state.title,
      'description': state.description,
      'image': state.image,
      'publicPreference': state.publicPreference,
      'password': password,
      'created': DateTime.now(),
      'updated': DateTime.now(),
      'searchIndex': searchIndex,
    };

    if(image != null){
      final imageUrl = await ref.read(imageStateProvider.notifier).uploadFile();
      data['image'] = imageUrl;
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