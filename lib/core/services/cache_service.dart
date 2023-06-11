import 'package:isar/isar.dart';

abstract class CacheService {
  Future<void> save<T, E>(List<T> data, {E Function(T)? mapper});
  Future<List<T>> paginate<T, E>(
      {T Function(E p1)? mapper,
      required int limit,
      required int offset,
      List<DistinctProperty>? distinct});
  Future<void> clear<E>();
}

class IsarCacheService extends CacheService {
  IsarCacheService({required Isar isar}) : _isar = isar;
  final Isar _isar;

  @override
  Future<List<T>> paginate<T, E>({
    required int limit,
    required int offset,
    T Function(E p1)? mapper,
    List<DistinctProperty>? distinct,
  }) async {
    final cachedResponse = await _isar.collection<E>().buildQuery(
      whereClauses: [],
      distinctBy: distinct ?? [],
      offset: offset,
      limit: limit,
    ).findAll();

    final response = mapper != null
        ? (cachedResponse.cast<E>()).map(mapper).toList()
        : cachedResponse as List<T>;
    return response;
  }

  @override
  Future<void> save<T, E>(List<T> data, {E Function(T)? mapper}) async {
    await _isar.writeTxn(() async {
      await _isar
          .collection<E>()
          .putAll(mapper != null ? data.map(mapper).toList() : data as List<E>);
    });
  }

  @override
  Future<void> clear<E>() async {
    await _isar.writeTxn(() async {
      await _isar.collection<E>().clear();
    });
  }
}
