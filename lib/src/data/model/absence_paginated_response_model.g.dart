// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'absence_paginated_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AbsencePaginatedResponseModel _$AbsencePaginatedResponseModelFromJson(
  Map<String, dynamic> json,
) => AbsencePaginatedResponseModel(
  total: (json['total'] as num).toInt(),
  page: (json['page'] as num).toInt(),
  limit: (json['limit'] as num).toInt(),
  data:
      (json['data'] as List<dynamic>)
          .map((e) => AbsenceModel.fromJson(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$AbsencePaginatedResponseModelToJson(
  AbsencePaginatedResponseModel instance,
) => <String, dynamic>{
  'total': instance.total,
  'page': instance.page,
  'limit': instance.limit,
  'data': instance.data,
};
