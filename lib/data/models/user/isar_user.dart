import 'package:earnipay_test/data/data.dart';
import 'package:isar/isar.dart';

part 'isar_user.g.dart';

@embedded
class IsarUser {
  const IsarUser({
    this.username,
    this.name,
    this.portfolioUrl,
    this.bio,
    this.location,
    this.totalLikes,
    this.totalPhotos,
    this.totalCollections,
    this.instagramUsername,
    this.twitterUsername,
    this.profileImage,
  });

  final String? username;
  final String? name;
  final String? portfolioUrl;
  final String? bio;
  final String? location;
  final int? totalLikes;
  final int? totalPhotos;
  final int? totalCollections;
  final String? instagramUsername;
  final String? twitterUsername;
  final IsarProfileImage? profileImage;
}
