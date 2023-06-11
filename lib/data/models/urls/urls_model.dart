import 'package:earnipay_test/domain/domain.dart';
import 'package:json_annotation/json_annotation.dart';

part 'urls_model.g.dart';

@JsonSerializable()
final class UrlsModel extends Urls {
  const UrlsModel({
    super.raw,
    super.full,
    super.regular,
    super.small,
    super.thumb,
  });

  factory UrlsModel.fromJson(Map<String, dynamic> json) =>
      _$UrlsModelFromJson(json);

  Map<String, dynamic> toJson() => _$UrlsModelToJson(this);
}
