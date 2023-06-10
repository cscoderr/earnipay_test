import 'package:earnipay_test/data/data.dart';
import 'package:earnipay_test/domain/domain.dart';

final class HomeRepositoryImpl extends HomeRepository {
  HomeRepositoryImpl({required HomeRemoteDataSource remoteDataSource})
      : _remoteDataSource = remoteDataSource;
  final HomeRemoteDataSource _remoteDataSource;
  @override
  Future<List<Photo>> getPhotos({int? limit, int? page}) async {
    return await _remoteDataSource.getPhotos(limit: limit, page: page);
  }
}
