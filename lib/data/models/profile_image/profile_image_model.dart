import 'package:earnipay_test/domain/domain.dart';
import 'package:json_annotation/json_annotation.dart';

part 'profile_image_model.g.dart';

@JsonSerializable()
class ProfileImageModel extends ProfileImage {
  const ProfileImageModel({
    super.small,
    super.medium,
    super.large,
  });

  factory ProfileImageModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileImageModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileImageModelToJson(this);
}
