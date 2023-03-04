import 'package:flutter_test/flutter_test.dart';
import 'package:pic_sum/data/data.dart';

void main() {
  group('PhotoRepository', () {
    late PhotoRepository repository;

    setUp(() {
      repository = PhotoRepository(3);
    });

    test('adds photos to cache', () {
      final photos = [
        Photo(
          author: 'Bar Foo',
          id: '',
          width: 0,
          height: 0,
          url: '',
          downloadUrl: '',
        ),
        Photo(
          author: 'XY',
          id: '',
          width: 0,
          height: 0,
          url: '',
          downloadUrl: '',
        ),
        Photo(
          author: 'ABC',
          id: '',
          width: 0,
          height: 0,
          url: '',
          downloadUrl: '',
        )
      ];
      repository.addPhotos(photos);
      expect(repository.cachedPhotos, equals(photos));
    });

    test('filters photos by matching authors', () {
      final photos = [
        Photo(
          author: 'Foo Bar',
          id: '',
          width: 0,
          height: 0,
          url: '',
          downloadUrl: '',
        ),
        Photo(
          author: 'Jane Bar',
          id: '',
          width: 0,
          height: 0,
          url: '',
          downloadUrl: '',
        ),
        Photo(
          author: 'Jack Smith',
          id: '',
          width: 0,
          height: 0,
          url: '',
          downloadUrl: '',
        )
      ];
      repository.addPhotos(photos);

      expect(repository.filterMatchingAuthors('bar'),
          equals([photos[0], photos[1]]));
      expect(repository.filterMatchingAuthors('ane'), equals([photos[1]]));
      expect(repository.filterMatchingAuthors('smith'), equals([photos[2]]));
      expect(repository.filterMatchingAuthors('jackson'), isEmpty);
    });
  });
}
