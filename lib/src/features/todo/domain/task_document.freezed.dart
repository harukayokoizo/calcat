// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'task_document.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TaskDocument _$TaskDocumentFromJson(Map<String, dynamic> json) {
  return _TaskDocument.fromJson(json);
}

/// @nodoc
mixin _$TaskDocument {
  Task? get task => throw _privateConstructorUsedError;
  String? get docId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TaskDocumentCopyWith<TaskDocument> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TaskDocumentCopyWith<$Res> {
  factory $TaskDocumentCopyWith(
          TaskDocument value, $Res Function(TaskDocument) then) =
      _$TaskDocumentCopyWithImpl<$Res, TaskDocument>;
  @useResult
  $Res call({Task? task, String? docId});

  $TaskCopyWith<$Res>? get task;
}

/// @nodoc
class _$TaskDocumentCopyWithImpl<$Res, $Val extends TaskDocument>
    implements $TaskDocumentCopyWith<$Res> {
  _$TaskDocumentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? task = freezed,
    Object? docId = freezed,
  }) {
    return _then(_value.copyWith(
      task: freezed == task
          ? _value.task
          : task // ignore: cast_nullable_to_non_nullable
              as Task?,
      docId: freezed == docId
          ? _value.docId
          : docId // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $TaskCopyWith<$Res>? get task {
    if (_value.task == null) {
      return null;
    }

    return $TaskCopyWith<$Res>(_value.task!, (value) {
      return _then(_value.copyWith(task: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TaskDocumentImplCopyWith<$Res>
    implements $TaskDocumentCopyWith<$Res> {
  factory _$$TaskDocumentImplCopyWith(
          _$TaskDocumentImpl value, $Res Function(_$TaskDocumentImpl) then) =
      __$$TaskDocumentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Task? task, String? docId});

  @override
  $TaskCopyWith<$Res>? get task;
}

/// @nodoc
class __$$TaskDocumentImplCopyWithImpl<$Res>
    extends _$TaskDocumentCopyWithImpl<$Res, _$TaskDocumentImpl>
    implements _$$TaskDocumentImplCopyWith<$Res> {
  __$$TaskDocumentImplCopyWithImpl(
      _$TaskDocumentImpl _value, $Res Function(_$TaskDocumentImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? task = freezed,
    Object? docId = freezed,
  }) {
    return _then(_$TaskDocumentImpl(
      task: freezed == task
          ? _value.task
          : task // ignore: cast_nullable_to_non_nullable
              as Task?,
      docId: freezed == docId
          ? _value.docId
          : docId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TaskDocumentImpl implements _TaskDocument {
  const _$TaskDocumentImpl({this.task, this.docId});

  factory _$TaskDocumentImpl.fromJson(Map<String, dynamic> json) =>
      _$$TaskDocumentImplFromJson(json);

  @override
  final Task? task;
  @override
  final String? docId;

  @override
  String toString() {
    return 'TaskDocument(task: $task, docId: $docId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TaskDocumentImpl &&
            (identical(other.task, task) || other.task == task) &&
            (identical(other.docId, docId) || other.docId == docId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, task, docId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TaskDocumentImplCopyWith<_$TaskDocumentImpl> get copyWith =>
      __$$TaskDocumentImplCopyWithImpl<_$TaskDocumentImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TaskDocumentImplToJson(
      this,
    );
  }
}

abstract class _TaskDocument implements TaskDocument {
  const factory _TaskDocument({final Task? task, final String? docId}) =
      _$TaskDocumentImpl;

  factory _TaskDocument.fromJson(Map<String, dynamic> json) =
      _$TaskDocumentImpl.fromJson;

  @override
  Task? get task;
  @override
  String? get docId;
  @override
  @JsonKey(ignore: true)
  _$$TaskDocumentImplCopyWith<_$TaskDocumentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
