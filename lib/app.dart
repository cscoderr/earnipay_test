import 'package:earnipay_test/features/home/home.dart';
import 'package:flutter/material.dart';

class EarnipayApp extends StatelessWidget {
  const EarnipayApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
