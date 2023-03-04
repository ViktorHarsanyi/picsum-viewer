import 'package:flutter_test/flutter_test.dart';
import 'package:pic_sum/data/data.dart';
import 'package:pic_sum/service/service.dart';

void main() {
  group('PhotoService', () {
    final PhotoService service = PhotoService();

    test('nextPage increments current page', () {
      service.currentPage = 1;
      const expectedPage = 2;

      service.nextPage();

      expect(service.status.pageNumber, expectedPage);
    });

    test('should get photos from API', () async {
      final photos = await service.getPhotos();
      expect(photos.length, 10);
      expect(service.cache, photos);
    });

    test('should get cached photos if API call fails', () async {
      // Manually set an invalid URL to force a 404 response
      PhotoService.baseUrl = 'http://invalid-url';
      try {
        await service.getPhotos();
        fail('Expected an exception to be thrown');
      } catch (e) {
        expect(e, isInstanceOf<Exception>());
        expect(service.cache, isNotEmpty);
      }
    });

    test('should update current page to next page', () {
      service.nextPage();
      expect(service.status.pageNumber, 3);
    });
    test('should reset filter', () {
      service.filter('test');
      service.resetFilter();
      expect(service.status.filter, '');
    });
    test('should not update current page to previous page when on first page',
        () {
      service.previousPage();
      service.previousPage();
      expect(service.previousPage(), false);
      expect(service.status.pageNumber, 1);
    });

    test('should update current page to previous page when not on first page',
        () {
      service.nextPage();
      expect(service.previousPage(), true);
      expect(service.status.pageNumber, 1);
    });

    test('should filter photos by author', () {
      final photos = [
        Photo(
          id: '0',
          author: 'John Doe',
          width: 200,
          height: 300,
          url: 'https://picsum.photos/id/0/200/300',
          downloadUrl: 'https://picsum.photos/id/0/200/300.jpg',
        ),
        Photo(
          id: '1',
          author: 'Jane Smith',
          width: 300,
          height: 400,
          url: 'https://picsum.photos/id/1/300/400',
          downloadUrl: 'https://picsum.photos/id/1/300/400.jpg',
        ),
      ];
      service.cache.addAll(photos);

      final filteredPhotos = service.filter('john');
      expect(filteredPhotos, hasLength(1));
      expect(filteredPhotos[0].author, 'John Doe');
    });
  });
}
