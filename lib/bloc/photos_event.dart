// as we are just displayin data we may not have many events
// soo here iam creating one event which can be used as per our wish
// maybe for a button click to fetch data

import 'package:bloc_playground/models/photos_response.dart';
import 'package:equatable/equatable.dart';

abstract class PhotosEvent extends Equatable {
  const PhotosEvent();
}

class LoadPhotosEvent extends PhotosEvent {
  // final List<PhotosResponse> data = [];
  @override
  List<Object> get props => [];
}
