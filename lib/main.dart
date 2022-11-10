// ignore_for_file: prefer_const_constructors

import 'package:bloc_playground/bloc/photos_bloc/photos_bloc.dart';
import 'package:bloc_playground/bloc/photos_bloc/photos_event.dart';
import 'package:bloc_playground/bloc/photos_bloc/photos_state.dart';
import 'package:bloc_playground/services/api_services.dart';
import 'package:bloc_playground/widgets/fetched_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:infinite_widgets/infinite_widgets.dart';

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
      create: (context) => PhotosBloc()..add(LoadPhotosEvent()),
      child: Scaffold(
          body: BlocBuilder<PhotosBloc, PhotosState>(builder: (context, state) {
        if (state is PhotosLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is PhotosLoadedState) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: InfiniteListView(
              itemCount: state.photos.length,
              itemBuilder: (context, index) {
                return DataCard(
                    imageUrl: state.photos[index].thumbnailUrl,
                    postId: state.photos[index].id,
                    title: state.photos[index].title);
              },
              hasNext: state.hasNext,
              nextData: () {
                BlocProvider.of<PhotosBloc>(context).add(LoadPhotosEvent());
              },
              loadingWidget: SpinKitPumpingHeart(
                color: Colors.deepPurple,
              ),
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
