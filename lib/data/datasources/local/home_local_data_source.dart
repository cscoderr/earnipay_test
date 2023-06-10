import 'package:earnipay_test/domain/domain.dart';

abstract class HomeLocalDataSource {
  Future<List<Photo>> getPhotos({int? limit, int? page});
}

class HomeLocalDataSourceImpl extends HomeLocalDataSource {
  @override
  Future<List<Photo>> getPhotos({int? limit, int? page}) {
    // TODO: implement getPhotos
    throw UnimplementedError();
  }
}
