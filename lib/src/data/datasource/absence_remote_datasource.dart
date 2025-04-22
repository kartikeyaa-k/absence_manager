import 'package:absence_manager/src/domain/entity/absence_entity.dart';
import 'package:absence_manager/src/domain/entity/absence_paginated_response_entity.dart';

abstract class AbsenceRemoteDataSource {
  Future<AbsencePaginatedResponseEntity> getAbsences({
    int page = 1,
    int limit = 10,
    String? type,
    DateTime? startDate,
    DateTime? endDate,
  });

  Future<List<AbsenceEntity>> getAbsencesByUser(int userId);
}
