import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:pic_sum/data/data.dart';
import 'package:pic_sum/logic/logic.dart';

class PhotoService {
  @visibleForTesting
  static String baseUrl = 'https://picsum.photos/v2';

  factory PhotoService() => _instance;

  const PhotoService._internal(this._client, this._repository);

  static final PhotoService _instance =
      PhotoService._internal(http.Client(), PhotoRepository());

  final http.Client _client;
  final PhotoRepository _repository;

  PageStatus get status => PageStatus(
        _repository.limit,
        _repository.currentPage,
        _repository.filter,
      );
  List<Photo> get cache => _repository.cachedPhotos;

  set currentPage(int page) => _repository.currentPage = page;

  Future<List<Photo>> getPhotos({
    int limit = 10,
  }) async {
    _repository.limit = limit;

    final response = await _client.get(
      Uri.parse('$baseUrl/list?page=${_repository.currentPage}&limit=$limit'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      final List<Photo> photos =
          data.map((json) => Photo.fromJson(json)).toList();
      if(photos.isEmpty) {
        _repository.reachedMaxPage = true;

      } else {
        _repository.addPhotos(photos);
      }
      return _repository.cachedPhotos;
    } else {
      return _repository.cachedPhotos.isNotEmpty
          ? _repository.cachedPhotos
          : [];
    }
  }

  bool nextPage() {
    if (!_repository.reachedMaxPage) {
      _repository.currentPage += 1;
      return true;
    } else {
      return false;
    }
  }

  bool previousPage() {
    _repository.reachedMaxPage = false;
    if (_repository.currentPage > 1) {
      _repository.currentPage -= 1;
      return true;
    }
    return false;
  }

  void resetFilter() {
    _repository.filter = '';
  }

  void resetPage(){
    _repository.currentPage = 1;
  }

  List<Photo> filter(String runes) {
    List<Photo> filtered = _repository.filterMatchingAuthors(runes);
    if (filtered.isNotEmpty) {
      _repository.filter = runes;
    }
    return filtered;
  }
}
