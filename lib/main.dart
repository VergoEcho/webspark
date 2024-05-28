import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webspark/features/pathfinder/presentation/cubit/task_cubit.dart';
import 'package:webspark/features/pathfinder/presentation/screens/home_screen.dart';
import 'package:webspark/features/pathfinder/presentation/screens/process_screen.dart';

import 'config/theme.dart';
import 'features/pathfinder/presentation/screens/input_ban_screen.dart';
import 'features/pathfinder/presentation/screens/preview_screen.dart';
import 'features/pathfinder/presentation/screens/results_screen.dart';
import 'injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDependencies();

  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en')],
      path: 'assets/locales',
      startLocale: const Locale('en'),
      fallbackLocale: const Locale('en'),
      child: const PathFinder(),
    ),
  );
}

class PathFinder extends StatelessWidget {
  const PathFinder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TaskCubit>(
      create: (context) => sl(),
      child: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: MaterialApp(
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          theme: theme(),
          routes: {
            HomeScreen.route: (context) => const HomeScreen(),
            InputBan.route: (context) => const InputBan(),
            PreviewScreen.route: (context) => const PreviewScreen(),
            ProcessScreen.route: (context) => const ProcessScreen(),
            ResultsScreen.route: (context) => const ResultsScreen(),
          },
        ),
      ),
    );
  }
}

//
// class Cell {
//   final int x;
//   final int y;
//   final List<Cell> road;
//
//   Cell(this.x, this.y, {this.road = const []});
// }
//
// void main() {
//   List<Cell> banned = [
//     Cell(1, 0),
//     Cell(2, 0)
//   ];
//   List<Cell> alive = [
//     Cell(2,1)
//   ];
//   Cell end = Cell(0,2);
//
//   for (Cell cell in alive) {
//     print(cell);
//   }
// }
