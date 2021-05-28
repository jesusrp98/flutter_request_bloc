import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../flutter_request_bloc.dart';

typedef RequestWidgetBuilderInit<T> = Widget Function(
  BuildContext context,
  RequestState<T> state,
);

typedef RequestWidgetBuilderLoaded<T> = Widget Function(
  BuildContext context,
  RequestState<T> state,
  T? value,
);

typedef RequestWidgetBuilderError<T> = Widget Function(
  BuildContext context,
  RequestState<T> state,
  String? errorMessage,
);

/// This widget makes contruction UI using [Request] object pretty easily.
/// It has a [RequestWidgetBuilder] parameter for each [RequestState] value,
/// so that the interface can adapt to the current status of the request.
class RequestBuilder<C extends RequestCubit, T> extends StatelessWidget {
  /// Builder method called when the [RequestState] is 'init'.
  final RequestWidgetBuilderInit<T>? onInit;

  /// Builder method called when the [RequestState] is 'loading'.
  final RequestWidgetBuilderLoaded<T>? onLoading;

  /// Builder method called when the [RequestState] is 'loaded'.
  final RequestWidgetBuilderLoaded<T>? onLoaded;

  /// Builder method called when the [RequestState] is 'error'.
  final RequestWidgetBuilderError<T>? onError;

  const RequestBuilder({
    Key? key,
    this.onInit,
    this.onLoading,
    this.onLoaded,
    this.onError,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<C, RequestState>(
      listener: (context, state) => null,
      builder: (context, state) {
        switch (state.status) {
          case RequestStatus.init:
            if (onInit != null) {
              return onInit!(context, state as RequestState<T>);
            }
            break;

          case RequestStatus.loading:
            if (onLoading != null) {
              return onLoading!(context, state as RequestState<T>, state.value);
            }
            break;

          case RequestStatus.loaded:
            if (onLoaded != null) {
              return onLoaded!(context, state as RequestState<T>, state.value);
            }
            break;

          case RequestStatus.error:
            if (onError != null) {
              return onError!(
                context,
                state as RequestState<T>,
                state.errorMessage,
              );
            }
            break;
        }

        return SizedBox();
      },
    );
  }
}
