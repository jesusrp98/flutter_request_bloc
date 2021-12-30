import 'package:flutter_request_bloc/flutter_request_bloc.dart';

import 'model.dart';
import 'service.dart';

class TodosRepository extends RequestPersistantRepository<TodosService, Todo> {
  TodosRepository(TodosService service) : super(service);

  @override
  Future<Todo> fetchData() async =>
      Todo.fromJson((await service.getTodos()).data);

  void loadError() {
    emit(RequestState.error('ERROR GENERATED!'));
  }

  @override
  Todo valueFromJson(Map<String, dynamic> json) {
    return Todo.fromJson(json);
  }

  @override
  Map<String, dynamic>? valueToJson(Todo? value) {
    return value?.toJson();
  }
}
