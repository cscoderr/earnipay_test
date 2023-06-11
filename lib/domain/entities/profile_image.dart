import 'package:equatable/equatable.dart';

class ProfileImage with EquatableMixin {
  const ProfileImage({
    this.small,
    this.medium,
    this.large,
  });

  final String? small;
  final String? medium;
  final String? large;

  @override
  List<Object?> get props => [
        small,
        medium,
        large,
      ];
}
