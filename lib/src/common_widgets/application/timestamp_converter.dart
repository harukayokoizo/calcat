
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

//FireStoreのTimestampをDartのDateTimeに変換するクラス
class TimestampConverter implements JsonConverter<DateTime, Timestamp> {
  const TimestampConverter();


  @override
  //timestampからDateTimeに変換する。
  DateTime fromJson(Timestamp timestamp) {
    return timestamp.toDate();
  }

  @override
  //DateTimeからTimeStampに変換する。
  Timestamp toJson(DateTime date) => Timestamp.fromDate(date);
}

class DocumentReferenceConverter
    implements JsonConverter<DocumentReference, DocumentReference> {
  const DocumentReferenceConverter();

  @override
  DocumentReference fromJson(DocumentReference docRef) => docRef;

  @override
  DocumentReference toJson(DocumentReference docRef) => docRef;
}