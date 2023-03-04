import 'photo_model.dart';

class PhotoRepository {
  int currentPage;
  int limit;
  String filter;
  final List<Photo> _cache;
  final List<Photo> _filtered;
  final int pageCount;

  PhotoRepository(
    this.pageCount, {
    this.currentPage = 1,
    this.limit = 30,
    this.filter = '',
  })  : _cache = [],
        _filtered = [];

  void addPhotos(List<Photo> photos) {
    _cache.clear();
    _cache.addAll(photos);
  }

  List<Photo> filterMatchingAuthors(String runes) {
    _filtered.clear();
    final filtered =
        _cache.where((element) => element.author.toLowerCase().contains(runes));
    if (filtered.isNotEmpty) {
      _filtered.addAll(filtered);
      return _filtered;
    }
    return [];
  }

  List<Photo> get cachedPhotos => _cache;
}
