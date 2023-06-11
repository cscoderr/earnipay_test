import 'package:earnipay_test/domain/domain.dart';

final class GetPhotoUsecase {
  GetPhotoUsecase(this.repository);

  final HomeRepository repository;

  Future<List<Photo>> call({int? limit, int? page}) {
    return repository.getPhotos(
      limit: limit,
      page: page,
    );
  }
}
