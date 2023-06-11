import 'package:isar/isar.dart';

part 'isar_urls.g.dart';

@embedded
class IsarUrls {
  const IsarUrls({
    this.raw,
    this.full,
    this.regular,
    this.small,
    this.thumb,
  });
  final String? raw;
  final String? full;
  final String? regular;
  final String? small;
  final String? thumb;
}
