import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_request_bloc/cubits/index.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'helpers/hydrated.dart';
import 'helpers/mock.dart';

void main() {
  initHydratedBloc();
  group('RequestPersistantCubit', () {
    MockRequestPersistantCubit cubit;
    CubitRepository repository;

    setUp(() {
      repository = CubitRepository();
      cubit = MockRequestPersistantCubit(repository);
    });

    tearDown(() {
      cubit.close();
    });

    test('fails when null service is provided', () {
      expect(() => MockRequestPersistantCubit(null), throwsAssertionError);
    });

    group('toJson/fromJson', () {
      test('work properly', () {
        expect(
          cubit.fromJson(cubit.toJson(cubit.state)),
          cubit.state,
        );
      });
    });

    group('fetchData', () {
      blocTest<MockRequestPersistantCubit, RequestState>(
        'fetches data correctly',
        build: () {
          when(repository.fetchData()).thenAnswer(
            (_) => Future.value('Lorem'),
          );
          return cubit;
        },
        act: (cubit) async => cubit.loadData(),
        verify: (_) => verify(repository.fetchData()).called(2),
        expect: [
          RequestState<String>.loading(),
          RequestState<String>.loaded('Lorem'),
        ],
      );

      blocTest<MockRequestPersistantCubit, RequestState>(
        'can throw an exception',
        build: () {
          when(repository.fetchData()).thenThrow(Exception('wtf'));
          return cubit;
        },
        act: (cubit) async => cubit.loadData(),
        verify: (_) => verify(repository.fetchData()).called(2),
        expect: [
          RequestState<String>.loading(),
          RequestState<String>.error(Exception('wtf').toString()),
        ],
      );
    });
  });
}
