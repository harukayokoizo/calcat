// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'task.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Task _$TaskFromJson(Map<String, dynamic> json) {
  return _Task.fromJson(json);
}

/// @nodoc
mixin _$Task {
  String? get task => throw _privateConstructorUsedError;
  String? get user => throw _privateConstructorUsedError;
  bool? get check => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get created => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get updated => throw _privateConstructorUsedError;
  String? get todoId => throw _privateConstructorUsedError;
  String? get calendarId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TaskCopyWith<Task> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TaskCopyWith<$Res> {
  factory $TaskCopyWith(Task value, $Res Function(Task) then) =
      _$TaskCopyWithImpl<$Res, Task>;
  @useResult
  $Res call(
      {String? task,
      String? user,
      bool? check,
      @TimestampConverter() DateTime? created,
      @TimestampConverter() DateTime? updated,
      String? todoId,
      String? calendarId});
}

/// @nodoc
class _$TaskCopyWithImpl<$Res, $Val extends Task>
    implements $TaskCopyWith<$Res> {
  _$TaskCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? task = freezed,
    Object? user = freezed,
    Object? check = freezed,
    Object? created = freezed,
    Object? updated = freezed,
    Object? todoId = freezed,
    Object? calendarId = freezed,
  }) {
    return _then(_value.copyWith(
      task: freezed == task
          ? _value.task
          : task // ignore: cast_nullable_to_non_nullable
              as String?,
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as String?,
      check: freezed == check
          ? _value.check
          : check // ignore: cast_nullable_to_non_nullable
              as bool?,
      created: freezed == created
          ? _value.created
          : created // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updated: freezed == updated
          ? _value.updated
          : updated // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      todoId: freezed == todoId
          ? _value.todoId
          : todoId // ignore: cast_nullable_to_non_nullable
              as String?,
      calendarId: freezed == calendarId
          ? _value.calendarId
          : calendarId // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TaskImplCopyWith<$Res> implements $TaskCopyWith<$Res> {
  factory _$$TaskImplCopyWith(
          _$TaskImpl value, $Res Function(_$TaskImpl) then) =
      __$$TaskImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? task,
      String? user,
      bool? check,
      @TimestampConverter() DateTime? created,
      @TimestampConverter() DateTime? updated,
      String? todoId,
      String? calendarId});
}

/// @nodoc
class __$$TaskImplCopyWithImpl<$Res>
    extends _$TaskCopyWithImpl<$Res, _$TaskImpl>
    implements _$$TaskImplCopyWith<$Res> {
  __$$TaskImplCopyWithImpl(_$TaskImpl _value, $Res Function(_$TaskImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? task = freezed,
    Object? user = freezed,
    Object? check = freezed,
    Object? created = freezed,
    Object? updated = freezed,
    Object? todoId = freezed,
    Object? calendarId = freezed,
  }) {
    return _then(_$TaskImpl(
      task: freezed == task
          ? _value.task
          : task // ignore: cast_nullable_to_non_nullable
              as String?,
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as String?,
      check: freezed == check
          ? _value.check
          : check // ignore: cast_nullable_to_non_nullable
              as bool?,
      created: freezed == created
          ? _value.created
          : created // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updated: freezed == updated
          ? _value.updated
          : updated // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      todoId: freezed == todoId
          ? _value.todoId
          : todoId // ignore: cast_nullable_to_non_nullable
              as String?,
      calendarId: freezed == calendarId
          ? _value.calendarId
          : calendarId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TaskImpl implements _Task {
  const _$TaskImpl(
      {this.task,
      this.user,
      this.check,
      @TimestampConverter() this.created,
      @TimestampConverter() this.updated,
      this.todoId,
      this.calendarId});

  factory _$TaskImpl.fromJson(Map<String, dynamic> json) =>
      _$$TaskImplFromJson(json);

  @override
  final String? task;
  @override
  final String? user;
  @override
  final bool? check;
  @override
  @TimestampConverter()
  final DateTime? created;
  @override
  @TimestampConverter()
  final DateTime? updated;
  @override
  final String? todoId;
  @override
  final String? calendarId;

  @override
  String toString() {
    return 'Task(task: $task, user: $user, check: $check, created: $created, updated: $updated, todoId: $todoId, calendarId: $calendarId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TaskImpl &&
            (identical(other.task, task) || other.task == task) &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.check, check) || other.check == check) &&
            (identical(other.created, created) || other.created == created) &&
            (identical(other.updated, updated) || other.updated == updated) &&
            (identical(other.todoId, todoId) || other.todoId == todoId) &&
            (identical(other.calendarId, calendarId) ||
                other.calendarId == calendarId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, task, user, check, created, updated, todoId, calendarId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TaskImplCopyWith<_$TaskImpl> get copyWith =>
      __$$TaskImplCopyWithImpl<_$TaskImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TaskImplToJson(
      this,
    );
  }
}

abstract class _Task implements Task {
  const factory _Task(
      {final String? task,
      final String? user,
      final bool? check,
      @TimestampConverter() final DateTime? created,
      @TimestampConverter() final DateTime? updated,
      final String? todoId,
      final String? calendarId}) = _$TaskImpl;

  factory _Task.fromJson(Map<String, dynamic> json) = _$TaskImpl.fromJson;

  @override
  String? get task;
  @override
  String? get user;
  @override
  bool? get check;
  @override
  @TimestampConverter()
  DateTime? get created;
  @override
  @TimestampConverter()
  DateTime? get updated;
  @override
  String? get todoId;
  @override
  String? get calendarId;
  @override
  @JsonKey(ignore: true)
  _$$TaskImplCopyWith<_$TaskImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
