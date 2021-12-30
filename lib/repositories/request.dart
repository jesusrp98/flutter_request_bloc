import 'package:flutter_bloc/flutter_bloc.dart';

import '../flutter_request_bloc.dart';

/// Cubit that simplyfies state and data management. It uses [RequestState]
/// as the main state, with the specific type [T].
/// Events are emited from the [loadData] method, to signify the change of state
/// within the network request process.
///
/// If the `autoLoad` parameter is set to `true`, the `loadData()` method
/// will be called in the initialization process.
/// This parameter is set to `true` by default.
///
/// Parameters:
/// - S: service that extends [BaseService].
/// - T: model which represents the type of the state.
abstract class RequestRepository<S extends BaseService, T>
    extends Cubit<RequestState<T>> {
  /// Agent that handles retrieve of pure raw information from the API or Firebase...
  final S service;

  /// Call the [loadData] method upon object initialization.
  ///
  /// Default is set to [true].
  final bool autoLoad;

  RequestRepository(this.service, {this.autoLoad = true})
      : super(RequestState.init()) {
    if (autoLoad == true) loadData();
  }

  /// Overridable method that handles data load from the service.
  Future<void> loadData() async {
    emit(RequestState.loading(state.value));

    try {
      emit(RequestState.loaded(await fetchData()));
    } catch (e) {
      emit(RequestState.error(e.toString()));
    }
  }

  /// Overridable method that handles data fetching and mapping.
  Future<T> fetchData();

  /// Simple data getter from the state's value.
  T? get data => state.value;
}
