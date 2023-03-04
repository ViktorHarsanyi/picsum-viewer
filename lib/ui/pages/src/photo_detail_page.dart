import 'package:flutter/material.dart';
import 'package:pic_sum/consts.dart';
import 'package:pic_sum/data/data.dart';
import 'package:pic_sum/ui/ui.dart';

class PhotoDetailsPage extends StatelessWidget {
  final Photo photo;
  const PhotoDetailsPage(this.photo, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(photo.author),
        centerTitle: true,
      ),
      body: InteractiveViewer(
        child: Center(
          child: PhotoImage(
              '$baseDownloadUrl/${photo.id}/${photo.width}/${photo.height}'),
        ),
      ),
    );
  }
}
