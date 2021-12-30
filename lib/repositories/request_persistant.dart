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
    if (state.status != RequestStatus.loaded) loadData();
  }

  @override
  RequestState<T> fromJson(Map<String, dynamic> json) =>
      RequestState<T>.fromJson(
        json,
        valueBuilder: valueFromJson,
      );

  @override
  Map<String, dynamic>? toJson(RequestState<T> state) {
    if (state.status == RequestStatus.loaded)
      return state.toJson(valueBuilder: valueToJson);
    return null;
  }

  /// Method that deserialize the data in JSON form to an actual instance of
  /// the object.
  T valueFromJson(Map<String, dynamic> json);

  /// Method that serialize the data to a JSON form.
  Map<String, dynamic>? valueToJson(T? value);
}
