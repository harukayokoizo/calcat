import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/calendar_user_repositories.dart';

final getFollowCalendar = FutureProvider.autoDispose.family<bool, String>(
        (ref, docId) async{
          bool follow = await ref.read(calendarUserRepositories).getFollowCalendar(docId);
          return follow;
        }
);