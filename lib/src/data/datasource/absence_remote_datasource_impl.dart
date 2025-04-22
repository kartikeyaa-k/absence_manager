import 'package:absence_manager/src/core/utility/date_format_extension.dart';
import 'package:absence_manager/src/data/datasource/absence_remote_datasource.dart';
import 'package:absence_manager/src/data/model/absence_model.dart';
import 'package:absence_manager/src/data/model/absence_paginated_response_model.dart';
import 'package:absence_manager/src/domain/entity/absence_entity.dart';
import 'package:absence_manager/src/domain/entity/absence_paginated_response_entity.dart';
import 'package:crewmeister_core/crewmeister_core.dart';

/// Implementation of [AbsenceRemoteDataSource] responsible for communicating with
/// the backend API to fetch absence-related data.
///
/// This class uses [ApiClient] to perform HTTP requests and parses the responses
/// into domain entities via the model layer (`AbsenceModel`, `AbsencePaginatedResponseModel`).
///
/// ### Current endpoints:
/// - `GET /absences?page=1&limit=10` → returns paginated absences
/// - `GET /absences?userId=<id>` → returns absences filtered by user
///
/// ### Notes:
/// - In the future, the endpoint paths can be extracted into a shared `api_endpoints.dart`.
/// - This is intentionally a direct mapping layer; if response transformation grows complex,
///   a dedicated mapper or transformer class can be introduced to keep this class focused on networking.
/// - The empty responses can be handled in a separate way.
///
/// This design keeps things simple and explicit for now, while still allowing
/// for easy refactoring in the future.
class AbsenceRemoteDataSourceImpl implements AbsenceRemoteDataSource {
  AbsenceRemoteDataSourceImpl(this._client);

  final ApiClient _client;

  @override
  Future<AbsencePaginatedResponseEntity> getAbsences({
    int page = 1,
    int limit = 10,
    String? type,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    final queryParams = <String, dynamic>{
      'page': page,
      'limit': limit,
      if (type != null && type.isNotEmpty) 'type': type,
      if (startDate != null) 'startDate': startDate.formatAsDateOnly,
      if (endDate != null) 'endDate': endDate.formatAsDateOnly,
    };

    final response = await _client.get<Map<String, dynamic>>(
      '/absences',
      queryParameters: queryParams,
    );

    final model = AbsencePaginatedResponseModel.fromJson(response.data ?? {});
    return model.toEntity();
  }

  @override
  Future<List<AbsenceEntity>> getAbsencesByUser(int userId) async {
    final response = await _client.get<List<dynamic>>(
      '/absences',
      queryParameters: {'userId': userId},
    );
    if (response.data == null || response.data!.isEmpty) {
      return [];
    }
    return response.data!
        .map(
          (json) =>
              AbsenceModel.fromJson(json as Map<String, dynamic>).toEntity(),
        )
        .toList();
  }
}
