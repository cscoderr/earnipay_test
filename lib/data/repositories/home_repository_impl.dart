import 'dart:developer';

import 'package:earnipay_test/core/core.dart';
import 'package:earnipay_test/data/data.dart';
import 'package:earnipay_test/domain/domain.dart';
import 'package:earnipay_test/injector.dart';

final class HomeRepositoryImpl extends HomeRepository {
  HomeRepositoryImpl({
    required HomeRemoteDataSource remoteDataSource,
    required HomeLocalDataSource localDataSource,
  })  : _remoteDataSource = remoteDataSource,
        _localDataSource = localDataSource;
  final HomeRemoteDataSource _remoteDataSource;
  final HomeLocalDataSource _localDataSource;

  @override
  Future<List<Photo>> getPhotos({int? limit, int? page}) async {
    try {
      final hasInternet = await getIt<NetworkInfo>().isConnected;

      final newLimit = limit ?? AppConstants.photosLimit;
      if (!hasInternet) {
        final response = await _localDataSource.getPhotos(limit: newLimit);
        return response;
      }

      final lastCacheTime = await _localDataSource.lastCachedPhoto();

      if (lastCacheTime != null) {
        final response = await _localDataSource.getPhotosWithDuration(
            limit: newLimit, photo: lastCacheTime);
        if (response != null) {
          log("cached response!!!!!!!");
          return response;
        }
        log("timeout!!!!!!!");
      }
      log("new api call!!!!!!!");
      final response = await _getPhotos(limit: newLimit, page: page);
      return response;
    } catch (e) {
      throw AppException(e.toString());
    }
  }

  Future<List<Photo>> _getPhotos({int? limit, int? page}) async {
    try {
      final response =
          await _remoteDataSource.getPhotos(limit: limit, page: page);

      await _localDataSource.savePhotos(response);
      return response;
    } on AppHttpException catch (e) {
      throw AppException(e.message);
    }
  }
}
