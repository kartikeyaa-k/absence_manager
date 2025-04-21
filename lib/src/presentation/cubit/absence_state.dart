import 'package:absence_manager/src/domain/entity/absence_entity.dart';
import 'package:equatable/equatable.dart';

class AbsenceState extends Equatable {
  final List<AbsenceEntity> absences;
  final bool isLoading;
  final bool hasError;
  final String? errorMessage;
  final int page;
  final bool hasReachedEnd;

  const AbsenceState({
    this.absences = const [],
    this.isLoading = false,
    this.hasError = false,
    this.errorMessage,
    this.page = 1,
    this.hasReachedEnd = false,
  });

  AbsenceState copyWith({
    List<AbsenceEntity>? absences,
    bool? isLoading,
    bool? hasError,
    String? errorMessage,
    int? page,
    bool? hasReachedEnd,
  }) {
    return AbsenceState(
      absences: absences ?? this.absences,
      isLoading: isLoading ?? this.isLoading,
      hasError: hasError ?? this.hasError,
      errorMessage: errorMessage ?? this.errorMessage,
      page: page ?? this.page,
      hasReachedEnd: hasReachedEnd ?? this.hasReachedEnd,
    );
  }

  @override
  List<Object?> get props => [
    absences,
    isLoading,
    hasError,
    errorMessage,
    page,
    hasReachedEnd,
  ];
}
