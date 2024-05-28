import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webspark/config/colors.dart';
import 'package:webspark/features/pathfinder/presentation/cubit/task_cubit.dart';
import 'package:webspark/generated/locale_keys.g.dart';

import 'results_screen.dart';

class ProcessScreen extends StatelessWidget {
  const ProcessScreen({super.key});

  static const String route = '/process';

  _sendResults(BuildContext context) {
    Navigator.of(context).pushNamed(ResultsScreen.route);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          LocaleKeys.process_screen_title.tr(),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            children: [
              const Spacer(),
              BlocBuilder<TaskCubit, TaskState>(
                builder: (context, state) {
                  if (state is TaskCalcInProgress) {
                    return Column(
                      children: [
                        Text(LocaleKeys.process_screen_calc_progress.tr()),
                      ],
                    );
                  }
                  if (state is TaskCalcFinished) {
                    return Column(
                      children: [
                        Text(LocaleKeys.process_screen_calc_success.tr()),
                      ],
                    );
                  }
                  return Text(LocaleKeys.process_screen_calc_error.tr());
                },
              ),
              const Spacer(),
              BlocBuilder<TaskCubit, TaskState>(
                builder: (context, state) {
                  return ElevatedButton(
                    onPressed: state is TaskCalcFinished
                        ? () => _sendResults(context)
                        : null,
                    child: Text(
                      LocaleKeys.process_screen_send_button.tr(),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
