import 'package:flutter/material.dart';

class PhotoImage extends StatelessWidget {
  final String url;
  const PhotoImage(this.url, {super.key});

  @override
  Widget build(BuildContext context) {
    return Image.network(
      url,
      loadingBuilder: (BuildContext context, Widget child,
          ImageChunkEvent? loadingProgress) {
        if (loadingProgress == null) {
          return child;
        }
        return Center(
          child: LinearProgressIndicator(
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded /
                    loadingProgress.expectedTotalBytes!
                : null,
          ),
        );
      },
    );
  }
}
