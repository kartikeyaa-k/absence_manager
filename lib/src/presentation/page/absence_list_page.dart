import 'dart:async';

import 'package:absence_manager/src/presentation/component/absence_tile.dart';
import 'package:absence_manager/src/presentation/cubit/absence_cubit.dart';
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
    unawaited(context.read<AbsenceCubit>().loadAbsences());
  }

  void _onScroll() {
    final cubit = context.read<AbsenceCubit>();
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

    return Scaffold(
      appBar: AppBar(title: const Text('Absences'), centerTitle: true),
      body: BlocBuilder<AbsenceCubit, AbsenceState>(
        builder: (context, state) {
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
              context.read<AbsenceCubit>().refresh();
            },
            child: ListView.builder(
              controller: _scrollController,
              itemCount: state.absences.length + 1, // +1 for loading indicator
              padding: const EdgeInsets.only(top: AppSpacing.md),
              itemBuilder: (context, index) {
                if (index < state.absences.length) {
                  return AbsenceTile(
                    absence: state.absences[index],
                    theme: theme,
                  );
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
        },
      ),
    );
  }
}
