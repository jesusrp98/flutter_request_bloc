import 'package:flutter_request_bloc/flutter_request_bloc.dart';

import 'service.dart';

/// Handles retrieve and transformation of the changelog of the app.
class TodosRepository extends BaseRepository<TodosService, String> {
  const TodosRepository(TodosService service) : super(service);

  @override
  Future<String> fetchData() async {
    final response = await service.getTodos();

    return response.data.toString();
  }
}
