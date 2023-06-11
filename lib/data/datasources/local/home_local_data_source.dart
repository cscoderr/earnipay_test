import 'package:earnipay_test/data/data.dart';
import 'package:earnipay_test/domain/domain.dart';

abstract class HomeLocalDataSource {
  Future<List<Photo>> getPhotos({int? limit, int? page});
}

class HomeLocalDataSourceImpl extends HomeLocalDataSource {
  @override
  Future<List<PhotoModel>> getPhotos({int? limit, int? page}) {
    // TODO: implement getPhotos
    throw UnimplementedError();
  }
}
