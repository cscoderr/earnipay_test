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
  });
}
