import 'package:earnipay_test/domain/domain.dart';
import 'package:earnipay_test/presentation/presentation.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key, required this.photo});

  final Photo photo;

  static route({required Photo photo}) => MaterialPageRoute(
        builder: (_) => DetailPage(photo: photo),
      );

  @override
  Widget build(BuildContext context) {
    return DetailView(
      photo: photo,
    );
  }
}

class DetailView extends StatelessWidget {
  const DetailView({
    super.key,
    required this.photo,
  });

  final Photo photo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: DetailPhotoWidget(photo: photo),
          ),
          const Positioned(
            top: kToolbarHeight + 20,
            left: 10,
            right: 10,
            child: DetailPageTopBar(),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: DetailBottomWidget(photo: photo),
          ),
        ],
      ),
    );
  }
}
