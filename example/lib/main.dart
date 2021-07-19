import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_request_bloc/flutter_request_bloc.dart';
import 'package:flutter_request_bloc/widgets/request_builder.dart';

import 'repository.dart';
import 'service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => TodosRepository(
            TodosService(Dio()),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Flutter Request Bloc')),
      body: Center(
        child: RequestBuilder<TodosRepository, String>(
          onInit: (context, state) => Text('Hello world!'),
          onLoading: (context, state, value) => CircularProgressIndicator(),
          onLoaded: (context, state, value) => Text(value!),
          onError: (context, state, error) => Text(error!),
        ),
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            child: Text('Load'),
            onPressed: () => context.read<TodosRepository>().loadData(),
          ),
          SizedBox(height: 8),
          FloatingActionButton(
            child: Text('Error'),
            onPressed: () => context.read<TodosRepository>().loadError(),
          ),
        ],
      ),
    );
  }
}
