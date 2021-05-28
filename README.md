# Flutter Request BLoC

[![Package](https://img.shields.io/pub/v/flutter_request_bloc.svg?style=for-the-badge)](https://pub.dartlang.org/packages/flutter_request_bloc)
[![Patreon](https://img.shields.io/badge/Support-Patreon-orange.svg?style=for-the-badge)](https://www.patreon.com/jesusrp98)
[![License](https://img.shields.io/github/license/jesusrp98/flutter_request_bloc.svg?style=for-the-badge)](https://www.gnu.org/licenses/gpl-3.0.en.html)

Package that facilitates **REST API** and other network calls using `flutter_bloc` and `hydrated_bloc`.

*Before taking a look a this package, please visit the [BLoC library](https://bloclibrary.dev/#/) page, in order to get familiarized with various concept related to this package.*


## Usage

Here's a list of all the components have been built inside this package, and how they interact with one another. If you need more information about how everything works, please take a look at the [example](https://github.com/jesusrp98/flutter_request_bloc/tree/master/example) folder provided with the project, or create a new issue.

### RequestState

The status of a request made by a `Request` object inside this library can be represented using the `RequestState` enum. This are the possible values for the status:

- **RequestState.init**
- **RequestState.loading**
- **RequestState.loaded**
- **RequestState.error**

### RequestCubit

The `RequestCubit` object is the base of this package, and allows you to easily create a `cubit` object that handles all data related to any data request.

It makes use of both a `BaseRepository` and a `BaseService` object. This way, the 'request' class logic is completly separated from the downloading and managing aspect of the information it controlls.

The `loadData` is the method inside the 'request' object that handles all the event-emiting logic related to a `cubit` object. Inside it, you can call the `fetchData` method inside the `BaseRepository` obejct you're using at that time.

You can use the `autoLoad` constructor parameter to automatically call the `loadData` method upon its initialization.

```
class TodosCubit extends RequestCubit<TodosRepository, String> {
  TodosCubit(TodosRepository repository)
      : super(
          repository,
          autoLoad: false,
        );

  @override
  Future<void> loadData() async {
    emit(RequestState.loading(state.value));

    try {
      final data = await repository.fetchData();

      emit(RequestState.loaded(data));
    } catch (e) {
      emit(RequestState.error(e.toString()));
    }
  }
}
```

### RequestPersistantCubit

This object is pretty similiar to the one above, with the difference that it has te ability to make its data 'persistant', using the `hydrated_bloc` library.

It also has the same front-end API as `RequestCubit`.

```
class TodosCubit extends RequestPersistantCubit<TodosRepository, String> {
  TodosCubit(TodosRepository repository) : super(repository);

  @override
  Future<void> loadData() async {
    emit(RequestState.loading(state.value));

    try {
      final data = await repository.fetchData();

      emit(RequestState.loaded(data));
    } catch (e) {
      emit(RequestState.error(e.toString()));
    }
  }
}
```

### RequestBuilder

This widget makes contruction UI using `Request` object pretty easily. It has a `RequestWidgetBuilder` parameter for each `RequestState` value, so that the interface can adapt to the current status of the request.

```
RequestBuilder<TodosCubit, String>(
    onInit: (context, state) => Text('Hello world!'),
    onLoading: (context, state, value) => CircularProgressIndicator(),
    onLoaded: (context, state, value) => Text(value!),
    onError: (context, state, error) => Text(error!),
)
```

## Example

If you want to take a deeper look at the example, take a look at the [example](https://github.com/jesusrp98/flutter_request_bloc/tree/master/example) folder provided with the project.

## Getting Started

This project is a starting point for a Dart [package](https://flutter.io/developing-packages/), a library module containing code that can be shared easily across multiple Flutter or Dart projects.

For help getting started with Flutter, view our [online documentation](https://flutter.io/docs), which offers tutorials, samples, guidance on mobile development, and a full API reference.

## Built with

- [Flutter](https://flutter.dev/) - Beautiful native apps in record time.
- [Android Studio](https://developer.android.com/studio/index.html/) - Tools for building apps on every type of Android device.
- [Visual Studio Code](https://code.visualstudio.com/) - Code editing. Redefined.

## Authors

- **Jesús Rodríguez** - you can find me on [GitHub](https://github.com/jesusrp98), [Twitter](https://twitter.com/jesusrp98) & [Reddit](https://www.reddit.com/user/jesusrp98).

## License

This project is licensed under the GNU GPL v3 License - see the [LICENSE](LICENSE) file for details.
