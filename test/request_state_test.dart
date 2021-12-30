import 'package:flutter_request_bloc/flutter_request_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Testing constructor values', () {
    test('RequestState.init()', () {
      expect(RequestState.init().status, RequestStatus.init);
      expect(RequestState.init().value, null);
      expect(RequestState.init().errorMessage, null);
    });

    test('RequestState.loading()', () {
      expect(RequestState.loading().status, RequestStatus.loading);
      expect(RequestState.loading().value, null);
      expect(RequestState.loading('previous').value, 'previous');
      expect(RequestState.loading().errorMessage, null);
    });

    test('RequestState.loaded()', () {
      expect(RequestState.loaded('Lorem').status, RequestStatus.loaded);
      expect(RequestState.loaded('Lorem').value, 'Lorem');
      expect(RequestState.loaded('Lorem').errorMessage, null);
    });

    test('RequestState.error()', () {
      expect(RequestState.error('Lorem').status, RequestStatus.error);
      expect(RequestState.error('Lorem').value, null);
      expect(RequestState.error('Lorem').errorMessage, 'Lorem');
    });
  });

  group('Testing serialization', () {
    test('RequestState.fromJson()', () {
      expect(
        RequestState<dynamic>.fromJson(
          {
            'status': RequestStatus.init.index,
            'value': null,
            'errorMessage': null,
          },
          valueBuilder: (_) => null,
        ),
        RequestState<dynamic>.init(),
      );

      expect(
        RequestState<dynamic>.fromJson(
          {
            'status': RequestStatus.loading.index,
            'value': null,
            'errorMessage': null,
          },
          valueBuilder: (_) => null,
        ),
        RequestState<dynamic>.loading(),
      );

      expect(
        RequestState<String>.fromJson(
          {
            'status': RequestStatus.loading.index,
            'value': {'data': 'previous'},
            'errorMessage': null,
          },
          valueBuilder: (value) => value['data'],
        ),
        RequestState.loading('previous'),
      );

      expect(
        RequestState<String>.fromJson(
          {
            'status': RequestStatus.loaded.index,
            'value': {'data': 'Lorem'},
            'errorMessage': null,
          },
          valueBuilder: (value) => value['data'],
        ),
        RequestState.loaded('Lorem'),
      );

      expect(
        RequestState<dynamic>.fromJson(
          {
            'status': RequestStatus.error.index,
            'value': null,
            'errorMessage': 'Lorem',
          },
          valueBuilder: (_) => null,
        ),
        RequestState<dynamic>.error('Lorem'),
      );
    });

    test('RequestState.toJson()', () {
      var state = RequestState.init();
      expect(state.toJson(valueBuilder: (value) => null), {
        'status': RequestStatus.init.index,
        'value': null,
        'errorMessage': null,
      });

      state = RequestState.loading();
      expect(state.toJson(valueBuilder: (value) => null), {
        'status': RequestStatus.loading.index,
        'value': null,
        'errorMessage': null,
      });

      state = RequestState.loading('previous');
      expect(state.toJson(valueBuilder: (value) => {'data': value}), {
        'status': RequestStatus.loading.index,
        'value': {'data': 'previous'},
        'errorMessage': null,
      });

      state = RequestState.loaded('Lorem');
      expect(state.toJson(valueBuilder: (value) => {'data': value}), {
        'status': RequestStatus.loaded.index,
        'value': {'data': 'Lorem'},
        'errorMessage': null,
      });

      state = RequestState.error('Lorem');
      expect(state.toJson(valueBuilder: (value) => null), {
        'status': RequestStatus.error.index,
        'value': null,
        'errorMessage': 'Lorem',
      });
    });
  });

  test('Testning equals operator', () {
    expect(RequestState.init() == RequestState.init(), true);
    expect(RequestState.init() == RequestState.loading(), false);

    expect(RequestState.loaded('Lorem') == RequestState.loaded('Lorem'), true);
    expect(
      RequestState.loaded('Lorem') == RequestState.loaded('Lorem123'),
      false,
    );

    expect(RequestState.error('Lorem') == RequestState.error('Lorem'), true);
    expect(
      RequestState.error('Lorem') == RequestState.error('Lorem123'),
      false,
    );
  });

  test('Testning toString', () {
    expect(RequestState.init().toString(), '(RequestStatus.init: null, null)');

    expect(
      RequestState.loading().toString(),
      '(RequestStatus.loading: null, null)',
    );
    expect(
      RequestState.loading('previous').toString(),
      '(RequestStatus.loading: previous, null)',
    );

    expect(
      RequestState.loaded('data').toString(),
      '(RequestStatus.loaded: data, null)',
    );

    expect(
      RequestState.error('error').toString(),
      '(RequestStatus.error: null, error)',
    );
  });
}
