// ignore_for_file: avoid_redundant_argument_values

import 'package:absence_manager/src/domain/entity/absence_entity.dart';
import 'package:absence_manager/src/domain/entity/absence_paginated_response_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:absence_manager/src/domain/repository/absence_repository.dart';
import 'package:absence_manager/src/domain/usecase/get_absences_usecase.dart';

class MockAbsenceRepository extends Mock implements AbsenceRepository {}

void main() {
  late GetAbsences usecase;
  late MockAbsenceRepository mockRepository;

  setUp(() {
    mockRepository = MockAbsenceRepository();
    usecase = GetAbsences(mockRepository);
  });

  test('calls AbsenceRepository.getAbsences with correct arguments', () async {
    when(
      () => mockRepository.getAbsences(
        page: 1,
        limit: 10,
        type: null,
        startDate: null,
        endDate: null,
      ),
    ).thenAnswer(
      (_) async => /* some fake AbsencePaginatedResponseEntity */
          throw UnimplementedError(),
    );

    try {
      await usecase(page: 1, limit: 10);
    } catch (_) {}

    verify(
      () => mockRepository.getAbsences(
        page: 1,
        limit: 10,
        type: null,
        startDate: null,
        endDate: null,
      ),
    ).called(1);
  });
  test('returns AbsencePaginatedResponseEntity on success', () async {
    final expected = AbsencePaginatedResponseEntity(
      data: [
        AbsenceEntity(
          id: 1,
          userId: 1,
          type: 'vacation',
          startDate: DateTime.now(),
          endDate: DateTime.now(),
          memberName: '',
          memberImage: '',
        ),
      ],
      total: 1,
      page: 10,
      limit: 10,
    );

    when(
      () => mockRepository.getAbsences(
        page: 1,
        limit: 10,
        type: null,
        startDate: null,
        endDate: null,
      ),
    ).thenAnswer((_) async => expected);

    final result = await usecase(page: 1, limit: 10);

    expect(result, expected);
  });
}
