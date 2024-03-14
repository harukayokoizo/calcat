// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'calendar.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Calendar _$CalendarFromJson(Map<String, dynamic> json) {
  return _Calendar.fromJson(json);
}

/// @nodoc
mixin _$Calendar {
  String? get author => throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get image => throw _privateConstructorUsedError;
  bool? get publicPreference => throw _privateConstructorUsedError;
  String? get password => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get created => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get updated => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CalendarCopyWith<Calendar> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CalendarCopyWith<$Res> {
  factory $CalendarCopyWith(Calendar value, $Res Function(Calendar) then) =
      _$CalendarCopyWithImpl<$Res, Calendar>;
  @useResult
  $Res call(
      {String? author,
      String? title,
      String? description,
      String? image,
      bool? publicPreference,
      String? password,
      @TimestampConverter() DateTime? created,
      @TimestampConverter() DateTime? updated});
}

/// @nodoc
class _$CalendarCopyWithImpl<$Res, $Val extends Calendar>
    implements $CalendarCopyWith<$Res> {
  _$CalendarCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? author = freezed,
    Object? title = freezed,
    Object? description = freezed,
    Object? image = freezed,
    Object? publicPreference = freezed,
    Object? password = freezed,
    Object? created = freezed,
    Object? updated = freezed,
  }) {
    return _then(_value.copyWith(
      author: freezed == author
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as String?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      publicPreference: freezed == publicPreference
          ? _value.publicPreference
          : publicPreference // ignore: cast_nullable_to_non_nullable
              as bool?,
      password: freezed == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String?,
      created: freezed == created
          ? _value.created
          : created // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updated: freezed == updated
          ? _value.updated
          : updated // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CalendarImplCopyWith<$Res>
    implements $CalendarCopyWith<$Res> {
  factory _$$CalendarImplCopyWith(
          _$CalendarImpl value, $Res Function(_$CalendarImpl) then) =
      __$$CalendarImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? author,
      String? title,
      String? description,
      String? image,
      bool? publicPreference,
      String? password,
      @TimestampConverter() DateTime? created,
      @TimestampConverter() DateTime? updated});
}

/// @nodoc
class __$$CalendarImplCopyWithImpl<$Res>
    extends _$CalendarCopyWithImpl<$Res, _$CalendarImpl>
    implements _$$CalendarImplCopyWith<$Res> {
  __$$CalendarImplCopyWithImpl(
      _$CalendarImpl _value, $Res Function(_$CalendarImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? author = freezed,
    Object? title = freezed,
    Object? description = freezed,
    Object? image = freezed,
    Object? publicPreference = freezed,
    Object? password = freezed,
    Object? created = freezed,
    Object? updated = freezed,
  }) {
    return _then(_$CalendarImpl(
      author: freezed == author
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as String?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      publicPreference: freezed == publicPreference
          ? _value.publicPreference
          : publicPreference // ignore: cast_nullable_to_non_nullable
              as bool?,
      password: freezed == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String?,
      created: freezed == created
          ? _value.created
          : created // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updated: freezed == updated
          ? _value.updated
          : updated // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CalendarImpl implements _Calendar {
  const _$CalendarImpl(
      {this.author,
      this.title,
      this.description,
      this.image,
      this.publicPreference,
      this.password,
      @TimestampConverter() this.created,
      @TimestampConverter() this.updated});

  factory _$CalendarImpl.fromJson(Map<String, dynamic> json) =>
      _$$CalendarImplFromJson(json);

  @override
  final String? author;
  @override
  final String? title;
  @override
  final String? description;
  @override
  final String? image;
  @override
  final bool? publicPreference;
  @override
  final String? password;
  @override
  @TimestampConverter()
  final DateTime? created;
  @override
  @TimestampConverter()
  final DateTime? updated;

  @override
  String toString() {
    return 'Calendar(author: $author, title: $title, description: $description, image: $image, publicPreference: $publicPreference, password: $password, created: $created, updated: $updated)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CalendarImpl &&
            (identical(other.author, author) || other.author == author) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.publicPreference, publicPreference) ||
                other.publicPreference == publicPreference) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.created, created) || other.created == created) &&
            (identical(other.updated, updated) || other.updated == updated));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, author, title, description,
      image, publicPreference, password, created, updated);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CalendarImplCopyWith<_$CalendarImpl> get copyWith =>
      __$$CalendarImplCopyWithImpl<_$CalendarImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CalendarImplToJson(
      this,
    );
  }
}

abstract class _Calendar implements Calendar {
  const factory _Calendar(
      {final String? author,
      final String? title,
      final String? description,
      final String? image,
      final bool? publicPreference,
      final String? password,
      @TimestampConverter() final DateTime? created,
      @TimestampConverter() final DateTime? updated}) = _$CalendarImpl;

  factory _Calendar.fromJson(Map<String, dynamic> json) =
      _$CalendarImpl.fromJson;

  @override
  String? get author;
  @override
  String? get title;
  @override
  String? get description;
  @override
  String? get image;
  @override
  bool? get publicPreference;
  @override
  String? get password;
  @override
  @TimestampConverter()
  DateTime? get created;
  @override
  @TimestampConverter()
  DateTime? get updated;
  @override
  @JsonKey(ignore: true)
  _$$CalendarImplCopyWith<_$CalendarImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
