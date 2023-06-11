import 'package:earnipay_test/data/data.dart';
import 'package:isar/isar.dart';

part 'isar_photo.g.dart';

@Collection()
class IsarPhoto {
  const IsarPhoto({
    this.id,
    this.photoId,
    this.createdAt,
    this.updatedAt,
    this.width,
    this.height,
    this.color,
    this.description,
    this.user,
    this.urls,
    this.timestamp,
  });

  final Id? id;
  @Index(unique: true, replace: true)
  final String? photoId;
  final String? createdAt;
  final String? updatedAt;
  final int? width;
  final int? height;
  final String? color;
  final String? description;
  final IsarUser? user;
  final IsarUrls? urls;
  final DateTime? timestamp;
}
