// ignore_for_file: avoid_redundant_argument_values, discarded_futures

import 'dart:async';

import 'package:absence_manager/src/domain/entity/absence_entity.dart';
import 'package:absence_manager/src/domain/entity/absence_paginated_response_entity.dart';
import 'package:absence_manager/src/domain/usecase/get_absences_usecase.dart';
import 'package:absence_manager/src/presentation/cubit/absence_cubit.dart';
import 'package:absence_manager/src/presentation/cubit/absence_state.dart';
import 'package:crewmeister_core/crewmeister_core.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetAbsences extends Mock implements GetAbsences {}

class FakeApiException extends ApiException {
  const FakeApiException([String super.message = 'Fake error']);
}

void main() {
  group('AbsenceCubit', () {
    final mockGetAbsences = MockGetAbsences();
    late AbsenceCubit cubit;

    final fakeAbsences = [
      AbsenceEntity(
        id: 1,
        userId: 100,
        type: 'vacation',
        startDate: DateTime(2025, 4, 1),
        endDate: DateTime(2025, 4, 3),
        memberName: '',
        memberImage: '',
      ),
      AbsenceEntity(
        id: 2,
        userId: 100,
        type: 'sickness',
        startDate: DateTime(2025, 4, 4),
        endDate: DateTime(2025, 4, 5),
        memberName: '',
        memberImage: '',
      ),
    ];

    setUp(() {
      cubit = AbsenceCubit(mockGetAbsences);
    });

    tearDown(() => unawaited(cubit.close()));

    test('initial state is AbsenceState()', () {
      expect(cubit.state, const AbsenceState());
    });

    blocTest<AbsenceCubit, AbsenceState>(
      'emits loading and then success state on loadAbsences',
      build: () {
        when(
          () => mockGetAbsences(
            page: 1,
            limit: 10,
            type: null,
            startDate: null,
            endDate: null,
          ),
        ).thenAnswer(
          (_) async => AbsencePaginatedResponseEntity(
            data: fakeAbsences,
            total: 2,
            page: 1,
            limit: 10,
          ),
        );
        return cubit;
      },
      act: (cubit) async => cubit.loadAbsences(),
      expect:
          () => [
            const AbsenceState(isLoading: true, hasError: false),
            AbsenceState(
              absences: fakeAbsences,
              page: 1,
              total: 2,
              hasReachedEnd: true,
              isLoading: false,
            ),
          ],
    );

    blocTest<AbsenceCubit, AbsenceState>(
      'emits error state when ApiException is thrown',
      build: () {
        when(
          () => unawaited(
            mockGetAbsences(
              page: 1,
              limit: 10,
              type: 'sick',
              startDate: any(named: 'startDate'),
              endDate: any(named: 'endDate'),
            ),
          ),
        ).thenThrow(const FakeApiException('exception'));

        return cubit;
      },
      act:
          (cubit) async => cubit.loadAbsences(
            type: 'sick',
            startDate: DateTime.now(),
            endDate: DateTime.now().add(const Duration(days: 2)),
          ),
      expect:
          () => [
            const AbsenceState(isLoading: true, hasError: false),
            const AbsenceState(
              isLoading: false,
              hasError: true,
              errorMessage: 'exception',
            ),
          ],
    );

    blocTest<AbsenceCubit, AbsenceState>(
      'refresh resets state and calls loadAbsences',
      build: () {
        when(
          () => mockGetAbsences(
            page: 1,
            limit: 10,
            type: null,
            startDate: null,
            endDate: null,
          ),
        ).thenAnswer(
          (_) async => AbsencePaginatedResponseEntity(
            data: fakeAbsences,
            total: 2,
            page: 1,
            limit: 10,
          ),
        );
        return cubit;
      },
      act: (cubit) => cubit.refresh(),
      expect:
          () => [
            const AbsenceState(),
            const AbsenceState(isLoading: true, hasError: false),
            AbsenceState(
              absences: fakeAbsences,
              page: 1,
              total: 2,
              hasReachedEnd: true,
              isLoading: false,
            ),
          ],
    );

    blocTest<AbsenceCubit, AbsenceState>(
      'refreshWithFilters emits filtered data',
      build: () {
        when(
          () => mockGetAbsences(
            page: 1,
            limit: 10,
            type: 'sickness',
            startDate: any(named: 'startDate'),
            endDate: any(named: 'endDate'),
          ),
        ).thenAnswer(
          (_) async => AbsencePaginatedResponseEntity(
            data: [fakeAbsences[1]],
            total: 1,
            page: 1,
            limit: 10,
          ),
        );
        return cubit;
      },
      act:
          (cubit) => cubit.refreshWithFilters(
            type: 'sickness',
            startDate: DateTime(2025, 4, 4),
            endDate: DateTime(2025, 4, 5),
          ),
      expect:
          () => [
            const AbsenceState(),
            const AbsenceState(isLoading: true, hasError: false),
            AbsenceState(
              absences: [fakeAbsences[1]],
              page: 1,
              total: 1,
              hasReachedEnd: true,
              isLoading: false,
            ),
          ],
    );
  });

  test('AbsenceState.copyWith uses existing isLoading when null passed', () {
    const initial = AbsenceState(isLoading: true);
    final result = initial.copyWith(isLoading: null);

    expect(result.isLoading, true); // fallback to existing value
  });
}
