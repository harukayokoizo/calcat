// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'search_page.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SearchPage _$SearchPageFromJson(Map<String, dynamic> json) {
  return _SearchPage.fromJson(json);
}

/// @nodoc
mixin _$SearchPage {
  bool? get result => throw _privateConstructorUsedError;
  bool? get editing => throw _privateConstructorUsedError;
  String? get text => throw _privateConstructorUsedError;
  String? get selectedText => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SearchPageCopyWith<SearchPage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SearchPageCopyWith<$Res> {
  factory $SearchPageCopyWith(
          SearchPage value, $Res Function(SearchPage) then) =
      _$SearchPageCopyWithImpl<$Res, SearchPage>;
  @useResult
  $Res call({bool? result, bool? editing, String? text, String? selectedText});
}

/// @nodoc
class _$SearchPageCopyWithImpl<$Res, $Val extends SearchPage>
    implements $SearchPageCopyWith<$Res> {
  _$SearchPageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? result = freezed,
    Object? editing = freezed,
    Object? text = freezed,
    Object? selectedText = freezed,
  }) {
    return _then(_value.copyWith(
      result: freezed == result
          ? _value.result
          : result // ignore: cast_nullable_to_non_nullable
              as bool?,
      editing: freezed == editing
          ? _value.editing
          : editing // ignore: cast_nullable_to_non_nullable
              as bool?,
      text: freezed == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String?,
      selectedText: freezed == selectedText
          ? _value.selectedText
          : selectedText // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SearchPageImplCopyWith<$Res>
    implements $SearchPageCopyWith<$Res> {
  factory _$$SearchPageImplCopyWith(
          _$SearchPageImpl value, $Res Function(_$SearchPageImpl) then) =
      __$$SearchPageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool? result, bool? editing, String? text, String? selectedText});
}

/// @nodoc
class __$$SearchPageImplCopyWithImpl<$Res>
    extends _$SearchPageCopyWithImpl<$Res, _$SearchPageImpl>
    implements _$$SearchPageImplCopyWith<$Res> {
  __$$SearchPageImplCopyWithImpl(
      _$SearchPageImpl _value, $Res Function(_$SearchPageImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? result = freezed,
    Object? editing = freezed,
    Object? text = freezed,
    Object? selectedText = freezed,
  }) {
    return _then(_$SearchPageImpl(
      result: freezed == result
          ? _value.result
          : result // ignore: cast_nullable_to_non_nullable
              as bool?,
      editing: freezed == editing
          ? _value.editing
          : editing // ignore: cast_nullable_to_non_nullable
              as bool?,
      text: freezed == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String?,
      selectedText: freezed == selectedText
          ? _value.selectedText
          : selectedText // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SearchPageImpl implements _SearchPage {
  const _$SearchPageImpl(
      {this.result, this.editing, this.text, this.selectedText});

  factory _$SearchPageImpl.fromJson(Map<String, dynamic> json) =>
      _$$SearchPageImplFromJson(json);

  @override
  final bool? result;
  @override
  final bool? editing;
  @override
  final String? text;
  @override
  final String? selectedText;

  @override
  String toString() {
    return 'SearchPage(result: $result, editing: $editing, text: $text, selectedText: $selectedText)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SearchPageImpl &&
            (identical(other.result, result) || other.result == result) &&
            (identical(other.editing, editing) || other.editing == editing) &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.selectedText, selectedText) ||
                other.selectedText == selectedText));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, result, editing, text, selectedText);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SearchPageImplCopyWith<_$SearchPageImpl> get copyWith =>
      __$$SearchPageImplCopyWithImpl<_$SearchPageImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SearchPageImplToJson(
      this,
    );
  }
}

abstract class _SearchPage implements SearchPage {
  const factory _SearchPage(
      {final bool? result,
      final bool? editing,
      final String? text,
      final String? selectedText}) = _$SearchPageImpl;

  factory _SearchPage.fromJson(Map<String, dynamic> json) =
      _$SearchPageImpl.fromJson;

  @override
  bool? get result;
  @override
  bool? get editing;
  @override
  String? get text;
  @override
  String? get selectedText;
  @override
  @JsonKey(ignore: true)
  _$$SearchPageImplCopyWith<_$SearchPageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
