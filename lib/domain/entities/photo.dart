import 'package:earnipay_test/domain/domain.dart';

class Photo {
  const Photo({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.width,
    this.height,
    this.color,
    this.description,
    this.user,
    this.urls,
  });

  final String? id;
  final String? createdAt;
  final String? updatedAt;
  final int? width;
  final int? height;
  final String? color;
  final String? description;
  final User? user;
  final Urls? urls;
}
