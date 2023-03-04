import 'package:flutter/material.dart';
import 'package:pic_sum/data/data.dart';
import 'package:pic_sum/ui/widgets/widgets.dart';

typedef OnPhotoPressed = void Function(Photo photo);

class PhotoGrid extends StatelessWidget {
  final List<Photo> photos;
  final OnPhotoPressed onPressed;
  final ScrollController controller;
  const PhotoGrid(this.photos,
      {required this.controller, required this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      controller: controller,
      itemCount: photos.length,
      itemBuilder: (context, index) {
        final photo = photos[index];
        return GestureDetector(
          onTap: () => onPressed(photo),
          child: PhotoTile(photo),
        );
      },
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 367,
      ),
    );
  }
}
