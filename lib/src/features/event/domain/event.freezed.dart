// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Event _$EventFromJson(Map<String, dynamic> json) {
  return _Event.fromJson(json);
}

/// @nodoc
mixin _$Event {
  String? get uid => throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;
  String? get overview => throw _privateConstructorUsedError;
  String? get image => throw _privateConstructorUsedError;
  int? get color => throw _privateConstructorUsedError;
  String? get url => throw _privateConstructorUsedError;
  String? get location => throw _privateConstructorUsedError;
  bool? get isAllDay => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get from => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get to => throw _privateConstructorUsedError;
  int? get repeat => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get endDate => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  String? get sameEventId => throw _privateConstructorUsedError;
  int? get number => throw _privateConstructorUsedError;
  String? get calendarId => throw _privateConstructorUsedError;
  bool? get notificationExist => throw _privateConstructorUsedError;
  String? get calendarMonth => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EventCopyWith<Event> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EventCopyWith<$Res> {
  factory $EventCopyWith(Event value, $Res Function(Event) then) =
      _$EventCopyWithImpl<$Res, Event>;
  @useResult
  $Res call(
      {String? uid,
      String? title,
      String? overview,
      String? image,
      int? color,
      String? url,
      String? location,
      bool? isAllDay,
      @TimestampConverter() DateTime? from,
      @TimestampConverter() DateTime? to,
      int? repeat,
      @TimestampConverter() DateTime? endDate,
      @TimestampConverter() DateTime? createdAt,
      @TimestampConverter() DateTime? updatedAt,
      String? sameEventId,
      int? number,
      String? calendarId,
      bool? notificationExist,
      String? calendarMonth});
}

/// @nodoc
class _$EventCopyWithImpl<$Res, $Val extends Event>
    implements $EventCopyWith<$Res> {
  _$EventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = freezed,
    Object? title = freezed,
    Object? overview = freezed,
    Object? image = freezed,
    Object? color = freezed,
    Object? url = freezed,
    Object? location = freezed,
    Object? isAllDay = freezed,
    Object? from = freezed,
    Object? to = freezed,
    Object? repeat = freezed,
    Object? endDate = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? sameEventId = freezed,
    Object? number = freezed,
    Object? calendarId = freezed,
    Object? notificationExist = freezed,
    Object? calendarMonth = freezed,
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
      overview: freezed == overview
          ? _value.overview
          : overview // ignore: cast_nullable_to_non_nullable
              as String?,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      color: freezed == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as int?,
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
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
      repeat: freezed == repeat
          ? _value.repeat
          : repeat // ignore: cast_nullable_to_non_nullable
              as int?,
      endDate: freezed == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      sameEventId: freezed == sameEventId
          ? _value.sameEventId
          : sameEventId // ignore: cast_nullable_to_non_nullable
              as String?,
      number: freezed == number
          ? _value.number
          : number // ignore: cast_nullable_to_non_nullable
              as int?,
      calendarId: freezed == calendarId
          ? _value.calendarId
          : calendarId // ignore: cast_nullable_to_non_nullable
              as String?,
      notificationExist: freezed == notificationExist
          ? _value.notificationExist
          : notificationExist // ignore: cast_nullable_to_non_nullable
              as bool?,
      calendarMonth: freezed == calendarMonth
          ? _value.calendarMonth
          : calendarMonth // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EventImplCopyWith<$Res> implements $EventCopyWith<$Res> {
  factory _$$EventImplCopyWith(
          _$EventImpl value, $Res Function(_$EventImpl) then) =
      __$$EventImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? uid,
      String? title,
      String? overview,
      String? image,
      int? color,
      String? url,
      String? location,
      bool? isAllDay,
      @TimestampConverter() DateTime? from,
      @TimestampConverter() DateTime? to,
      int? repeat,
      @TimestampConverter() DateTime? endDate,
      @TimestampConverter() DateTime? createdAt,
      @TimestampConverter() DateTime? updatedAt,
      String? sameEventId,
      int? number,
      String? calendarId,
      bool? notificationExist,
      String? calendarMonth});
}

