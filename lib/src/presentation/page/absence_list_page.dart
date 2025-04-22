import 'dart:async';

import 'package:absence_manager/src/presentation/component/absence_filter_bar.dart';
import 'package:absence_manager/src/presentation/component/absence_summary_label.dart';
import 'package:absence_manager/src/presentation/component/absence_tile.dart';
import 'package:absence_manager/src/presentation/cubit/absence_cubit.dart';
import 'package:absence_manager/src/presentation/cubit/absence_filter_cubit.dart';
import 'package:absence_manager/src/presentation/cubit/absence_filter_state.dart';
import 'package:absence_manager/src/presentation/cubit/absence_state.dart';
import 'package:crewmeister_core/crewmeister_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AbsenceListPage extends StatefulWidget {
  const AbsenceListPage({super.key});

  @override
  State<AbsenceListPage> createState() => _AbsenceListPageState();
}

class _AbsenceListPageState extends State<AbsenceListPage> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);
    final cubit = context.read<AbsenceCubit>();
    final filter = context.read<AbsenceFilterCubit>().state;

    unawaited(
      cubit.loadAbsences(
        // For readability, preferred keeping it.
        // ignore: avoid_redundant_argument_values
        page: 1,
        type: filter.type,
        startDate: filter.startDate,
        endDate: filter.endDate,
      ),
    );
  }

  void _onScroll() {
    final cubit = context.read<AbsenceCubit>();
    if (cubit.state.hasReachedEnd) {
      return;
    }

    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 100) {
      unawaited(cubit.loadAbsences(page: cubit.state.page + 1));
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocListener<AbsenceFilterCubit, AbsenceFilterState>(
      listener: (context, filterState) {
        context.read<AbsenceCubit>().refreshWithFilters(
          type: filterState.type,
          startDate: filterState.startDate,
          endDate: filterState.endDate,
        );
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Absences'), centerTitle: true),
        body: Column(
          children: [
            const AbsenceFilterBar(),

            Expanded(
              child: BlocBuilder<AbsenceCubit, AbsenceState>(
                builder: (context, state) {
                  return Column(
                    children: [
                      AbsenceSummaryLabel(state: state),
                      Expanded(child: _buildListOrState(context, state, theme)),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListOrState(
    BuildContext context,
    AbsenceState state,
    ThemeData theme,
  ) {
    if (state.isLoading && state.absences.isEmpty) {
      return const AppLoadingComponent();
    }

    if (state.hasError && state.absences.isEmpty) {
      return AppErrorComponent(
        message: state.errorMessage ?? 'Something went wrong.',
        onRetry: () => context.read<AbsenceCubit>().refresh(),
        retryCtaTitle: 'Retry',
      );
    }

    if (state.absences.isEmpty) {
      return const AppEmptyComponent(message: 'No absences found');
    }

    return RefreshIndicator(
      onRefresh: () async {
        final filterState = context.read<AbsenceFilterCubit>().state;

        context.read<AbsenceCubit>().refreshWithFilters(
          type: filterState.type,
          startDate: filterState.startDate,
          endDate: filterState.endDate,
        );
      },
      child: ListView.builder(
        controller: _scrollController,
        itemCount: state.absences.length + 1,
        shrinkWrap: true,
        padding: const EdgeInsets.only(top: AppSpacing.xs),
        itemBuilder: (context, index) {
          if (index < state.absences.length) {
            return AbsenceTile(absence: state.absences[index], theme: theme);
          }

          if (state.isLoading) {
            return const Padding(
              padding: EdgeInsets.all(AppSpacing.md),
              child: AppLoadingComponent(),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
