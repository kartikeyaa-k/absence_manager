import 'package:absence_manager/src/core/enum/absence_type_enum.dart';
import 'package:absence_manager/src/core/utility/absence_type_extension.dart';

import 'package:absence_manager/src/presentation/cubit/absence_filter_cubit.dart';
import 'package:absence_manager/src/presentation/cubit/absence_filter_state.dart';
import 'package:crewmeister_core/crewmeister_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AbsenceFilterBar extends StatelessWidget {
  const AbsenceFilterBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AbsenceFilterCubit, AbsenceFilterState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm,
          ),
          child: Row(
            children: [
              // Type Filter Dropdown
              Expanded(
                child: DropdownButtonFormField<String>(
                  value: state.type,
                  hint: const Text('All types'),
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: AppSpacing.md,
                      vertical: AppSpacing.sm,
                    ),
                  ),
                  items:
                      AbsenceTypeFilter.values.map((type) {
                        return DropdownMenuItem<String>(
                          value: type.value,
                          child: Text(type.label),
                        );
                      }).toList(),
                  onChanged: (value) {
                    context.read<AbsenceFilterCubit>().setType(
                      (value?.isEmpty ?? true) ? null : value,
                    );
                  },
                ),
              ),
              const SizedBox(width: AppSpacing.sm),

              // Date Picker Button
              IconButton(
                icon: const Icon(Icons.date_range),
                tooltip: 'Filter by date',
                onPressed: () async {
                  final picked = await showDateRangePicker(
                    context: context,
                    firstDate: DateTime(2020),
                    lastDate: DateTime.now().add(const Duration(days: 365)),
                    initialDateRange:
                        state.startDate != null && state.endDate != null
                            ? DateTimeRange(
                              start: state.startDate!,
                              end: state.endDate!,
                            )
                            : null,
                  );

                  if (picked != null) {
                    SchedulerBinding.instance.addPostFrameCallback((_) {
                      context.read<AbsenceFilterCubit>().setDateRange(
                        picked.start,
                        picked.end,
                      );
                    });
                  }
                },
              ),
              if (state.isFiltering)
                IconButton(
                  icon: const Icon(Icons.clear),
                  tooltip: 'Clear filters',
                  onPressed: () {
                    context.read<AbsenceFilterCubit>().clear();
                  },
                ),
            ],
          ),
        );
      },
    );
  }
}
