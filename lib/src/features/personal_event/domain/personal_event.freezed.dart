// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'personal_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PersonalEvent _$PersonalEventFromJson(Map<String, dynamic> json) {
  return _PersonalEvent.fromJson(json);
}

/// @nodoc
mixin _$PersonalEvent {
  String? get uid => throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;
  String? get event => throw _privateConstructorUsedError;
  String? get image => throw _privateConstructorUsedError;
  int? get color => throw _privateConstructorUsedError;
  bool? get isAllDay => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get from => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get to => throw _privateConstructorUsedError;
  List<int>? get notification => throw _privateConstructorUsedError;
  int? get repeat => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get endDate => throw _privateConstructorUsedError;
  String? get sameEventId => throw _privateConstructorUsedError;
  int? get number => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PersonalEventCopyWith<PersonalEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PersonalEventCopyWith<$Res> {
  factory $PersonalEventCopyWith(
          PersonalEvent value, $Res Function(PersonalEvent) then) =
      _$PersonalEventCopyWithImpl<$Res, PersonalEvent>;
  @useResult
  $Res call(
      {String? uid,
      String? title,
      String? event,
      String? image,
      int? color,
      bool? isAllDay,
      @TimestampConverter() DateTime? from,
      @TimestampConverter() DateTime? to,
      List<int>? notification,
      int? repeat,
      @TimestampConverter() DateTime? endDate,
      String? sameEventId,
      int? number});
}

/// @nodoc
class _$PersonalEventCopyWithImpl<$Res, $Val extends PersonalEvent>
    implements $PersonalEventCopyWith<$Res> {
  _$PersonalEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = freezed,
    Object? title = freezed,
    Object? event = freezed,
    Object? image = freezed,
    Object? color = freezed,
    Object? isAllDay = freezed,
    Object? from = freezed,
    Object? to = freezed,
    Object? notification = freezed,
    Object? repeat = freezed,
    Object? endDate = freezed,
    Object? sameEventId = freezed,
    Object? number = freezed,
  }) {
    return _then(_value.copyWith(
      uid: freezed == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      event: freezed == event
          ? _value.event
          : event // ignore: cast_nullable_to_non_nullable
              as String?,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      color: freezed == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as int?,
      isAllDay: freezed == isAllDay
          ? _value.isAllDay
          : isAllDay // ignore: cast_nullable_to_non_nullable
              as bool?,
      from: freezed == from
          ? _value.from
          : from // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      to: freezed == to
          ? _value.to
          : to // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      notification: freezed == notification
          ? _value.notification
          : notification // ignore: cast_nullable_to_non_nullable
              as List<int>?,
      repeat: freezed == repeat
          ? _value.repeat
          : repeat // ignore: cast_nullable_to_non_nullable
              as int?,
      endDate: freezed == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      sameEventId: freezed == sameEventId
          ? _value.sameEventId
          : sameEventId // ignore: cast_nullable_to_non_nullable
              as String?,
      number: freezed == number
          ? _value.number
          : number // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PersonalEventImplCopyWith<$Res>
    implements $PersonalEventCopyWith<$Res> {
  factory _$$PersonalEventImplCopyWith(
          _$PersonalEventImpl value, $Res Function(_$PersonalEventImpl) then) =
      __$$PersonalEventImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? uid,
      String? title,
      String? event,
      String? image,
      int? color,
      bool? isAllDay,
      @TimestampConverter() DateTime? from,
      @TimestampConverter() DateTime? to,
      List<int>? notification,
      int? repeat,
      @TimestampConverter() DateTime? endDate,
      String? sameEventId,
      int? number});
}

/// @nodoc
class __$$PersonalEventImplCopyWithImpl<$Res>
    extends _$PersonalEventCopyWithImpl<$Res, _$PersonalEventImpl>
    implements _$$PersonalEventImplCopyWith<$Res> {
  __$$PersonalEventImplCopyWithImpl(
      _$PersonalEventImpl _value, $Res Function(_$PersonalEventImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = freezed,
    Object? title = freezed,
    Object? event = freezed,
    Object? image = freezed,
    Object? color = freezed,
    Object? isAllDay = freezed,
    Object? from = freezed,
    Object? to = freezed,
    Object? notification = freezed,
    Object? repeat = freezed,
    Object? endDate = freezed,
    Object? sameEventId = freezed,
    Object? number = freezed,
  }) {
    return _then(_$PersonalEventImpl(
      uid: freezed == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      event: freezed == event
          ? _value.event
          : event // ignore: cast_nullable_to_non_nullable
              as String?,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      color: freezed == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as int?,
      isAllDay: freezed == isAllDay
          ? _value.isAllDay
          : isAllDay // ignore: cast_nullable_to_non_nullable
              as bool?,
      from: freezed == from
          ? _value.from
          : from // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      to: freezed == to
          ? _value.to
          : to // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      notification: freezed == notification
          ? _value._notification
          : notification // ignore: cast_nullable_to_non_nullable
              as List<int>?,
      repeat: freezed == repeat
          ? _value.repeat
          : repeat // ignore: cast_nullable_to_non_nullable
              as int?,
      endDate: freezed == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      sameEventId: freezed == sameEventId
          ? _value.sameEventId
          : sameEventId // ignore: cast_nullable_to_non_nullable
              as String?,
      number: freezed == number
          ? _value.number
          : number // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PersonalEventImpl implements _PersonalEvent {
  const _$PersonalEventImpl(
      {this.uid,
      this.title,
      this.event,
      this.image,
      this.color,
      this.isAllDay,
      @TimestampConverter() this.from,
      @TimestampConverter() this.to,
      final List<int>? notification,
      this.repeat,
      @TimestampConverter() this.endDate,
      this.sameEventId,
      this.number})
      : _notification = notification;

  factory _$PersonalEventImpl.fromJson(Map<String, dynamic> json) =>
      _$$PersonalEventImplFromJson(json);

  @override
  final String? uid;
  @override
  final String? title;
  @override
  final String? event;
  @override
  final String? image;
  @override
  final int? color;
  @override
  final bool? isAllDay;
  @override
  @TimestampConverter()
  final DateTime? from;
  @override
  @TimestampConverter()
  final DateTime? to;
  final List<int>? _notification;
  @override
  List<int>? get notification {
    final value = _notification;
    if (value == null) return null;
    if (_notification is EqualUnmodifiableListView) return _notification;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final int? repeat;
  @override
  @TimestampConverter()
  final DateTime? endDate;
  @override
  final String? sameEventId;
  @override
  final int? number;

  @override
  String toString() {
    return 'PersonalEvent(uid: $uid, title: $title, event: $event, image: $image, color: $color, isAllDay: $isAllDay, from: $from, to: $to, notification: $notification, repeat: $repeat, endDate: $endDate, sameEventId: $sameEventId, number: $number)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PersonalEventImpl &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.event, event) || other.event == event) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.color, color) || other.color == color) &&
            (identical(other.isAllDay, isAllDay) ||
                other.isAllDay == isAllDay) &&
            (identical(other.from, from) || other.from == from) &&
            (identical(other.to, to) || other.to == to) &&
            const DeepCollectionEquality()
                .equals(other._notification, _notification) &&
            (identical(other.repeat, repeat) || other.repeat == repeat) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.sameEventId, sameEventId) ||
                other.sameEventId == sameEventId) &&
            (identical(other.number, number) || other.number == number));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      uid,
      title,
      event,
      image,
      color,
      isAllDay,
      from,
      to,
      const DeepCollectionEquality().hash(_notification),
      repeat,
      endDate,
      sameEventId,
      number);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PersonalEventImplCopyWith<_$PersonalEventImpl> get copyWith =>
      __$$PersonalEventImplCopyWithImpl<_$PersonalEventImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PersonalEventImplToJson(
      this,
    );
  }
}

abstract class _PersonalEvent implements PersonalEvent {
  const factory _PersonalEvent(
      {final String? uid,
      final String? title,
      final String? event,
      final String? image,
      final int? color,
      final bool? isAllDay,
      @TimestampConverter() final DateTime? from,
      @TimestampConverter() final DateTime? to,
      final List<int>? notification,
      final int? repeat,
      @TimestampConverter() final DateTime? endDate,
      final String? sameEventId,
      final int? number}) = _$PersonalEventImpl;

  factory _PersonalEvent.fromJson(Map<String, dynamic> json) =
      _$PersonalEventImpl.fromJson;

  @override
  String? get uid;
  @override
  String? get title;
  @override
  String? get event;
  @override
  String? get image;
  @override
  int? get color;
  @override
  bool? get isAllDay;
  @override
  @TimestampConverter()
  DateTime? get from;
  @override
  @TimestampConverter()
  DateTime? get to;
  @override
  List<int>? get notification;
  @override
  int? get repeat;
  @override
  @TimestampConverter()
  DateTime? get endDate;
  @override
  String? get sameEventId;
  @override
  int? get number;
  @override
  @JsonKey(ignore: true)
  _$$PersonalEventImplCopyWith<_$PersonalEventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
