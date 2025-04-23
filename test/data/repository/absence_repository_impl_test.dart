// ignore_for_file: avoid_redundant_argument_values

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:absence_manager/src/data/repository/absence_repository_impl.dart';
import 'package:absence_manager/src/data/datasource/absence_remote_datasource.dart';
import 'package:absence_manager/src/domain/entity/absence_paginated_response_entity.dart';
import 'package:absence_manager/src/domain/entity/absence_entity.dart';

class MockAbsenceRemoteDataSource extends Mock
    implements AbsenceRemoteDataSource {}

void main() {
  late AbsenceRepositoryImpl repository;
  late MockAbsenceRemoteDataSource mockDataSource;

  setUp(() {
    mockDataSource = MockAbsenceRemoteDataSource();
    repository = AbsenceRepositoryImpl(mockDataSource);
  });

  test(
    'calls dataSource.getAbsences and returns the correct response',
    () async {
      final mockResponse = AbsencePaginatedResponseEntity(
        data: [
          AbsenceEntity(
            id: 1,
            userId: 123,
            startDate: DateTime(2025, 01, 01),
            endDate: DateTime(2025, 01, 03),
            type: 'vacation',
            memberNote: 'Holiday',
            admitterNote: 'Approved',
            confirmedAt: DateTime(2025, 01, 01, 10, 0),
            rejectedAt: null,
            createdAt: DateTime(2024, 12, 01, 9, 0),
            memberName: '',
            memberImage: '',
          ),
        ],
        total: 1,
        page: 1,
        limit: 10,
      );

      when(
        () => mockDataSource.getAbsences(
          page: 1,
          limit: 10,
          type: null,
          startDate: null,
          endDate: null,
        ),
      ).thenAnswer((_) async => mockResponse);

      final result = await repository.getAbsences(page: 1, limit: 10);

      expect(result.total, equals(1));
      expect(result.data.length, equals(1));
      expect(result.data.first.type, equals('vacation'));

      verify(
        () => mockDataSource.getAbsences(
          page: 1,
          limit: 10,
          type: null,
          startDate: null,
          endDate: null,
        ),
      ).called(1);
    },
  );
}
