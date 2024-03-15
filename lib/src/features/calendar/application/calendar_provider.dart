import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../common_widgets/application/common_provider.dart';
import '../data/calendar_repositories.dart';
import '../domain/calendar.dart';
import 'image_provider.dart';

final calendarStateProvider = StateNotifierProvider.autoDispose.family<CalendarState, Calendar, Calendar?>(
        (ref, calendar){
          if(calendar == null) {
            final user = ref.read(currentUser);
            calendar = Calendar(
              author: user!.uid,
              title: null,
              description: null,
              image: null,
              publicPreference: true,
              password: null,
              created: null,
              updated: null,
            );
          }
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

  Future<void> createCalendar() async{
    final image = ref.read(imageStateProvider);
    DateTime date = DateTime.now();
    Map<String, dynamic> data = {
      'author': state.author,
      'title': state.title,
      'description': state.description,
      'image': state.image,
      'publicPreference': state.publicPreference,
      'password': state.password,
      'created': date,
      'updated': date,
    };

    if(image != null){
      final imageUrl = await ref.read(imageStateProvider.notifier).uploadFile();
      data['image'] = imageUrl;
    }

    ref.read(calendarRepositories).createCalendar(data);
  }
}