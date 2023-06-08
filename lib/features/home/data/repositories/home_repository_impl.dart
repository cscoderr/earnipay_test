import 'package:earnipay_test/features/home/home.dart';

final class HomeRepositoryImpl extends HomeRepository {
  HomeRepositoryImpl({required HomeRemoteDataSource remoteDataSource})
      : _remoteDataSource = remoteDataSource;
  final HomeRemoteDataSource _remoteDataSource;
  @override
  Future<void> getPhotos() async {
    await _remoteDataSource.getPhotos();
  }
}
