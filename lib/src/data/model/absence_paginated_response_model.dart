import 'package:json_annotation/json_annotation.dart';
import 'package:absence_manager/src/data/model/absence_model.dart';

part 'absence_paginated_response_model.g.dart';

@JsonSerializable()
class AbsencePaginatedResponseModel {
  final int total;
  final int page;
  final int limit;
  final List<AbsenceModel> data;

  AbsencePaginatedResponseModel({
    required this.total,
    required this.page,
    required this.limit,
    required this.data,
  });

  factory AbsencePaginatedResponseModel.fromJson(Map<String, dynamic> json) =>
      _$AbsencePaginatedResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$AbsencePaginatedResponseModelToJson(this);
}
