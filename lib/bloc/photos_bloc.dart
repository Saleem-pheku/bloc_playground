import 'package:bloc_playground/bloc/photos_event.dart';
import 'package:bloc_playground/bloc/photos_state.dart';
import 'package:bloc_playground/models/photos_response.dart';
import 'package:bloc_playground/services/api_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
//////////////////////////////////
/// HERE IS OUR CORE ////////////
/// The middle man "Bloc"///////
///////////////////////////////
/// acts like a controller ///
/// interms of GetX /////////
////////////////////////////

class PhotosBloc extends Bloc<PhotosEvent, PhotosState> {
  final PhotosFetching _photosFetching;

  PhotosBloc(this._photosFetching) : super(PhotosLoadingState()) {
    on<LoadPhotosEvent>((event, emit) async {
      if (event is PhotosEvent) {
        emit(PhotosLoadingState());
        try {
          final photos = await _photosFetching.getPhotos();
          emit(PhotosLoadedState(photos));
        } catch (e) {
          emit(PhotosErrorState(e.toString()));
        }
      }
    });
  }
}
