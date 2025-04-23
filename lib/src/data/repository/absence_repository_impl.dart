import 'package:absence_manager/src/data/datasource/absence_remote_datasource.dart';
import 'package:absence_manager/src/domain/entity/absence_paginated_response_entity.dart';
import 'package:absence_manager/src/domain/repository/absence_repository.dart';

class AbsenceRepositoryImpl implements AbsenceRepository {
  final AbsenceRemoteDataSource remoteDataSource;

  AbsenceRepositoryImpl(this.remoteDataSource);

  @override
  Future<AbsencePaginatedResponseEntity> getAbsences({
    required int page,
    required int limit,
    String? type,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    final res = await remoteDataSource.getAbsences(
      page: page,
      limit: limit,
      type: type,
      startDate: startDate,
      endDate: endDate,
    );
    return res;
  }
}
