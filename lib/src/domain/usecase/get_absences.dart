import 'package:absence_manager/src/domain/entity/absence_paginated_response_entity.dart';
import 'package:absence_manager/src/domain/repository/absence_repository.dart';

/// Use case for fetching paginated absences.
class GetAbsences {
  final AbsenceRepository _repository;

  GetAbsences(this._repository);

  Future<AbsencePaginatedResponseEntity> call({
    required int page,
    required int limit,
  }) {
    return _repository.getAbsences(page: page, limit: limit);
  }
}
