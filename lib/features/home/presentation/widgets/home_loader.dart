import 'package:flutter/material.dart';

class HomeLoader extends StatefulWidget {
  const HomeLoader({super.key, this.onLoad});

  final VoidCallback? onLoad;

  @override
  State<HomeLoader> createState() => _HomeLoaderState();
}

class _HomeLoaderState extends State<HomeLoader> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onLoad?.call();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
