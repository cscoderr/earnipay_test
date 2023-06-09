import 'dart:convert';

import 'package:earnipay_test/core/core.dart';
import 'package:earnipay_test/features/home/home.dart';
import 'package:http/http.dart' as http;

abstract class HomeRemoteDataSource {
  /// Gets the cached [NumberTriviaModel] which was gotten the last time
  /// the user had an internet connection.
  ///
  /// Throws [CacheException] if no cached data is present.
  Future<List<Photo>> getPhotos();
}

final class HomeRemoteDataSourceImpl extends HomeRemoteDataSource {
  HomeRemoteDataSourceImpl({required http.Client httpClient})
      : _httpClient = httpClient;
  final http.Client _httpClient;

  @override
  Future<List<Photo>> getPhotos() async {
    // try {
    final response = await _httpClient
        .get(Uri.parse('${AppConstants.baseUrl}/photos?per_page=50'), headers: {
      'Authorization': 'Client-ID -pkDZ4uMJ3f2I9FPoqcgXgxY8Y9w7ltpRM3znuiBebY'
    });
    print(response.statusCode);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as List;
      final photos =
          data.map((e) => Photo.fromJson(e as Map<String, dynamic>)).toList();
      return photos;
      // return response.body;
    } else {
      throw Exception();
      // throw ServerException();
    }
    // } catch (e) {
    //   throw Exception();
    // }
  }
}
