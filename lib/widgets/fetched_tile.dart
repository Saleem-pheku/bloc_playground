// ignore_for_file: prefer_const_constructors

import 'package:bloc_playground/bloc/photos_state.dart';
import 'package:bloc_playground/models/photos_response.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
//import 'package:infinite_listview/infinite_listview.dart';
import 'package:infinite_widgets/infinite_widgets.dart';

class DataTileWidget extends StatelessWidget {
  final List<PhotosResponse> photos;
  const DataTileWidget({super.key, required this.photos});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          ListView.builder(
              // nextData: ,
              // hasNext: ,
              shrinkWrap: true,
              primary: true,
              itemCount: photos.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                  child: Card(
                    elevation: 9,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        gradient: LinearGradient(
                          colors: [
                            Colors.white,
                            Colors.blue,
                          ],
                          begin: const FractionalOffset(0.0, 1.0),
                          end: const FractionalOffset(1.0, 0.0),
                          stops: [0.0, 1.0],
                          tileMode: TileMode.clamp,
                        ),
                      ),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                              'https://icon-library.com/images/graphics-design-icon/graphics-design-icon-6.jpg'),
                          // foregroundImage:
                          //     NetworkImage(photos[index].thumbnailUrl),
                        ),
                        title: Text(photos[index].id.toString()),
                        subtitle: Text(photos[index].title),
                      ),
                    ),
                  ),
                );
              }),
        ],
      ),
    );
  }
}
