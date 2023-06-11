import 'package:isar/isar.dart';

part 'isar_profile_image.g.dart';

@embedded
class IsarProfileImage {
  const IsarProfileImage({
    this.small,
    this.medium,
    this.large,
  });

  final String? small;
  final String? medium;
  final String? large;
}
