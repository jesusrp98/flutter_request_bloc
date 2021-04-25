import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import './helpers/mock.dart';

void main() {
  group('BaseService', () {
    MockClient client;
    MockService service;

    setUp(() {
      client = MockClient();
      service = MockService(client);
    });

    test('throws AssertionError when client is null', () {
      expect(() => MockService(null), throwsAssertionError);
    });

    test('returns changelog when client returns 200', () async {
      const json = 'Just a normal JSON here';
      final response = MockResponse();

      when(response.statusCode).thenReturn(200);
      when(response.data).thenReturn(json);
      when(
        client.get('path'),
      ).thenAnswer((_) => Future.value(response));

      final output = await service.client.get('path');
      expect(output.data, json);
    });
  });
}
