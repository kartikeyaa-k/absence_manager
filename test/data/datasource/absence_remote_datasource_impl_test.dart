// ignore_for_file: avoid_redundant_argument_values, depend_on_referenced_packages

import 'package:absence_manager/src/core/utility/date_format_extension.dart';
import 'package:absence_manager/src/data/datasource/absence_remote_datasource_impl.dart';
import 'package:absence_manager/src/domain/entity/absence_entity.dart';
import 'package:absence_manager/src/domain/entity/absence_paginated_response_entity.dart';
import 'package:crewmeister_core/crewmeister_core.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockApiClient extends Mock implements ApiClient {}

void main() {
  final mockClient = MockApiClient();
  final dataSource = AbsenceRemoteDataSourceImpl(mockClient);

  test('returns parsed absence data from ApiClient', () async {
    final mockJson = {
      'data': [
        {
          'id': 1,
          'userId': 123,
          'crewId': 456,
          'startDate': '2025-01-01',
          'endDate': '2025-01-03',
          'type': 'vacation',
          'memberNote': 'Holiday',
          'admitterNote': 'Approved',
          'confirmedAt': '2025-01-01T10:00:00+01:00',
          'rejectedAt': null,
          'admitterId': 1,
          'createdAt': '2024-12-01T09:00:00+01:00',
        },
      ],
      'total': 1,
      'page': 1,
      'limit': 10,
    };

    final mockResponse = Response<Map<String, dynamic>>(
      data: mockJson,
      statusCode: 200,
      requestOptions: RequestOptions(path: '/absences'),
    );

    when(
      () => mockClient.get<Map<String, dynamic>>(
        any(),
        queryParameters: any(named: 'queryParameters'),
      ),
    ).thenAnswer((_) async => mockResponse);

    final result = await dataSource.getAbsences(
      page: 1,
      limit: 10,
      type: null,
      startDate: null,
      endDate: null,
    );

    expect(result, isA<AbsencePaginatedResponseEntity>());
    expect(result.data.first, isA<AbsenceEntity>());
    expect(result.total, equals(1));

    verify(
      () => mockClient.get<Map<String, dynamic>>(
        '/absences',
        queryParameters: {'page': 1, 'limit': 10},
      ),
    ).called(1);
  });

  test('returns empty list when ApiClient response is empty', () async {
    final emptyResponse = Response<List<dynamic>>(
      data: [],
      statusCode: 200,
      requestOptions: RequestOptions(path: '/absences'),
    );

    when(
      () => mockClient.get<List<dynamic>>(
        any(),
        queryParameters: any(named: 'queryParameters'),
      ),
    ).thenAnswer((_) async => emptyResponse);

    final result = await dataSource.getAbsencesByUser(123);

    expect(result, isEmpty);

    verify(
      () => mockClient.get<List<dynamic>>(
        '/absences',
        queryParameters: {'userId': 123},
      ),
    ).called(1);
  });

  test('returns user-specific absence list from ApiClient', () async {
    final mockListResponse = Response<List<dynamic>>(
      data: [
        {
          'id': 1,
          'userId': 123,
          'crewId': 456,
          'startDate': '2025-01-01',
          'endDate': '2025-01-03',
          'type': 'vacation',
          'memberNote': 'Holiday',
          'admitterNote': 'Approved',
          'confirmedAt': '2025-01-01T10:00:00+01:00',
          'rejectedAt': null,
          'admitterId': 1,
          'createdAt': '2024-12-01T09:00:00+01:00',
        },
      ],
      statusCode: 200,
      requestOptions: RequestOptions(path: '/absences'),
    );

    when(
      () => mockClient.get<List<dynamic>>(
        any(),
        queryParameters: any(named: 'queryParameters'),
      ),
    ).thenAnswer((_) async => mockListResponse);

    final result = await dataSource.getAbsencesByUser(123);

    expect(result, isA<List<AbsenceEntity>>());
    expect(result.length, 1);

    verify(
      () => mockClient.get<List<dynamic>>(
        '/absences',
        queryParameters: {'userId': 123},
      ),
    ).called(1);
  });

  test('sends correct query params when all filters are provided', () async {
    final mockJson = {'data': [], 'total': 0, 'page': 1, 'limit': 10};

    final mockResponse = Response<Map<String, dynamic>>(
      data: mockJson,
      statusCode: 200,
      requestOptions: RequestOptions(path: '/absences'),
    );

    final startDate = DateTime(2025, 1, 1);
    final endDate = DateTime(2025, 1, 5);

    when(
      () => mockClient.get<Map<String, dynamic>>(
        any(),
        queryParameters: any(named: 'queryParameters'),
      ),
    ).thenAnswer((_) async => mockResponse);

    final result = await dataSource.getAbsences(
      page: 1,
      limit: 10,
      type: 'vacation',
      startDate: startDate,
      endDate: endDate,
    );

    expect(result.total, equals(0));

    verify(
      () => mockClient.get<Map<String, dynamic>>(
        '/absences',
        queryParameters: {
          'page': 1,
          'limit': 10,
          'type': 'vacation',
          'startDate': startDate.formatAsDateOnly,
          'endDate': endDate.formatAsDateOnly,
        },
      ),
    ).called(1);
  });
}
