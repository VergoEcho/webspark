import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webspark/features/pathfinder/presentation/cubit/task_cubit.dart';
import 'package:webspark/features/pathfinder/presentation/cubit/task_cubit.dart';
import 'package:webspark/features/pathfinder/presentation/screens/preview_screen.dart';
import 'package:webspark/generated/locale_keys.g.dart';

class InputBan extends StatefulWidget {
  const InputBan({super.key});

  static const String route = '/ban';

  @override
  State<InputBan> createState() => _InputBanState();
}

enum InputMode {
  ban,
  start,
  end,
}

class _InputBanState extends State<InputBan> {
  InputMode mode = InputMode.ban;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TaskCubit, TaskState>(
      listener: (context, state) {
        if (state is TaskCalcFinished) {
          Navigator.of(context).pushNamed(
            PreviewScreen.route,
            arguments: (
            state.results[0]['result']['steps'],
            state.results[0]['result']['path'],
            state.tasks[0].field,
            ),
          );
        }
      },
      // buildWhen: (oldState, state) {
      //   if (oldState == state.task) return false;
      //   print('emit');
      //   return true;
      // },
      builder: (context, state) {
        print(state);
        final fields = state.task!.field;
        final start = state.task!.start;
        final end = state.task!.end;

        Color getColor(int x, int y) {
          if (fields[y][x] == 'X') return Colors.black;

          if (fields[y][x] == '+') return const Color(0xFF4CAF50);

          if (fields[y][x] == '-') return Colors.grey;

          if (fields[y][x] == '#') return Colors.red;

          if (start.x == x && start.y == y) {
            return const Color(0xFF64FFDA);
          }

          if (end.x == x && end.y == y) {
            return const Color(0xFF009688);
          }

          // for (final step in steps) {
          //   if (step['x'] == x.toString() && step['y'] == y.toString()) {
          //     return const Color(0xFF4CAF50);
          //   }
          // }

          return Colors.white;
        }

        return Scaffold(
          appBar: AppBar(
            title: Text(
              LocaleKeys.preview_screen_title.tr(),
            ),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (int y = 0; y < fields.length; y++)
                Row(
                  children: [
                    for (int x = 0; x < fields[0].length; x++)
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(4),
                          child: GestureDetector(
                            onTap: state is TaskCorrectUrl
                                ? () {
                                    switch (mode) {
                                      case InputMode.ban:
                                        context
                                            .read<TaskCubit>()
                                            .banField(x, y);
                                        break;
                                      case InputMode.start:
                                        context
                                            .read<TaskCubit>()
                                            .startField(x, y);
                                        break;
                                      case InputMode.end:
                                        context
                                            .read<TaskCubit>()
                                            .endField(x, y);
                                        break;
                                    }
                                    if (mode == InputMode.ban) {
                                      setState(() {});
                                    }
                                  }
                                : null,
                            child: Container(
                              height: 60,
                              color: getColor(x, y),
                              child: Center(child: Text('($x,$y)')),
                            ),
                          ),
                        ),
                      )
                  ],
                ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Radio(
                        value: InputMode.ban,
                        groupValue: mode,
                        onChanged: (value) {
                          setState(() {
                            mode = value ?? InputMode.ban;
                          });
                        },
                      ),
                      const Text('B'),
                    ],
                  ),
                  Column(
                    children: [
                      Radio(
                        value: InputMode.start,
                        groupValue: mode,
                        onChanged: (value) {
                          setState(() {
                            mode = value ?? InputMode.ban;
                          });
                        },
                      ),
                      const Text('S'),
                    ],
                  ),
                  Column(
                    children: [
                      Radio(
                        value: InputMode.end,
                        groupValue: mode,
                        onChanged: (value) {
                          setState(() {
                            mode = value ?? InputMode.ban;
                          });
                        },
                      ),
                      const Text('E'),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  print(state.task!.field[0]);
                  print(state.task!.field[1]);
                  print(state.task!.field[2]);
                  print(state.task!.field[3]);
                  context.read<TaskCubit>().calcTasks();
                },
                child: const Text('Start calc'),
              ),
            ],
          ),
        );
      },
    );
  }
}
