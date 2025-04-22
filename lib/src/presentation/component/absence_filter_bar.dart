import 'package:absence_manager/src/core/enum/absence_type_enum.dart';
import 'package:absence_manager/src/core/utility/absence_type_extension.dart';
import 'package:absence_manager/src/core/utility/date_format_extension.dart';

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
        return Container(
          height: 60,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm,
          ),
          child: Row(
            children: [
              // Type Filter Dropdown
              _buildTypeDropdown(context, state),
              const SizedBox(width: AppSpacing.sm),
              _buildDateField(context, state),
              // Date Picker Button
              if (state.isFiltering)
                IconButton(
                  icon: const Icon(Icons.clear),
                  tooltip: 'Clear filters',
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    context.read<AbsenceFilterCubit>().clear();
                  },
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTypeDropdown(BuildContext context, AbsenceFilterState state) {
    return Expanded(
      child: DropdownButtonFormField<String>(
        elevation: 0,
        isExpanded: true,
        alignment: Alignment.center,
        icon: const SizedBox(),
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
        value: state.type,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.type_specimen,
            size: 20,
            color: Theme.of(context).colorScheme.secondary,
          ),
          suffixIcon: Icon(
            Icons.keyboard_arrow_down,
            size: 20,
            color: Theme.of(context).colorScheme.secondary,
          ),
          hintStyle: Theme.of(context).textTheme.bodySmall,
        ),
        style: Theme.of(context).textTheme.bodySmall,
        iconEnabledColor: Theme.of(context).colorScheme.secondary,
        dropdownColor: Theme.of(context).colorScheme.secondary,
      ),
    );
  }

  Widget _buildDateField(BuildContext context, AbsenceFilterState state) {
    return Expanded(
      child: InkWell(
        onTap: () async {
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
        child: IgnorePointer(
          child: TextFormField(
            controller: TextEditingController(
              text:
                  state.startDate != null && state.endDate != null
                      ? '${state.startDate?.formatAsShort} - ${state.endDate?.formatAsShort}'
                      : '',
            ),
            readOnly: true,
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.date_range,
                size: 20,
                color: Theme.of(context).colorScheme.secondary,
              ),
              hintText: 'All Dates',
              hintStyle: Theme.of(context).textTheme.bodySmall,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color:
                      (state.startDate != null && state.endDate != null)
                          ? Theme.of(context).colorScheme.secondary
                          : Theme.of(context).colorScheme.surfaceDim,
                ),
              ),
            ),
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
      ),
    );
  }
}
