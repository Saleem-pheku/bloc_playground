import 'package:bloc_playground/bloc/photos_bloc.dart';
import 'package:bloc_playground/bloc/photos_event.dart';
import 'package:bloc_playground/bloc/photos_state.dart';
import 'package:bloc_playground/services/api_services.dart';
import 'package:bloc_playground/widgets/fetched_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: RepositoryProvider(
        create: (context) => PhotosFetching(),
        child: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

/// THIS PAGE GOES IN VIEWS ///

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PhotosBloc(
        RepositoryProvider.of<PhotosFetching>(context),
      )..add(LoadPhotosEvent()),
      child: Scaffold(
          body: BlocBuilder<PhotosBloc, PhotosState>(builder: (context, state) {
        if (state is PhotosLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is PhotosLoadedState) {
          return SingleChildScrollView(
            child: Center(
              child: Column(children: [DataTileWidget(photos: state.photos)]),
            ),
          );
        }
        if (state is PhotosErrorState) {
          const Center(
            child: Text('ERROR UNABLE TO LOAD THE DATA'),
          );
        }
        return Container();
      })),
    );
  }
}
