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

  void savePublicPreference(int public) {
    final calendar = state.copyWith(publicPreference: public);
    state = calendar;
  }

  void savePassword(String password) {
    final calendar = state.copyWith(password: password);
    state = calendar;
  }

  bool controlCalendarLink(Map<String, String>? previousLink, Map<String, String> saveLink){
    final calendarLink = state.calendarLink;
    try{
      //既に保存されているリンクが存在する場合
      if(previousLink != null){
        if(previousLink['name'] == saveLink['name']){
          editCalendarLink(saveLink, previousLink['name']!);
        }else{
          if(calendarLink!.isNotEmpty){
            bool exists = calendarLink.any((map) => map['name'] == saveLink['name']);
            if(exists){
              return false;
            }
          }
          editCalendarLink(saveLink, previousLink['name']!);
        }
      }else{
        //リンクが存在しない場合
        if(calendarLink != null) {
          if (calendarLink.isNotEmpty) {
            bool exists = calendarLink.any((map) =>
            map['name'] == saveLink['name']);
            if (exists) {
              return false;
            }
          }
        }
        saveCalendarLink(saveLink);
      }
      return true;
    }catch (e){
      return false;
    }
  }

  void saveCalendarLink(Map<String, String> link) {
    List<Map<String, String>>? calendarLink = state.calendarLink;

    if(calendarLink == null){
      calendarLink = [link];
    }else{
      bool exists = calendarLink.any((map) => map['name'] == link['name']);
      if (exists) {
        return;
      }
      calendarLink = [...calendarLink, link];
    }

    final calendar = state.copyWith(calendarLink: calendarLink);
    state = calendar;
  }

  void editCalendarLink(Map<String, String> saveLink, String previousName) {
    List<Map<String, String>>? calendarLink = state.calendarLink;
    //同じnameがなければ追加
    if(calendarLink != null){
      calendarLink.forEach((link) {
        if(link['name'] == previousName){
          link['name'] = saveLink['name']!;
          link['url'] = saveLink['url']!;
        }
      });
      calendarLink = [...calendarLink];
    }
    final calendar = state.copyWith(calendarLink: calendarLink);
    state = calendar;
  }

  void deleteCalendarLink(String previousName) {
    List<Map<String, String>>? calendarLink = state.calendarLink;
    //同じnameがなければ追加
    if(calendarLink != null){
      final newLink = calendarLink.where((map) => map['name'] != previousName).toList();
      calendarLink = [...newLink];
    }
    final calendar = state.copyWith(calendarLink: calendarLink);
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
    String? error = await validationCheck(docId);
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
    if(state.publicPreference == 2 && (state.password == null || state.password!.isEmpty)){
      return '限定公開の場合は、パスワードを入力してください。';
    }
    if(state.publicPreference == 2 && state.password != null){
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
    String? password = state.publicPreference != 2 ? null : state.password;
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
      'calendarLink': state.calendarLink,
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