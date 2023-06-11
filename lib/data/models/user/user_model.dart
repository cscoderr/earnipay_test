import 'package:earnipay_test/data/data.dart';
import 'package:earnipay_test/domain/domain.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class UserModel extends User {
  const UserModel({
    super.id,
    super.username,
    super.name,
    super.portfolioUrl,
    super.bio,
    super.location,
    super.totalLikes,
    super.totalPhotos,
    super.totalCollections,
    super.instagramUsername,
    super.twitterUsername,
    this.profileImageM,
  }) : super(profileImage: profileImageM);

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  @JsonKey(name: 'profile_image')
  final ProfileImageModel? profileImageM;
}
