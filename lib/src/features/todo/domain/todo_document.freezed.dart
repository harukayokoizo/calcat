// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'todo_document.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TodoDocument _$TodoDocumentFromJson(Map<String, dynamic> json) {
  return _TodoDocument.fromJson(json);
}

/// @nodoc
mixin _$TodoDocument {
  Todo? get todo => throw _privateConstructorUsedError;
  String? get docId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TodoDocumentCopyWith<TodoDocument> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TodoDocumentCopyWith<$Res> {
  factory $TodoDocumentCopyWith(
          TodoDocument value, $Res Function(TodoDocument) then) =
      _$TodoDocumentCopyWithImpl<$Res, TodoDocument>;
  @useResult
  $Res call({Todo? todo, String? docId});

  $TodoCopyWith<$Res>? get todo;
}

/// @nodoc
class _$TodoDocumentCopyWithImpl<$Res, $Val extends TodoDocument>
    implements $TodoDocumentCopyWith<$Res> {
  _$TodoDocumentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? todo = freezed,
    Object? docId = freezed,
  }) {
    return _then(_value.copyWith(
      todo: freezed == todo
          ? _value.todo
          : todo // ignore: cast_nullable_to_non_nullable
              as Todo?,
      docId: freezed == docId
          ? _value.docId
          : docId // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $TodoCopyWith<$Res>? get todo {
    if (_value.todo == null) {
      return null;
    }

    return $TodoCopyWith<$Res>(_value.todo!, (value) {
      return _then(_value.copyWith(todo: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TodoDocumentImplCopyWith<$Res>
    implements $TodoDocumentCopyWith<$Res> {
  factory _$$TodoDocumentImplCopyWith(
          _$TodoDocumentImpl value, $Res Function(_$TodoDocumentImpl) then) =
      __$$TodoDocumentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Todo? todo, String? docId});

  @override
  $TodoCopyWith<$Res>? get todo;
}

/// @nodoc
class __$$TodoDocumentImplCopyWithImpl<$Res>
    extends _$TodoDocumentCopyWithImpl<$Res, _$TodoDocumentImpl>
    implements _$$TodoDocumentImplCopyWith<$Res> {
  __$$TodoDocumentImplCopyWithImpl(
      _$TodoDocumentImpl _value, $Res Function(_$TodoDocumentImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? todo = freezed,
    Object? docId = freezed,
  }) {
    return _then(_$TodoDocumentImpl(
      todo: freezed == todo
          ? _value.todo
          : todo // ignore: cast_nullable_to_non_nullable
              as Todo?,
      docId: freezed == docId
          ? _value.docId
          : docId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TodoDocumentImpl implements _TodoDocument {
  const _$TodoDocumentImpl({this.todo, this.docId});

  factory _$TodoDocumentImpl.fromJson(Map<String, dynamic> json) =>
      _$$TodoDocumentImplFromJson(json);

  @override
  final Todo? todo;
  @override
  final String? docId;

  @override
  String toString() {
    return 'TodoDocument(todo: $todo, docId: $docId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TodoDocumentImpl &&
            (identical(other.todo, todo) || other.todo == todo) &&
            (identical(other.docId, docId) || other.docId == docId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, todo, docId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TodoDocumentImplCopyWith<_$TodoDocumentImpl> get copyWith =>
      __$$TodoDocumentImplCopyWithImpl<_$TodoDocumentImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TodoDocumentImplToJson(
      this,
    );
  }
}

abstract class _TodoDocument implements TodoDocument {
  const factory _TodoDocument({final Todo? todo, final String? docId}) =
      _$TodoDocumentImpl;

  factory _TodoDocument.fromJson(Map<String, dynamic> json) =
      _$TodoDocumentImpl.fromJson;

  @override
  Todo? get todo;
  @override
  String? get docId;
  @override
  @JsonKey(ignore: true)
  _$$TodoDocumentImplCopyWith<_$TodoDocumentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
