import 'package:flutter/material.dart';

class HomeLoaderShimmer extends StatelessWidget {
  const HomeLoaderShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return const _HomeLoaderChild();
  }
}

class _HomeLoaderChild extends StatelessWidget {
  const _HomeLoaderChild();

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
