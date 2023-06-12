import 'package:earnipay_test/core/core.dart';
import 'package:earnipay_test/data/data.dart';
import 'package:earnipay_test/domain/domain.dart';
import 'package:isar/isar.dart';

abstract class HomeLocalDataSource {
  Future<List<Photo>> getPhotos({required int limit});

  Future<void> savePhotos(List<PhotoModel> photos);

  Future<IsarPhoto?> lastCachedPhoto();

  Future<List<Photo>?> getPhotosWithDuration(
      {required int limit, required IsarPhoto photo});
}

class HomeLocalDataSourceImpl extends HomeLocalDataSource {
  HomeLocalDataSourceImpl(
      {required Isar isar, required CacheService cacheService})
      : _isar = isar,
        _cacheService = cacheService;

  final Isar _isar;

  final CacheService _cacheService;

  int _offset = 0;
  bool _hasTimeout = false;
  final int _cacheTimeout = 5 * 60 * 1000;

  @override
  Future<List<PhotoModel>> getPhotos({required int limit}) async {
    final response = await _cacheService.paginate<PhotoModel, IsarPhoto>(
        limit: limit,
        offset: _offset,
        mapper: (e) => e.toPhotoModel(),
        distinct: [
          const DistinctProperty(property: r'photoId', caseSensitive: true)
        ]);
    _offset += limit;
    return response;
  }

  @override
  Future<IsarPhoto?> lastCachedPhoto() {
    return _isar.isarPhotos.where().sortByTimestampDesc().findFirst();
  }

  @override
  Future<void> savePhotos(List<PhotoModel> photos) {
    return _cacheService.save<PhotoModel, IsarPhoto>(
      photos,
      mapper: (e) => e.toIsarPhoto(),
    );
  }

  @override
  Future<List<Photo>?> getPhotosWithDuration(
      {required int limit, required IsarPhoto photo}) async {
    if (_hasTimeout) return null;
    final diff = DateTime.now().difference((photo.timestamp) ?? DateTime.now());
    if (diff.inMilliseconds < _cacheTimeout) {
      final response = await getPhotos(limit: limit);
      if (response.isNotEmpty && response.length == limit) {
        return response;
      }
    }
    await _cacheService.clear<IsarPhoto>();
    _hasTimeout = true;
    return null;
  }
}
