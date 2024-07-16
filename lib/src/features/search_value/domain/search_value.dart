import 'package:isar/isar.dart';
part 'search_value.g.dart';

@collection
class SearchValue {
  Id? id = Isar.autoIncrement;
  String? searchValue;

  @Index()
  DateTime? created;
}