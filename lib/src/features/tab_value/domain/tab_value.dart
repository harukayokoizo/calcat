import 'package:isar/isar.dart';
part 'tab_value.g.dart';

@collection
class TabValue {
  Id id = Isar.autoIncrement;
  int? tabIndex;
  int? listTabIndex;
}