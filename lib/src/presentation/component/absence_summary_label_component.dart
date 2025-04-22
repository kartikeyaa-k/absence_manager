import 'package:absence_manager/src/presentation/cubit/absence_state.dart';
import 'package:crewmeister_core/crewmeister_core.dart';
import 'package:flutter/material.dart';

class AbsenceSummaryLabel extends StatelessWidget {
  const AbsenceSummaryLabel({super.key, required this.state});

  final AbsenceState state;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (state.absences.isEmpty) {
      return const SizedBox.shrink();
    }

    final message =
        state.absences.length == state.total
            ? 'Total absences: ${state.total}'
            : 'Showing ${state.absences.length} of ${state.total} absences';

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.xs,
      ),
      child: Text(message, style: theme.textTheme.bodySmall),
    );
  }
}
