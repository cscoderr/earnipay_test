import 'package:earnipay_test/domain/domain.dart';
import 'package:equatable/equatable.dart';

class User with EquatableMixin {
  const User({
    this.id,
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

  final String? id;
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
  final ProfileImage? profileImage;

  @override
  List<Object?> get props => [
        id,
        username,
        name,
        portfolioUrl,
        bio,
        location,
        totalLikes,
        totalPhotos,
        totalCollections,
        instagramUsername,
        twitterUsername,
        profileImage,
      ];
}
