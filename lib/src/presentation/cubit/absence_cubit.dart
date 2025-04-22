import 'dart:async';

import 'package:absence_manager/src/domain/usecase/get_absences.dart';
import 'package:absence_manager/src/presentation/cubit/absence_state.dart';
import 'package:crewmeister_core/crewmeister_core.dart';
import 'package:bloc/bloc.dart';

class AbsenceCubit extends Cubit<AbsenceState> {
  AbsenceCubit(this._getAbsences) : super(const AbsenceState());

  final GetAbsences _getAbsences;

  Future<void> loadAbsences({
    int page = 1,
    int limit = 10,
    String? type,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    if (state.hasReachedEnd || state.isLoading) {
      return;
    }

    emit(state.copyWith(isLoading: true, hasError: false));

    try {
      final result = await _getAbsences(
        page: page,
        limit: limit,
        type: type,
        startDate: startDate,
        endDate: endDate,
      );

      final updatedList =
          page == 1 ? result.data : [...state.absences, ...result.data];

      final hasReachedEnd = updatedList.length >= result.total;

      emit(
        state.copyWith(
          absences: updatedList,
          page: page,
          hasReachedEnd: hasReachedEnd,
          isLoading: false,
          total: result.total,
        ),
      );
    } on ApiException catch (e) {
      emit(
        state.copyWith(
          hasError: true,
          errorMessage: e.message,
          isLoading: false,
        ),
      );
    }
  }

  // restart pagination
  void refresh() {
    emit(const AbsenceState());
    unawaited(loadAbsences());
  }

  void refreshWithFilters({
    String? type,
    DateTime? startDate,
    DateTime? endDate,
  }) {
    emit(const AbsenceState());
    unawaited(loadAbsences(type: type, startDate: startDate, endDate: endDate));
  }
}
