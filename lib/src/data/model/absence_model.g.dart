// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'absence_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AbsenceModel _$AbsenceModelFromJson(Map<String, dynamic> json) => AbsenceModel(
  id: (json['id'] as num).toInt(),
  crewId: (json['crewId'] as num).toInt(),
  userId: (json['userId'] as num).toInt(),
  type: json['type'] as String,
  admitterNote: json['admitterNote'] as String?,
  memberNote: json['memberNote'] as String?,
  startDate: json['startDate'] as String,
  endDate: json['endDate'] as String,
  confirmedAt: json['confirmedAt'] as String?,
  rejectedAt: json['rejectedAt'] as String?,
  createdAt: json['createdAt'] as String,
  memberName: json['memberName'] as String?,
  memberImage: json['memberImage'] as String?,
);

Map<String, dynamic> _$AbsenceModelToJson(AbsenceModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'crewId': instance.crewId,
      'userId': instance.userId,
      'type': instance.type,
      'admitterNote': instance.admitterNote,
      'memberNote': instance.memberNote,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'confirmedAt': instance.confirmedAt,
      'rejectedAt': instance.rejectedAt,
      'createdAt': instance.createdAt,
      'memberName': instance.memberName,
      'memberImage': instance.memberImage,
    };
