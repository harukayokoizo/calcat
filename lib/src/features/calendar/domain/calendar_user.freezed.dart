// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../../calendar/domain/calendar_user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CalendarUser _$CalendarUserFromJson(Map<String, dynamic> json) {
  return _CalendarUser.fromJson(json);
}

/// @nodoc
mixin _$CalendarUser {
  String? get uid => throw _privateConstructorUsedError;
  @DocumentReferenceConverter()
  DocumentReference<Object?>? get calendar =>
      throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get create => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CalendarUserCopyWith<CalendarUser> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CalendarUserCopyWith<$Res> {
  factory $CalendarUserCopyWith(
          CalendarUser value, $Res Function(CalendarUser) then) =
      _$CalendarUserCopyWithImpl<$Res, CalendarUser>;
  @useResult
  $Res call(
      {String? uid,
      @DocumentReferenceConverter() DocumentReference<Object?>? calendar,
      @TimestampConverter() DateTime? create});
}

/// @nodoc
class _$CalendarUserCopyWithImpl<$Res, $Val extends CalendarUser>
    implements $CalendarUserCopyWith<$Res> {
  _$CalendarUserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = freezed,
    Object? calendar = freezed,
    Object? create = freezed,
  }) {
    return _then(_value.copyWith(
      uid: freezed == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String?,
      calendar: freezed == calendar
          ? _value.calendar
          : calendar // ignore: cast_nullable_to_non_nullable
              as DocumentReference<Object?>?,
      create: freezed == create
          ? _value.create
          : create // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CalendarUserImplCopyWith<$Res>
    implements $CalendarUserCopyWith<$Res> {
  factory _$$CalendarUserImplCopyWith(
          _$CalendarUserImpl value, $Res Function(_$CalendarUserImpl) then) =
      __$$CalendarUserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? uid,
      @DocumentReferenceConverter() DocumentReference<Object?>? calendar,
      @TimestampConverter() DateTime? create});
}

/// @nodoc
class __$$CalendarUserImplCopyWithImpl<$Res>
    extends _$CalendarUserCopyWithImpl<$Res, _$CalendarUserImpl>
    implements _$$CalendarUserImplCopyWith<$Res> {
  __$$CalendarUserImplCopyWithImpl(
      _$CalendarUserImpl _value, $Res Function(_$CalendarUserImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = freezed,
    Object? calendar = freezed,
    Object? create = freezed,
  }) {
    return _then(_$CalendarUserImpl(
      uid: freezed == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String?,
      calendar: freezed == calendar
          ? _value.calendar
          : calendar // ignore: cast_nullable_to_non_nullable
              as DocumentReference<Object?>?,
      create: freezed == create
          ? _value.create
          : create // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CalendarUserImpl implements _CalendarUser {
  const _$CalendarUserImpl(
      {this.uid,
      @DocumentReferenceConverter() this.calendar,
      @TimestampConverter() this.create});

  factory _$CalendarUserImpl.fromJson(Map<String, dynamic> json) =>
      _$$CalendarUserImplFromJson(json);

  @override
  final String? uid;
  @override
  @DocumentReferenceConverter()
  final DocumentReference<Object?>? calendar;
  @override
  @TimestampConverter()
  final DateTime? create;

  @override
  String toString() {
    return 'CalendarUser(uid: $uid, calendar: $calendar, create: $create)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CalendarUserImpl &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.calendar, calendar) ||
                other.calendar == calendar) &&
            (identical(other.create, create) || other.create == create));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, uid, calendar, create);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CalendarUserImplCopyWith<_$CalendarUserImpl> get copyWith =>
      __$$CalendarUserImplCopyWithImpl<_$CalendarUserImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CalendarUserImplToJson(
      this,
    );
  }
}

abstract class _CalendarUser implements CalendarUser {
  const factory _CalendarUser(
      {final String? uid,
      @DocumentReferenceConverter() final DocumentReference<Object?>? calendar,
      @TimestampConverter() final DateTime? create}) = _$CalendarUserImpl;

  factory _CalendarUser.fromJson(Map<String, dynamic> json) =
      _$CalendarUserImpl.fromJson;

  @override
  String? get uid;
  @override
  @DocumentReferenceConverter()
  DocumentReference<Object?>? get calendar;
  @override
  @TimestampConverter()
  DateTime? get create;
  @override
  @JsonKey(ignore: true)
  _$$CalendarUserImplCopyWith<_$CalendarUserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
