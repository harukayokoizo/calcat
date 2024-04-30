import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/calendar_user.dart';
import '../data/calendar_repositories.dart';
import '../data/calendar_user_repositories.dart';
import '../domain/calendar_document.dart';

final calendarList = StreamProvider.autoDispose<List<CalendarDocument>>(
        (ref) {
          var calendarDoc = ref.read(calendarRepositories).getCalendarList();
          return calendarDoc;
        });

final followCalendarList = StreamProvider.autoDispose<List<CalendarUser>>(
        (ref) {
          var calendarDoc = ref.read(calendarUserRepositories).getAllFollowCalendar();
          return calendarDoc;
        });

final calendarDocumentProvider = StreamProvider.autoDispose.family<CalendarDocument,String>(
        (ref, docId){
          var calendarDoc = ref.read(calendarRepositories).getCalendar(docId);
          return calendarDoc;
        });
