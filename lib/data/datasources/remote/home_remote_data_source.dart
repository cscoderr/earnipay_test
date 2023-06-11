import 'dart:convert';

import 'package:earnipay_test/core/core.dart';
import 'package:earnipay_test/core/exceptions/exceptions.dart';
import 'package:earnipay_test/data/data.dart';
import 'package:http/http.dart' as http;

abstract class HomeRemoteDataSource {
  /// Gets the cached [NumberTriviaModel] which was gotten the last time
  /// the user had an internet connection.
  ///
  /// Throws [CacheException] if no cached data is present.
  Future<List<PhotoModel>> getPhotos({int? limit, int? page});
}

final class HomeRemoteDataSourceImpl extends HomeRemoteDataSource {
  HomeRemoteDataSourceImpl({required http.Client httpClient})
      : _httpClient = httpClient;
  final http.Client _httpClient;

  @override
  Future<List<PhotoModel>> getPhotos({int? limit, int? page}) async {
    try {
      final response = await _httpClient.get(
          Uri.parse('${AppConstants.baseUrl}/photos').replace(
            queryParameters: {
              if (page != null) 'page': page.toString(),
              if (limit != null) 'per_page': limit.toString(),
              // 'order_by': 'latest',
            },
          ),
          headers: {
            'Authorization':
                'Client-ID -pkDZ4uMJ3f2I9FPoqcgXgxY8Y9w7ltpRM3znuiBebY'
          });
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as List;
        final photos = data
            .map((e) => PhotoModel.fromJson(e as Map<String, dynamic>))
            .toList();
        return photos;
      } else {
        throw const AppException('Something went wrong');
      }
    } catch (e) {
      throw AppException(e.toString());
    }
  }
}
