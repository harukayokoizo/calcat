import 'package:isar/isar.dart';
part 'fcm_token.g.dart';

@collection
class FcmToken {
  Id? id = Isar.autoIncrement;
  String? uid;
  String? fcmToken;

  @Index()
  DateTime? created;
}