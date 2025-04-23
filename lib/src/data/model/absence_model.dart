import 'package:absence_manager/src/data/helper/to_entity_mixin.dart';
import 'package:absence_manager/src/domain/entity/absence_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'absence_model.g.dart';

@JsonSerializable()
class AbsenceModel with ToEntity<AbsenceEntity> {
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

  @override
  AbsenceEntity toEntity() {
    return AbsenceEntity(
      id: id,
      userId: userId,
      type: type,
      admitterNote: admitterNote,
      memberNote: memberNote,
      startDate: DateTime.parse(startDate),
      endDate: DateTime.parse(endDate),
      createdAt: DateTime.tryParse(createdAt),
      confirmedAt: confirmedAt != null ? DateTime.tryParse(confirmedAt!) : null,
      rejectedAt: rejectedAt != null ? DateTime.tryParse(rejectedAt!) : null,
      memberName: memberName ?? '',
      memberImage: memberImage ?? '',
    );
  }
}
