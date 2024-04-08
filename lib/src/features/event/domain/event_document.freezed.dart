// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'event_document.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

EventDocument _$EventDocumentFromJson(Map<String, dynamic> json) {
  return _EventDocument.fromJson(json);
}

/// @nodoc
mixin _$EventDocument {
  Event? get event => throw _privateConstructorUsedError;
  String? get docId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EventDocumentCopyWith<EventDocument> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EventDocumentCopyWith<$Res> {
  factory $EventDocumentCopyWith(
          EventDocument value, $Res Function(EventDocument) then) =
      _$EventDocumentCopyWithImpl<$Res, EventDocument>;
  @useResult
  $Res call({Event? event, String? docId});

  $EventCopyWith<$Res>? get event;
}

/// @nodoc
class _$EventDocumentCopyWithImpl<$Res, $Val extends EventDocument>
    implements $EventDocumentCopyWith<$Res> {
  _$EventDocumentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? event = freezed,
    Object? docId = freezed,
  }) {
    return _then(_value.copyWith(
      event: freezed == event
          ? _value.event
          : event // ignore: cast_nullable_to_non_nullable
              as Event?,
      docId: freezed == docId
          ? _value.docId
          : docId // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $EventCopyWith<$Res>? get event {
    if (_value.event == null) {
      return null;
    }

    return $EventCopyWith<$Res>(_value.event!, (value) {
      return _then(_value.copyWith(event: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$EventDocumentImplCopyWith<$Res>
    implements $EventDocumentCopyWith<$Res> {
  factory _$$EventDocumentImplCopyWith(
          _$EventDocumentImpl value, $Res Function(_$EventDocumentImpl) then) =
      __$$EventDocumentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Event? event, String? docId});

  @override
  $EventCopyWith<$Res>? get event;
}

/// @nodoc
class __$$EventDocumentImplCopyWithImpl<$Res>
    extends _$EventDocumentCopyWithImpl<$Res, _$EventDocumentImpl>
    implements _$$EventDocumentImplCopyWith<$Res> {
  __$$EventDocumentImplCopyWithImpl(
      _$EventDocumentImpl _value, $Res Function(_$EventDocumentImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? event = freezed,
    Object? docId = freezed,
  }) {
    return _then(_$EventDocumentImpl(
      event: freezed == event
          ? _value.event
          : event // ignore: cast_nullable_to_non_nullable
              as Event?,
      docId: freezed == docId
          ? _value.docId
          : docId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EventDocumentImpl implements _EventDocument {
  const _$EventDocumentImpl({this.event, this.docId});

  factory _$EventDocumentImpl.fromJson(Map<String, dynamic> json) =>
      _$$EventDocumentImplFromJson(json);

  @override
  final Event? event;
  @override
  final String? docId;

  @override
  String toString() {
    return 'EventDocument(event: $event, docId: $docId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EventDocumentImpl &&
            (identical(other.event, event) || other.event == event) &&
            (identical(other.docId, docId) || other.docId == docId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, event, docId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EventDocumentImplCopyWith<_$EventDocumentImpl> get copyWith =>
      __$$EventDocumentImplCopyWithImpl<_$EventDocumentImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EventDocumentImplToJson(
      this,
    );
  }
}

abstract class _EventDocument implements EventDocument {
  const factory _EventDocument({final Event? event, final String? docId}) =
      _$EventDocumentImpl;

  factory _EventDocument.fromJson(Map<String, dynamic> json) =
      _$EventDocumentImpl.fromJson;

  @override
  Event? get event;
  @override
  String? get docId;
  @override
  @JsonKey(ignore: true)
  _$$EventDocumentImplCopyWith<_$EventDocumentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
