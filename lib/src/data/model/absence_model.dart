import 'package:json_annotation/json_annotation.dart';

part 'absence_model.g.dart';

@JsonSerializable()
class AbsenceModel {
  final int id;
  final int crewId;
  final int userId;
  final String type;
  final String? admitterNote;
  final String? memberNote;
  final String startDate;
  final String endDate;
  final String? confirmedAt;
  final String? rejectedAt;
  final String createdAt;

  /// Enriched fields
  final String? memberName;
  final String? memberImage;

  AbsenceModel({
    required this.id,
    required this.crewId,
    required this.userId,
    required this.type,
    this.admitterNote,
    this.memberNote,
    required this.startDate,
    required this.endDate,
    this.confirmedAt,
    this.rejectedAt,
    required this.createdAt,
    this.memberName,
    this.memberImage,
  });

  factory AbsenceModel.fromJson(Map<String, dynamic> json) =>
      _$AbsenceModelFromJson(json);

  Map<String, dynamic> toJson() => _$AbsenceModelToJson(this);
}
