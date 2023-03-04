import 'dart:convert';

import 'package:pic_sum/consts.dart';

List<Photo> photoFromJson(String str) =>
    List<Photo>.from(json.decode(str).map((x) => Photo.fromJson(x)));

class Photo {
  Photo({
    required this.id,
    required this.author,
    required this.width,
    required this.height,
    required this.url,
    required this.downloadUrl,
  });

  final String id;
  final String author;
  final int width;
  final int height;
  final String url;
  final String downloadUrl;

  factory Photo.fromJson(Map<String, dynamic> json) {
    final id = json["id"];
    return Photo(
      id: id,
      author: json["author"],
      width: json["width"],
      height: json["height"],
      url: json["url"],
      downloadUrl:
          '$baseDownloadUrl/$id/${scalar.dx.toInt()}/${scalar.dy.toInt()}',
    );
  }
}