/// @nodoc
class __$$EventImplCopyWithImpl<$Res>
    extends _$EventCopyWithImpl<$Res, _$EventImpl>
    implements _$$EventImplCopyWith<$Res> {
  __$$EventImplCopyWithImpl(
      _$EventImpl _value, $Res Function(_$EventImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = freezed,
    Object? title = freezed,
    Object? overview = freezed,
    Object? image = freezed,
    Object? color = freezed,
    Object? url = freezed,
    Object? location = freezed,
    Object? isAllDay = freezed,
    Object? from = freezed,
    Object? to = freezed,
    Object? repeat = freezed,
    Object? endDate = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? sameEventId = freezed,
    Object? number = freezed,
    Object? calendarId = freezed,
    Object? notificationExist = freezed,
    Object? calendarMonth = freezed,
  }) {
    return _then(_$EventImpl(
      uid: freezed == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      overview: freezed == overview
          ? _value.overview
          : overview // ignore: cast_nullable_to_non_nullable
              as String?,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      color: freezed == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as int?,
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
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
      repeat: freezed == repeat
          ? _value.repeat
          : repeat // ignore: cast_nullable_to_non_nullable
              as int?,
      endDate: freezed == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      sameEventId: freezed == sameEventId
          ? _value.sameEventId
          : sameEventId // ignore: cast_nullable_to_non_nullable
              as String?,
      number: freezed == number
          ? _value.number
          : number // ignore: cast_nullable_to_non_nullable
              as int?,
      calendarId: freezed == calendarId
          ? _value.calendarId
          : calendarId // ignore: cast_nullable_to_non_nullable
              as String?,
      notificationExist: freezed == notificationExist
          ? _value.notificationExist
          : notificationExist // ignore: cast_nullable_to_non_nullable
              as bool?,
      calendarMonth: freezed == calendarMonth
          ? _value.calendarMonth
          : calendarMonth // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EventImpl implements _Event {
  const _$EventImpl(
      {this.uid,
      this.title,
      this.overview,
      this.image,
      this.color,
      this.url,
      this.location,
      this.isAllDay,
      @TimestampConverter() this.from,
      @TimestampConverter() this.to,
      this.repeat,
      @TimestampConverter() this.endDate,
      @TimestampConverter() this.createdAt,
      @TimestampConverter() this.updatedAt,
      this.sameEventId,
      this.number,
      this.calendarId,
      this.notificationExist,
      this.calendarMonth});

  factory _$EventImpl.fromJson(Map<String, dynamic> json) =>
      _$$EventImplFromJson(json);

  @override
  final String? uid;
  @override
  final String? title;
  @override
  final String? overview;
  @override
  final String? image;
  @override
  final int? color;
  @override
  final String? url;
  @override
  final String? location;
  @override
  final bool? isAllDay;
  @override
  @TimestampConverter()
  final DateTime? from;
  @override
  @TimestampConverter()
  final DateTime? to;
  @override
  final int? repeat;
  @override
  @TimestampConverter()
  final DateTime? endDate;
  @override
  @TimestampConverter()
  final DateTime? createdAt;
  @override
  @TimestampConverter()
  final DateTime? updatedAt;
  @override
  final String? sameEventId;
  @override
  final int? number;
  @override
  final String? calendarId;
  @override
  final bool? notificationExist;
  @override
  final String? calendarMonth;

  @override
  String toString() {
    return 'Event(uid: $uid, title: $title, overview: $overview, image: $image, color: $color, url: $url, location: $location, isAllDay: $isAllDay, from: $from, to: $to, repeat: $repeat, endDate: $endDate, createdAt: $createdAt, updatedAt: $updatedAt, sameEventId: $sameEventId, number: $number, calendarId: $calendarId, notificationExist: $notificationExist, calendarMonth: $calendarMonth)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EventImpl &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.overview, overview) ||
                other.overview == overview) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.color, color) || other.color == color) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.isAllDay, isAllDay) ||
                other.isAllDay == isAllDay) &&
            (identical(other.from, from) || other.from == from) &&
            (identical(other.to, to) || other.to == to) &&
            (identical(other.repeat, repeat) || other.repeat == repeat) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.sameEventId, sameEventId) ||
                other.sameEventId == sameEventId) &&
            (identical(other.number, number) || other.number == number) &&
            (identical(other.calendarId, calendarId) ||
                other.calendarId == calendarId) &&
            (identical(other.notificationExist, notificationExist) ||
                other.notificationExist == notificationExist) &&
            (identical(other.calendarMonth, calendarMonth) ||
                other.calendarMonth == calendarMonth));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        uid,
        title,
        overview,
        image,
        color,
        url,
        location,
        isAllDay,
        from,
        to,
        repeat,
        endDate,
        createdAt,
        updatedAt,
        sameEventId,
        number,
        calendarId,
        notificationExist,
        calendarMonth
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EventImplCopyWith<_$EventImpl> get copyWith =>
      __$$EventImplCopyWithImpl<_$EventImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EventImplToJson(
      this,
    );
  }
}

abstract class _Event implements Event {
  const factory _Event(
      {final String? uid,
      final String? title,
      final String? overview,
      final String? image,
      final int? color,
      final String? url,
      final String? location,
      final bool? isAllDay,
      @TimestampConverter() final DateTime? from,
      @TimestampConverter() final DateTime? to,
      final int? repeat,
      @TimestampConverter() final DateTime? endDate,
      @TimestampConverter() final DateTime? createdAt,
      @TimestampConverter() final DateTime? updatedAt,
      final String? sameEventId,
      final int? number,
      final String? calendarId,
      final bool? notificationExist,
      final String? calendarMonth}) = _$EventImpl;

  factory _Event.fromJson(Map<String, dynamic> json) = _$EventImpl.fromJson;

  @override
  String? get uid;
  @override
  String? get title;
  @override
  String? get overview;
  @override
  String? get image;
  @override
  int? get color;
  @override
  String? get url;
  @override
  String? get location;
  @override
  bool? get isAllDay;
  @override
  @TimestampConverter()
  DateTime? get from;
  @override
  @TimestampConverter()
  DateTime? get to;
  @override
  int? get repeat;
  @override
  @TimestampConverter()
  DateTime? get endDate;
  @override
  @TimestampConverter()
  DateTime? get createdAt;
  @override
  @TimestampConverter()
  DateTime? get updatedAt;
  @override
  String? get sameEventId;
  @override
  int? get number;
  @override
  String? get calendarId;
  @override
  bool? get notificationExist;
  @override
  String? get calendarMonth;
  @override
  @JsonKey(ignore: true)
  _$$EventImplCopyWith<_$EventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
