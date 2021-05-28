import 'package:flutter_bloc/flutter_bloc.dart';

import '../flutter_request_bloc.dart';

/// Cubit that simplyfies state and repository management. It uses [RequestState]
/// as the main state, with the specific type [T].
/// The repository [R] is also used to download the data.
/// Events are emited from the [loadData] method, to signify the change of state
/// within the network request process.
///
/// If the `autoLoad` parameter is set to `true`, the `loadData()` method
/// will be called in the initialization process.
/// This parameter is set to `true` by default.
///
/// Parameters:
/// - R: repository that extends [BaseRepository].
/// - T: model which represents the type of the state.
abstract class RequestCubit<R extends BaseRepository, T>
    extends Cubit<RequestState<T>> {
  /// [BaseRepository] used to storage and manage all the data coming from the
  /// specific [BaseService]`.
  final R repository;

  /// Call the [loadData] method upon object initialization.
  ///
  /// Default is set to [true].
  final bool autoLoad;

  RequestCubit(this.repository, {this.autoLoad = true})
      : super(RequestState.init()) {
    if (autoLoad == true) loadData();
  }

  /// Overridable method that handles data load & applying models within
  /// the repository
  Future<void> loadData();
}
