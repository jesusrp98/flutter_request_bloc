import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import './helpers/mock.dart';

void main() {
  group('BaseRepository', () {
    MockService service;
    MockRepository repository;

    setUp(() {
      service = MockService(MockClient());
      repository = MockRepository(service);
    });

    test('throws AssertionError when client is null', () {
      expect(() => MockRepository(null), throwsAssertionError);
    });

    test('returns request when client returns 200', () async {
      final response = MockResponse();
      const json = 'Just a normal JSON here';

      when(
        service.client.get('path'),
      ).thenAnswer((_) => Future.value(response));
      when(response.data).thenReturn(json);

      final output = await repository.fetchData();
      expect(output, json);
    });
  });
}
