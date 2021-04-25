import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_request_bloc/cubits/index.dart';
import 'package:flutter_request_bloc/flutter_request_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'helpers/hydrated.dart';
import 'helpers/mock.dart';

void main() {
  initHydratedBloc();
  group('RequestCubit', () {
    MockRequestCubit cubit;
    CubitRepository repository;

    setUp(() {
      repository = CubitRepository();
      cubit = MockRequestCubit(repository);
    });

    tearDown(() {
      cubit.close();
    });

    test('fails when null service is provided', () {
      expect(() => MockRequestCubit(null), throwsAssertionError);
    });

    group('fetchData', () {
      const json = 'Just a normal JSON here';
      blocTest<MockRequestCubit, RequestState>(
        'fetches data correctly',
        build: () {
          final response = MockResponse();
          when(
            cubit.loadData(),
          ).thenAnswer((_) => Future.value(response));
          when(response.data).thenReturn(json);
          return cubit;
        },
        act: (cubit) async => cubit.loadData(),
        verify: (_) => verify(repository.fetchData()).called(2),
        // expect: [
        //   RequestState<String>.loading(),
        //   RequestState<String>.loaded(json),
        // ],
      );

      blocTest<MockRequestCubit, RequestState>(
        'can throw an exception',
        build: () {
          when(cubit.loadData()).thenThrow(Exception('wtf'));
          return cubit;
        },
        act: (cubit) async => cubit.loadData(),
        verify: (_) => verify(repository.fetchData()).called(2),
        // expect: [
        //   RequestState<String>.loading(),
        //   RequestState<String>.error(Exception('wtf').toString()),
        // ],
      );
    });
  });
}
