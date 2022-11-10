import 'dart:convert';

import 'package:bloc_playground/models/photos_response.dart';
import 'package:bloc_playground/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

int myLimit = 6;

/// USING HTTP /// not needed now ///
// class PhotosFetching {
//   final String _baseUrl = AppConstants.apiUrl;

//   Future<List<PhotosResponse>> getPhotos() async {
//     var response =
//         await http.get(Uri.parse('$_baseUrl/photos?_start=0&_limit=5'));

//     List<PhotosResponse> photosResponse = (json.decode(response.body))
//         .map<PhotosResponse>(
//             (jsonPhotos) => PhotosResponse.fromJson(jsonPhotos))
//         .toList();
//     if (response.statusCode == 200) {
//       return photosResponse;
//     } else {
//       throw Exception("Failed to load");
//     }
//   }
// }

// USING DIO //
class PhotosFetching {
  static Future<List<PhotosResponse>> fetchPhotos(int start) async {
    try {
      var dio = Dio();
      var response = await dio.get(
        '${AppConstants.apiUrl}/photos',
        queryParameters: {
          "_start": start,
          "_limit": 10,
        },
      );
      if (response.statusCode == 200) {
        return photosResponseFromJson(json.encode(response.data));
      }
      return [];
    } catch (err) {
      return [];
    }
  }
}
