import 'package:earnipay_test/features/home/home.dart';

abstract class HomeRepository {
  Future<List<Photo>> getPhotos();
}
