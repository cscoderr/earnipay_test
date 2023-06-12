import 'package:bloc_test/bloc_test.dart';
import 'package:earnipay_test/domain/domain.dart';
import 'package:earnipay_test/presentation/home/home.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetPhotoUsecase extends Mock implements GetPhotoUsecase {}

void main() {
  group('photo_cubit', () {
    late GetPhotoUsecase getPhotoUsecase;
    late PhotoCubit photoCubit;

    setUp(() {
      getPhotoUsecase = MockGetPhotoUsecase();
      photoCubit = PhotoCubit(getPhotoUsecase: getPhotoUsecase);
    });

    test('Initiate state correctly', () {
      expect(photoCubit.state, const PhotoInitial());
    });

    blocTest<PhotoCubit, PhotoState>(
      'verifies getPhotos calls correct page',
      build: () => photoCubit,
      act: (cubit) => cubit.getPhotos(page: 1),
      verify: (_) {
        verify(() => getPhotoUsecase.call(page: 1)).called(1);
      },
    );

    blocTest<PhotoCubit, PhotoState>(
      'emits failure when getPhotos throws',
      setUp: () {
        when(
          () => getPhotoUsecase.call(page: 1),
        ).thenThrow(Exception('oops'));
      },
      build: () => photoCubit,
      act: (cubit) => cubit.getPhotos(page: 1),
      expect: () => <PhotoState>[
        const PhotoState(
          status: PhotoStatus.failure,
          errorMessage: 'Something went wrong',
        ),
      ],
    );

    // blocTest<PhotoCubit, PhotoState>(
    //   'emits success when getWeather returns (fahrenheit)',
    //   build: () => photoCubit,
    //   seed: () => const PhotoState(),
    //   act: (cubit) => cubit.getPhotos(page: 1),
    //   expect: () => <dynamic>[
    //     isA<PhotoState>()
    //         .having((w) => w.status, 'status', PhotoStatus.success)
    //         .having(
    //             (w) => w.photos,
    //             'photos',
    //             isA<PhotoState>()
    //                 .having((w) => w.errorMessage, 'lastUpdated', isNotNull)
    //             // .having((w) => w.condition, 'condition', weatherCondition)
    //             // .having(
    //             //   (w) => w.temperature,
    //             //   'temperature',
    //             //   Temperature(value: weatherTemperature.toFahrenheit()),
    //             // )
    //             // .having((w) => w.location, 'location', weatherLocation),
    //             ),
    //   ],
    // );
  });
}
