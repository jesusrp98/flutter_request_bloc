import 'package:flutter_request_bloc/flutter_request_bloc.dart';

import 'service.dart';

class TodosRepository extends RequestRepository<TodosService, String> {
  TodosRepository(TodosService service)
      : super(
          service,
          autoLoad: false,
        );

  @override
  Future<String> fetchData() async => (await service.getTodos()).toString();

  void loadError() {
    emit(RequestState.error('ERROR GENERATED!'));
  }
}
