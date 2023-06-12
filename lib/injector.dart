import 'package:earnipay_test/core/core.dart';
import 'package:earnipay_test/data/data.dart';
import 'package:earnipay_test/domain/domain.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:isar/isar.dart';

final getIt = GetIt.I;

void setupInjectors({required Isar isar}) {
  getIt.registerLazySingleton<HomeRemoteDataSource>(
      () => HomeRemoteDataSourceImpl(
            httpClient: http.Client(),
          ));

  getIt
      .registerLazySingleton<HomeLocalDataSource>(() => HomeLocalDataSourceImpl(
            cacheService: getIt<CacheService>(),
            isar: isar,
          ));

  getIt.registerLazySingleton<CacheService>(() => IsarCacheService(
        isar: isar,
      ));

  getIt.registerLazySingleton<HomeRepository>(() => HomeRepositoryImpl(
        remoteDataSource: getIt<HomeRemoteDataSource>(),
        localDataSource: getIt<HomeLocalDataSource>(),
      ));

  getIt.registerLazySingleton<GetPhotoUsecase>(() => GetPhotoUsecase(
        getIt<HomeRepository>(),
      ));

  getIt.registerLazySingleton<NetworkInfo>(() => NetworkInfo(
        InternetConnectionChecker(),
      ));
}
