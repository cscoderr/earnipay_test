import 'package:earnipay_test/app.dart';
import 'package:earnipay_test/data/data.dart';
import 'package:earnipay_test/injector.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dir = await getApplicationDocumentsDirectory();
  final isarDB = await Isar.open(
    [IsarPhotoSchema],
    directory: dir.path,
  );
  setupInjectors(isar: isarDB);
  runApp(const EarnipayApp());
}
