import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../flutter_request_bloc.dart';

/// Repository that extends on [RequestRepository] by adding the ability to store its
/// internal state using [HydratedBloc]. Serialization is handled automatically
/// by the state and the cubit state.
///
/// Parameters:
/// - S: service that extends [BaseService].
/// - T: model which represents the type of the state.
abstract class RequestPersistantRepository<S extends BaseService, T>
    extends RequestRepository<S, T> with HydratedMixin {
  RequestPersistantRepository(S service) : super(service, autoLoad: false) {
    hydrate();
  }

  @override
  RequestState<T> fromJson(Map<String, dynamic> json) {
    return RequestState<T>.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson(RequestState<T> state) {
    return state.toJson();
  }
}
