import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webspark/features/pathfinder/presentation/cubit/task_cubit.dart';
import 'package:webspark/generated/locale_keys.g.dart';

import 'process_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const String route = '/';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final TextEditingController urlController;

  @override
  void initState() {
    urlController =
        TextEditingController(text: 'https://flutter.webspark.dev/flutter/api');
    super.initState();
  }

  @override
  void dispose() {
    urlController.dispose();
    super.dispose();
  }

  void _startCounting(BuildContext context) async {
    print('start');
    final cubit = context.read<TaskCubit>();
    await cubit.loadUrl(urlController.text);
    if (cubit.state is! TaskError && context.mounted) {
      cubit.calcTasks();
      print(cubit.state);
      Navigator.of(context).pushNamed(ProcessScreen.route);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          LocaleKeys.home_screen_title.tr(),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(LocaleKeys.home_screen_url_label.tr()),
              TextField(
                controller: urlController,
                decoration: const InputDecoration(
                  hintText: 'https://flutter.webspark.dev/flutter/api',
                  prefixIcon: Icon(Icons.compare_arrows_sharp),
                ),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () => _startCounting(context),
                child: Text(
                  LocaleKeys.home_screen_start_button.tr(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
