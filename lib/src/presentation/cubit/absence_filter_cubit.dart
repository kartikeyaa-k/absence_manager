import 'package:absence_manager/src/presentation/cubit/absence_filter_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AbsenceFilterCubit extends Cubit<AbsenceFilterState> {
  AbsenceFilterCubit() : super(const AbsenceFilterState());

  void setType(String? type) {
    emit(state.copyWith(type: type));
  }

  void setDateRange(DateTime? start, DateTime? end) {
    emit(state.copyWith(startDate: start, endDate: end));
  }

  void clear() {
    emit(const AbsenceFilterState());
  }
}
