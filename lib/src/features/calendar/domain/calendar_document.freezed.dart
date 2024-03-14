// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'calendar_document.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CalendarDocument _$CalendarDocumentFromJson(Map<String, dynamic> json) {
  return _CalendarDocument.fromJson(json);
}

/// @nodoc
mixin _$CalendarDocument {
  Calendar? get calendar => throw _privateConstructorUsedError;
  String? get docId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CalendarDocumentCopyWith<CalendarDocument> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CalendarDocumentCopyWith<$Res> {
  factory $CalendarDocumentCopyWith(
          CalendarDocument value, $Res Function(CalendarDocument) then) =
      _$CalendarDocumentCopyWithImpl<$Res, CalendarDocument>;
  @useResult
  $Res call({Calendar? calendar, String? docId});

  $CalendarCopyWith<$Res>? get calendar;
}

/// @nodoc
class _$CalendarDocumentCopyWithImpl<$Res, $Val extends CalendarDocument>
    implements $CalendarDocumentCopyWith<$Res> {
  _$CalendarDocumentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? calendar = freezed,
    Object? docId = freezed,
  }) {
    return _then(_value.copyWith(
      calendar: freezed == calendar
          ? _value.calendar
          : calendar // ignore: cast_nullable_to_non_nullable
              as Calendar?,
      docId: freezed == docId
          ? _value.docId
          : docId // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $CalendarCopyWith<$Res>? get calendar {
    if (_value.calendar == null) {
      return null;
    }

    return $CalendarCopyWith<$Res>(_value.calendar!, (value) {
      return _then(_value.copyWith(calendar: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CalendarDocumentImplCopyWith<$Res>
    implements $CalendarDocumentCopyWith<$Res> {
  factory _$$CalendarDocumentImplCopyWith(_$CalendarDocumentImpl value,
          $Res Function(_$CalendarDocumentImpl) then) =
      __$$CalendarDocumentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Calendar? calendar, String? docId});

  @override
  $CalendarCopyWith<$Res>? get calendar;
}

/// @nodoc
class __$$CalendarDocumentImplCopyWithImpl<$Res>
    extends _$CalendarDocumentCopyWithImpl<$Res, _$CalendarDocumentImpl>
    implements _$$CalendarDocumentImplCopyWith<$Res> {
  __$$CalendarDocumentImplCopyWithImpl(_$CalendarDocumentImpl _value,
      $Res Function(_$CalendarDocumentImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? calendar = freezed,
    Object? docId = freezed,
  }) {
    return _then(_$CalendarDocumentImpl(
      calendar: freezed == calendar
          ? _value.calendar
          : calendar // ignore: cast_nullable_to_non_nullable
              as Calendar?,
      docId: freezed == docId
          ? _value.docId
          : docId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CalendarDocumentImpl implements _CalendarDocument {
  const _$CalendarDocumentImpl({this.calendar, this.docId});

  factory _$CalendarDocumentImpl.fromJson(Map<String, dynamic> json) =>
      _$$CalendarDocumentImplFromJson(json);

  @override
  final Calendar? calendar;
  @override
  final String? docId;

  @override
  String toString() {
    return 'CalendarDocument(calendar: $calendar, docId: $docId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CalendarDocumentImpl &&
            (identical(other.calendar, calendar) ||
                other.calendar == calendar) &&
            (identical(other.docId, docId) || other.docId == docId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, calendar, docId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CalendarDocumentImplCopyWith<_$CalendarDocumentImpl> get copyWith =>
      __$$CalendarDocumentImplCopyWithImpl<_$CalendarDocumentImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CalendarDocumentImplToJson(
      this,
    );
  }
}

abstract class _CalendarDocument implements CalendarDocument {
  const factory _CalendarDocument(
      {final Calendar? calendar, final String? docId}) = _$CalendarDocumentImpl;

  factory _CalendarDocument.fromJson(Map<String, dynamic> json) =
      _$CalendarDocumentImpl.fromJson;

  @override
  Calendar? get calendar;
  @override
  String? get docId;
  @override
  @JsonKey(ignore: true)
  _$$CalendarDocumentImplCopyWith<_$CalendarDocumentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
