import 'package:earnipay_test/core/core.dart';
import 'package:earnipay_test/data/data.dart';
import 'package:earnipay_test/domain/domain.dart';
import 'package:earnipay_test/injector.dart';
import 'package:isar/isar.dart';

final class HomeRepositoryImpl extends HomeRepository {
  HomeRepositoryImpl(
      {required HomeRemoteDataSource remoteDataSource,
      required Isar isar,
      required CacheService cacheService})
      : _remoteDataSource = remoteDataSource,
        _isar = isar,
        _cacheService = cacheService;
  final HomeRemoteDataSource _remoteDataSource;
  final Isar _isar;
  final CacheService _cacheService;

  int _offset = 0;
  final int _cacheTimeout = 5 * 60 * 1000;

  @override
  Future<List<Photo>> getPhotos({int? limit, int? page}) async {
    try {
      final hasInternet = await getIt<NetworkInfo>().isConnected;
      final lastCacheTime =
          await _isar.isarPhotos.where().sortByTimestampDesc().findFirst();
      final newLimit = limit ?? AppConstants.photosLimit;
      if (!hasInternet) {
        final response = await _cacheService.paginate<PhotoModel, IsarPhoto>(
            limit: newLimit,
            offset: _offset,
            mapper: (e) => e.toPhotoModel(),
            distinct: [
              const DistinctProperty(property: r'photoId', caseSensitive: true)
            ]);
        _offset += (limit ?? AppConstants.photosLimit);
        return response;
      }

      if (lastCacheTime != null) {
        print("cached response!!!!!!!");
        final diff = DateTime.now()
            .difference((lastCacheTime.timestamp) ?? DateTime.now());
        if (diff.inMilliseconds < _cacheTimeout) {
          final response = await _cacheService.paginate<PhotoModel, IsarPhoto>(
              limit: newLimit,
              offset: _offset,
              mapper: (e) => e.toPhotoModel(),
              distinct: [
                const DistinctProperty(
                    property: r'photoId', caseSensitive: true)
              ]);
          _offset += (limit ?? AppConstants.photosLimit);
          if (response.isNotEmpty || response.length == newLimit) {
            _offset += (limit ?? AppConstants.photosLimit);
            return response;
          }
          _offset = 0;
        }
        print("timeout!!!!!!!");
        _offset = 0;
      }
      print("new api call!!!!!!!");
      final response = _getPhotos(limit: newLimit, page: page);
      return response;
    } catch (e, st) {
      print(st);
      rethrow;
    }
  }

  Future<List<Photo>> _getPhotos({int? limit, int? page}) async {
    try {
      final response =
          await _remoteDataSource.getPhotos(limit: limit, page: page);
      await _cacheService.clear<IsarPhoto>();
      await _cacheService.save<PhotoModel, IsarPhoto>(
        response,
        mapper: (e) => e.toIsarPhoto(),
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
