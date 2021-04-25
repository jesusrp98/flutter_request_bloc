import 'package:flutter_request_bloc/flutter_request_bloc.dart';

import 'repository.dart';

class TodosCubit extends RequestCubit<TodosRepository, String> {
  TodosCubit(TodosRepository repository)
      : super(
          repository,
          autoLoad: false,
        );

  @override
  Future<void> loadData() async {
    emit(RequestState.loading(state.value));

    try {
      final data = await repository.fetchData();

      emit(RequestState.loaded(data));
    } catch (e) {
      emit(RequestState.error(e.toString()));
    }
  }

  void loadError() {
    emit(RequestState.error('ERROR GENERATED!'));
  }
}
