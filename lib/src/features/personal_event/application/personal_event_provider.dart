import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/personal_event_repositories.dart';
import '../domain/personal_event.dart';

final personalEventList = StreamProvider.autoDispose<List<PersonalEvent>>(
        (ref){
          return ref.read(personalEventRepositories).getEvent();
        });