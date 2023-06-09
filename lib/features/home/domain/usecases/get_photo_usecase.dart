import 'package:earnipay_test/features/home/home.dart';

final class GetPhotoUsecase {
  GetPhotoUsecase(this.repository);

  final HomeRepository repository;

  Future<List<Photo>> call() {
    return repository.getPhotos();
  }
}
