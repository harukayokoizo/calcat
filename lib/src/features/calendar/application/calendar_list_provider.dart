import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../authentication/application/user_provider.dart';
import '../domain/calendar_user.dart';
import '../data/calendar_repositories.dart';
import '../data/calendar_user_repositories.dart';
import '../domain/calendar_document.dart';

final calendarList = StreamProvider.autoDispose.family<List<CalendarDocument>,User?>(
        (ref,user) {
          var calendarDoc = ref.read(calendarRepositories).getCalendarList(user);
          return calendarDoc;
        });

final followCalendarList = StreamProvider.autoDispose.family<List<CalendarUser>,User?>(
        (ref,user) {
          var calendarDoc = ref.read(calendarUserRepositories).getAllFollowCalendar(user);
          return calendarDoc;
        });

final calendarDocumentProvider = StreamProvider.autoDispose.family<CalendarDocument,String>(
        (ref, docId){
          var calendarDoc = ref.read(calendarRepositories).getCalendar(docId);
          return calendarDoc;
        });
