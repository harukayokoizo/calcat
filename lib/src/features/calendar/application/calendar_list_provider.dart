import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/calendar_repositories.dart';
import '../domain/calendar_document.dart';

final calendarList = StreamProvider<List<CalendarDocument>>(
        (ref) {
          var calendarDoc = ref.read(calendarRepositories).getCalendar();
          return calendarDoc;
        });
