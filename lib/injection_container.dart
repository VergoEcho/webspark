import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:webspark/features/pathfinder/data/data_sources/task_api_service.dart';
import 'package:webspark/features/pathfinder/data/repository/task_repository_impl.dart';
import 'package:webspark/features/pathfinder/domain/usecases/get_tasks.dart';
import 'package:webspark/features/pathfinder/domain/usecases/send_results.dart';
import 'package:webspark/features/pathfinder/domain/usecases/send_results.dart';
import 'package:webspark/features/pathfinder/presentation/cubit/task_cubit.dart';

import 'features/pathfinder/domain/repository/task_repository.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  sl.registerSingleton<Dio>(Dio());
  
  sl.registerSingleton<TaskApiService>(TaskApiService(sl()));

  sl.registerSingleton<TaskRepository>(TaskRepositoryImpl(sl()));
  
  sl.registerSingleton<GetTasksUseCase>(GetTasksUseCase(sl()));
  sl.registerSingleton<SendResultsUseCase>(SendResultsUseCase(sl()));

  sl.registerFactory<TaskCubit>(() => TaskCubit());
}