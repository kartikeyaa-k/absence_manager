// ignore_for_file: avoid_redundant_argument_values

import 'dart:async';

import 'package:absence_manager/src/presentation/cubit/absence_filter_cubit.dart';
import 'package:absence_manager/src/presentation/cubit/absence_filter_state.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AbsenceFilterCubit', () {
    late AbsenceFilterCubit cubit;

    setUp(() {
      cubit = AbsenceFilterCubit();
    });

    tearDown(() {
      unawaited(cubit.close());
    });

    test('initial state is AbsenceFilterState()', () {
      expect(cubit.state, const AbsenceFilterState());
    });

    blocTest<AbsenceFilterCubit, AbsenceFilterState>(
      'emits updated type when setType is called',
      build: () => cubit,
      act: (cubit) => cubit.setType('vacation'),
      expect: () => [const AbsenceFilterState(type: 'vacation')],
    );

    blocTest<AbsenceFilterCubit, AbsenceFilterState>(
      'emits updated date range when setDateRange is called',
      build: () => cubit,
      act:
          (cubit) =>
              cubit.setDateRange(DateTime(2025, 1, 2), DateTime(2025, 1, 10)),
      expect:
          () => [
            AbsenceFilterState(
              startDate: DateTime(2025, 1, 2),
              endDate: DateTime(2025, 1, 10),
            ),
          ],
    );

    blocTest<AbsenceFilterCubit, AbsenceFilterState>(
      'clears state when clear is called',
      build: () => cubit,
      seed:
          () => AbsenceFilterState(
            type: 'sickness',
            startDate: DateTime(2025, 2, 1),
            endDate: DateTime(2025, 2, 5),
          ),
      act: (cubit) => cubit.clear(),
      expect: () => [const AbsenceFilterState()],
    );
  });

  test('isFiltering returns true when any filter is applied', () {
    const state = AbsenceFilterState(
      type: 'vacation',
      startDate: null,
      endDate: null,
    );
    expect(state.isFiltering, isTrue);
  });

  test('isFiltering returns false when no filters are applied', () {
    const state = AbsenceFilterState();
    expect(state.isFiltering, isFalse);
  });
}
