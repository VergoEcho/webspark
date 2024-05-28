import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webspark/features/pathfinder/domain/entities/cell.dart';
import 'package:webspark/features/pathfinder/domain/entities/task.dart';
import 'package:webspark/features/pathfinder/presentation/cubit/task_cubit.dart';
import 'package:webspark/generated/locale_keys.g.dart';

import 'input_ban_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const String route = '/';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int fieldSize = 3;

  void _startCounting(BuildContext context) async {
    final cubit = context.read<TaskCubit>();
    final row = '.' * fieldSize;
    List<String> field = [];
    for (int i = 0; i < fieldSize; i++) {
      field.add(row);
    }

    await cubit.loadTask(TaskEntity(
      id: '0',
      field: field,
      start: const CellEntity(0, 0),
      end: const CellEntity(0, 0),
    ));
    if (cubit.state is! TaskError && context.mounted) {
      // cubit.calcTasks();
      Navigator.of(context).pushNamed(InputBan.route);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Pathfinder',
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Field size: $fieldSize',
            style: const TextStyle(
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 160,
                child: Slider(
                  value: fieldSize.toDouble(),
                  onChanged: (value) {
                    setState(() {
                      fieldSize = value.toInt();
                    });
                  },
                  min: 3,
                  max: 10,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => _startCounting(context),
            child: Text(
              LocaleKeys.home_screen_start_button.tr(),
            ),
          ),
        ],
      ),
    );
  }
}
