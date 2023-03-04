import 'package:flutter_test/flutter_test.dart';
import 'package:pic_sum/data/data.dart';
import 'package:pic_sum/service/service.dart';


void main() {

    group('PicsumApi', () {
      late PhotoService api;

      setUp(() {
        api = PhotoService();
      });

      test('getPhotos returns a list of photos', () async {
        final photos = await api.getPhotos(limit: 10);
        expect(photos, isA<List<Photo>>());
      });

    });
}
