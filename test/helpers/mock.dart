import 'package:dio/dio.dart';
import 'package:flutter_request_bloc/flutter_request_bloc.dart';
import 'package:flutter_request_bloc/services/base.dart';
import 'package:mockito/mockito.dart';

class MockClient extends Mock implements Dio {}

class MockResponse extends Mock implements Response {}

class MockService extends BaseService<MockClient> {
  MockService(MockClient c) : super(c);
}

class CubitRepository extends Mock implements BaseRepository {}

class MockRepository extends BaseRepository<MockService, String> {
  MockRepository(MockService s) : super(s);

  @override
  Future<String> fetchData() async {
    return (await service.client.get('path')).data;
  }
}

class MockRequestCubit extends RequestCubit<CubitRepository, String> {
  MockRequestCubit(CubitRepository repository) : super(repository);

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
}

class MockRequestPersistantCubit
    extends RequestPersistantCubit<CubitRepository, String> {
  MockRequestPersistantCubit(CubitRepository repository) : super(repository);

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
}
