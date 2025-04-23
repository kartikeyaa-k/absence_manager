import 'package:absence_manager/src/domain/entity/absence_entity.dart';

class AbsencePaginatedResponseEntity {
  final int total;
  final int page;
  final int limit;
  final List<AbsenceEntity> data;

  AbsencePaginatedResponseEntity({
    required this.total,
    required this.page,
    required this.limit,
    required this.data,
  });
}
