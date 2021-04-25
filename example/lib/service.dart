import 'package:dio/dio.dart';
import 'package:flutter_request_bloc/flutter_request_bloc.dart';


/// Services that retrieves information about the app's changelog.
class TodosService extends BaseService<Dio> {
  const TodosService(Dio client) : super(client);

  Future<Response> getTodos() async {
    return client.get('https://jsonplaceholder.typicode.com/todos/1');
  }
}
