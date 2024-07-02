import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../common_widgets/application/timestamp_converter.dart';

part 'search_page.freezed.dart';
part 'search_page.g.dart';

@freezed
abstract class SearchPage with _$SearchPage{
  const factory SearchPage({
    bool? result,
    bool? editing,
    String? text,
    String? selectedText,
  }) = _SearchPage;

  factory SearchPage.fromJson(Map<String,dynamic> json) => _$SearchPageFromJson(json);
}