import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:webspark/core/resources/response_api.dart';

import '../models/task.dart';

part 'task_api_service.g.dart';

@RestApi(baseUrl: '')
abstract class TaskApiService {
  factory TaskApiService(Dio dio) => _TaskApiService(dio);

  @GET('{url}')
  Future<HttpResponse<ResponseApi<List<TaskModel>>>> getTasks(@Path() String url);

  @POST('{url}')
  Future<HttpResponse<ResponseApi<dynamic>>> checkTasks(@Path() String url, @Body() dynamic result);
}