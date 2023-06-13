import 'package:earnipay_test/domain/domain.dart';

class GetPhotoUsecase {
  GetPhotoUsecase(this.repository);

  final HomeRepository repository;

  Future<List<Photo>> call({int? limit, int? page}) async {
    return repository.getPhotos(
      limit: limit,
      page: page,
    );
  }
}
