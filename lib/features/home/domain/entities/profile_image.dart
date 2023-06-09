import 'package:json_annotation/json_annotation.dart';

part 'profile_image.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ProfileImage {
  ProfileImage({
    this.small,
    this.medium,
    this.large,
  });

  factory ProfileImage.fromJson(Map<String, dynamic> json) =>
      _$ProfileImageFromJson(json);

  final String? small;
  final String? medium;
  final String? large;
}
