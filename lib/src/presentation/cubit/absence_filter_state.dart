import 'package:equatable/equatable.dart';

class AbsenceFilterState extends Equatable {
  final String? type; // e.g., 'vacation', 'sickness', or null for all
  final DateTime? startDate;
  final DateTime? endDate;

  const AbsenceFilterState({this.type, this.startDate, this.endDate});

  AbsenceFilterState copyWith({
    String? type,
    DateTime? startDate,
    DateTime? endDate,
    bool resetDates = false,
  }) {
    return AbsenceFilterState(
      type: type ?? this.type,
      startDate: resetDates ? null : startDate ?? this.startDate,
      endDate: resetDates ? null : endDate ?? this.endDate,
    );
  }

  bool get isFiltering => type != null || startDate != null || endDate != null;

  @override
  List<Object?> get props => [type, startDate, endDate];
}
