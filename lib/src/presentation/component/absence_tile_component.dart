import 'package:absence_manager/src/domain/entity/absence_entity.dart';
import 'package:crewmeister_core/crewmeister_core.dart';
import 'package:flutter/material.dart';

class AbsenceTile extends StatelessWidget {
  const AbsenceTile({super.key, required this.absence, required this.theme});

  final AbsenceEntity absence;
  final ThemeData theme;
  @override
  Widget build(BuildContext context) {
    final colorScheme = theme.colorScheme;

    Color bgColor;
    Color textColor;
    var statusLabel = 'NA';

    if (absence.confirmedAt != null) {
      bgColor = colorScheme.secondaryContainer;
      textColor = colorScheme.onSecondaryContainer;
      statusLabel = 'Confirmed';
    } else if (absence.rejectedAt != null) {
      bgColor = colorScheme.errorContainer;
      textColor = colorScheme.onErrorContainer;
      statusLabel = 'Rejected';
    } else {
      bgColor = colorScheme.tertiaryContainer;
      textColor = colorScheme.onTertiaryContainer;
      statusLabel = 'Requested';
    }

    return Card(
      margin: const EdgeInsets.symmetric(
        vertical: AppSpacing.sm,
        horizontal: AppSpacing.md,
      ),
      shape: const RoundedRectangleBorder(borderRadius: AppRadius.medium),
      elevation: 16,
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Row: Name and Status
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  absence.memberName,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: bgColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    statusLabel,
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: textColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.xs),

            // Type (sickness, vacation)
            Text(
              absence.type,
              style: theme.textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurface,
              ),
            ),

            // Date Range
            Text(
              formatDateRange(absence.startDate, absence.endDate),
              style: theme.textTheme.bodyMedium,
            ),

            // Member Note (optional)
            if (absence.memberNote != null &&
                absence.memberNote!.trim().isNotEmpty) ...[
              const SizedBox(height: AppSpacing.xs),
              Text(
                absence.memberNote!,
                style: theme.textTheme.bodySmall?.copyWith(
                  fontStyle: FontStyle.italic,
                  color: colorScheme.onSurface,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
