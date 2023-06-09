import 'package:earnipay_test/features/home/home.dart';
import 'package:json_annotation/json_annotation.dart';

part 'photo.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
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

  factory Photo.fromJson(Map<String, dynamic> json) => _$PhotoFromJson(json);

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
