import 'package:absence_manager/src/domain/entity/absence_paginated_response_entity.dart';

abstract class AbsenceRepository {
  Future<AbsencePaginatedResponseEntity> getAbsences({
    required int page,
    required int limit,
    String? type,
    DateTime? startDate,
    DateTime? endDate,
  });
}
