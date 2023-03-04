import 'package:flutter/material.dart';
import 'package:pic_sum/data/data.dart';

import 'photo_image.dart';

class PhotoTile extends StatelessWidget {
  final Photo photo;
  const PhotoTile(this.photo, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AspectRatio(
          aspectRatio: 3 / 2,
          child: PhotoImage(photo.downloadUrl),
        ),
        Flexible(
          child: Column(
            children: [
              Text(photo.author, overflow: TextOverflow.ellipsis),
              Text(photo.id, overflow: TextOverflow.ellipsis),
            ],
          ),
        ),
      ],
    );
  }
}
