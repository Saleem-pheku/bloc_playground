// here we are building mainly three states
// loading state
// loaded state
// error state

import 'package:bloc_playground/models/photos_response.dart';
import 'package:equatable/equatable.dart';

abstract class PhotosState extends Equatable {}

class PhotosLoadingState extends PhotosState {
  @override
  List<Object?> get props => [];
}

class PhotosLoadedState extends PhotosState {
  List<PhotosResponse> photos = [];
  final bool hasNext;

  PhotosLoadedState(this.photos, this.hasNext);

  @override
  List<Object?> get props => [photos];
}

class PhotosErrorState extends PhotosState {
  final String error;

  PhotosErrorState(this.error);

  @override
  List<Object?> get props => [error];
}
