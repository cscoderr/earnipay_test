import 'package:earnipay_test/features/home/home.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

final getIt = GetIt.I;

void setupInjectors() {
  getIt.registerLazySingleton<HomeRemoteDataSource>(
      () => HomeRemoteDataSourceImpl(
            httpClient: http.Client(),
          ));

  getIt.registerLazySingleton<HomeRepository>(() => HomeRepositoryImpl(
        remoteDataSource: getIt<HomeRemoteDataSource>(),
      ));

  getIt.registerLazySingleton<GetPhotoUsecase>(() => GetPhotoUsecase(
        getIt<HomeRepository>(),
      ));
}
