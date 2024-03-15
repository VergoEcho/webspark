import 'dart:io';
import 'package:dio/dio.dart';

import 'package:webspark/core/resources/data_state.dart';
import 'package:webspark/features/pathfinder/data/data_sources/task_api_service.dart';

import '../../domain/repository/task_repository.dart';
import '../models/task.dart';

class TaskRepositoryImpl implements TaskRepository {
  final TaskApiService _taskApiService;

  TaskRepositoryImpl(this._taskApiService);

  @override
  Future<DataState<String?>> checkTasks(
      String url, Map<String, dynamic> results) async {
    try {
      final httpResponse = await _taskApiService.checkTasks(url, results);

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        List<TaskModel>? tasks = httpResponse.data.data;
        if (tasks == null) {
          return DataFailed(
            DioException(
              error: httpResponse.response.statusMessage,
              response: httpResponse.response,
              type: DioExceptionType.badResponse,
              requestOptions: httpResponse.response.requestOptions,
            ),
          );
        }
        return const DataSuccess(null);
      } else {
        return DataFailed(
          DioException(
              error: httpResponse.response.statusMessage,
              response: httpResponse.response,
              type: DioExceptionType.badResponse,
              requestOptions: httpResponse.response.requestOptions),
        );
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<List<TaskModel>>> getTasks(String url) async {
    try {
      final httpResponse = await _taskApiService.getTasks(url);

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        List<TaskModel>? tasks = httpResponse.data.data;
        if (tasks == null) {
          return DataFailed(
            DioException(
              error: httpResponse.response.statusMessage,
              response: httpResponse.response,
              type: DioExceptionType.badResponse,
              requestOptions: httpResponse.response.requestOptions,
            ),
          );
        }
        return DataSuccess(httpResponse.data.data!);
      } else {
        return DataFailed(
          DioException(
              error: httpResponse.response.statusMessage,
              response: httpResponse.response,
              type: DioExceptionType.badResponse,
              requestOptions: httpResponse.response.requestOptions),
        );
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }
}
