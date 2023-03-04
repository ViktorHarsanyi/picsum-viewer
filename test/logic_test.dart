import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pic_sum/data/data.dart';
import 'package:pic_sum/logic/logic.dart';
import 'package:pic_sum/service/service.dart';



void main() {
  group('PicsCubit', () {
    late PhotoService photoService;
    late PicsCubit picsCubit;

    final List<Photo> mockPhotos = [
      Photo(
        id: '1',
        author: 'Author 1',
        width: 300,
        height: 200,
        url: 'https://picsum.photos/300/200?random=1',
        downloadUrl: 'https://picsum.photos/id/1/300/200',
      ),
      Photo(
        id: '2',
        author: 'Author 2',
        width: 300,
        height: 200,
        url: 'https://picsum.photos/300/200?random=2',
        downloadUrl: 'https://picsum.photos/id/2/300/200',
      ),
      Photo(
        id: '3',
        author: 'Author 3',
        width: 300,
        height: 200,
        url: 'https://picsum.photos/300/200?random=3',
        downloadUrl: 'https://picsum.photos/id/3/300/200',
      ),
    ];

    setUp(() {
      photoService = PhotoService();
      picsCubit = PicsCubit(service: photoService);
    });

    tearDown(() {
      picsCubit.close();
    });

    test('initial state is Empty', () {
      expect(picsCubit.state, equals(const Empty()));
    });

    blocTest<PicsCubit, PicsState>(
      'emits [Update, PageStatus] when PicsCubit.loadPhotos is called',
      build: () => picsCubit,
      act: (cubit) => cubit.loadPhotos(),
      expect: () => [
      isA<Update>(), isA<PageStatus>(),
      ],
    );


    blocTest<PicsCubit, PicsState>(
      'emits [Update and PageStatus] when PicsCubit.setPageSize is called',
      build: () => picsCubit,
      act: (cubit) => cubit.setPageSize(20),
      expect: () => [
        isA<Update>(),
        isA<PageStatus>(),
      ],
    );

    blocTest<PicsCubit, PicsState>(
      'emits [UIMessage] when PicsCubit.filterByAuthor is called with matching filter',
      build: () => picsCubit,
      act: (cubit) => cubit.filterByAuthor('A'),
      expect: () => [
         isA<UIMessage>()
      ],
    );

    blocTest<PicsCubit, PicsState>(
      'emits [Empty] when PicsCubit.filter is called with non-matching filter',
      build: () => picsCubit,
      act: (cubit) => cubit.filterByAuthor('XYZ'),
      expect: () => [
        const UIMessage('No matches found.', false),
      ],
    );
  });
}
