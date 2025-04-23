import 'package:absence_manager/src/core/enum/absence_type_enum.dart';

extension AbsenceTypeFilterExtension on AbsenceTypeFilter {
  /// Raw string to send to backend (or null for 'all')
  String? get value {
    switch (this) {
      case AbsenceTypeFilter.all:
        return null;
      case AbsenceTypeFilter.vacation:
        return 'vacation';
      case AbsenceTypeFilter.sickness:
        return 'sickness';
    }
  }

  /// Display label for dropdown
  String get label {
    switch (this) {
      case AbsenceTypeFilter.all:
        return 'All types';
      case AbsenceTypeFilter.vacation:
        return 'Vacation';
      case AbsenceTypeFilter.sickness:
        return 'Sickness';
    }
  }

  static AbsenceTypeFilter fromValue(String? value) {
    switch (value) {
      case 'vacation':
        return AbsenceTypeFilter.vacation;
      case 'sickness':
        return AbsenceTypeFilter.sickness;
      default:
        return AbsenceTypeFilter.all;
    }
  }
}
