class AbsenceEntity {
  final int id;
  final int userId;
  final String type;
  final String? admitterNote;
  final String? memberNote;
  final DateTime startDate;
  final DateTime endDate;
  final DateTime? createdAt;
  final DateTime? confirmedAt;
  final DateTime? rejectedAt;
  final String memberName;
  final String memberImage;

  AbsenceEntity({
    required this.id,
    required this.userId,
    required this.type,
    required this.startDate,
    required this.endDate,
    required this.memberName,
    required this.memberImage,
    this.admitterNote,
    this.memberNote,
    this.createdAt,
    this.confirmedAt,
    this.rejectedAt,
  });
}
