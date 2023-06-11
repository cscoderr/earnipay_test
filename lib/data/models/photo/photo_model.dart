import 'package:earnipay_test/data/data.dart';
import 'package:earnipay_test/domain/domain.dart';
import 'package:json_annotation/json_annotation.dart';

part 'photo_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
final class PhotoModel extends Photo {
  const PhotoModel({
    super.id,
    super.createdAt,
    super.updatedAt,
    super.width,
    super.height,
    super.color,
    super.description,
    this.userM,
    this.urlsM,
  }) : super(user: userM, urls: urlsM);

  factory PhotoModel.fromJson(Map<String, dynamic> json) =>
      _$PhotoModelFromJson(json);

  @JsonKey(name: 'user')
  final UserModel? userM;

  @JsonKey(name: 'urls')
  final UrlsModel? urlsM;
}
