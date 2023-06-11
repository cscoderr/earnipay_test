import 'package:earnipay_test/data/data.dart';

extension PhotoModelEx on PhotoModel {
  IsarPhoto toIsarPhoto() {
    return IsarPhoto(
      photoId: id,
      createdAt: createdAt,
      updatedAt: updatedAt,
      width: width,
      height: height,
      color: color,
      description: description,
      user: userM?.toIsarUser(),
      urls: urlsM?.toIsarUrls(),
      timestamp: DateTime.now(),
    );
  }
}

extension IsarPhotoEx on IsarPhoto {
  PhotoModel toPhotoModel() {
    return PhotoModel(
      id: photoId,
      createdAt: createdAt,
      updatedAt: updatedAt,
      width: width,
      height: height,
      color: color,
      description: description,
      userM: user?.toUserModel(),
      urlsM: urls?.toUrlsModel(),
    );
  }
}

extension IsarUserEx on IsarUser {
  UserModel toUserModel() {
    return UserModel(
      username: username,
      name: name,
      portfolioUrl: portfolioUrl,
      bio: bio,
      location: location,
      totalLikes: totalLikes,
      totalPhotos: totalPhotos,
      totalCollections: totalCollections,
      instagramUsername: instagramUsername,
      twitterUsername: twitterUsername,
      profileImageM: profileImage?.toProfileImageModel(),
    );
  }
}

extension IsarProfileImageEx on IsarProfileImage {
  ProfileImageModel toProfileImageModel() {
    return ProfileImageModel(
      small: small,
      medium: medium,
      large: large,
    );
  }
}

extension IsarUrlsEx on IsarUrls {
  UrlsModel toUrlsModel() {
    return UrlsModel(
      raw: raw,
      full: full,
      regular: regular,
      small: small,
      thumb: thumb,
    );
  }
}

extension UserModelEx on UserModel {
  IsarUser toIsarUser() {
    return IsarUser(
      username: username,
      name: name,
      portfolioUrl: portfolioUrl,
      bio: bio,
      location: location,
      totalLikes: totalLikes,
      totalPhotos: totalPhotos,
      totalCollections: totalCollections,
      instagramUsername: instagramUsername,
      twitterUsername: twitterUsername,
      profileImage: profileImageM?.toIsarProfileImage(),
    );
  }
}

extension ProfileImageModelEx on ProfileImageModel {
  IsarProfileImage toIsarProfileImage() {
    return IsarProfileImage(
      small: small,
      medium: medium,
      large: large,
    );
  }
}

extension UrlsModelEx on UrlsModel {
  IsarUrls toIsarUrls() {
    return IsarUrls(
      raw: raw,
      full: full,
      regular: regular,
      small: small,
      thumb: thumb,
    );
  }
}
