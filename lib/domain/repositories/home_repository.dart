import 'package:earnipay_test/domain/domain.dart';

abstract class HomeRepository {
  Future<List<Photo>> getPhotos({int? limit, int? page});
}
