import 'package:absence_manager/src/domain/entity/absence_entity.dart';

class PaginatedAbsenceResult {
  final int total;
  final int page;
  final int limit;
  final List<AbsenceEntity> data;

  PaginatedAbsenceResult({
    required this.total,
    required this.page,
    required this.limit,
    required this.data,
  });
}
