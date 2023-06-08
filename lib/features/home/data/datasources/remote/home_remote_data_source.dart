import 'package:earnipay_test/core/core.dart';
import 'package:http/http.dart' as http;

abstract class HomeRemoteDataSource {
  /// Gets the cached [NumberTriviaModel] which was gotten the last time
  /// the user had an internet connection.
  ///
  /// Throws [CacheException] if no cached data is present.
  Future<void> getPhotos();
}

final class HomeRemoteDataSourceImpl extends HomeRemoteDataSource {
  HomeRemoteDataSourceImpl({required http.Client httpClient})
      : _httpClient = httpClient;
  final http.Client _httpClient;

  @override
  Future<void> getPhotos() async {
    try {
      final response = await _httpClient.get(
        Uri.parse('${AppConstants.baseUrl}/photos'),
      );
      print(response.body);
      if (response.statusCode == 200) {
        // return response.body;
      } else {
        // throw ServerException();
      }
    } catch (e) {}
  }
}
