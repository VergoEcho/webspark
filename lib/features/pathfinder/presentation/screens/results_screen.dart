import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webspark/features/pathfinder/presentation/cubit/task_cubit.dart';
import 'package:webspark/features/pathfinder/presentation/screens/preview_screen.dart';
import 'package:webspark/generated/locale_keys.g.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({super.key});

  static const String route = '/results';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          LocaleKeys.results_screen_title.tr(),
        ),
      ),
      body: BlocBuilder<TaskCubit, TaskState>(
        builder: (context, state) {
          if (state is TaskCalcFinished) {
            return ListView.builder(
              itemCount: state.results.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () => Navigator.of(context).pushNamed(
                    PreviewScreen.route,
                    arguments: (
                      state.results[index]['result']['steps'],
                      state.results[index]['result']['path'],
                      state.tasks[index].field,
                    ),
                  ),
                  title: Text(state.results[index]['result']['path']),
                );
              },
            );
          }
          return Center(child: Text(LocaleKeys.results_screen_error.tr()));
        },
      ),
    );
  }
}
