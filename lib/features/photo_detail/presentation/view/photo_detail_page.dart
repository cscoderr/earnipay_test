import 'package:earnipay_test/features/home/home.dart';
import 'package:flutter/material.dart';

class PhotoDetailPage extends StatelessWidget {
  const PhotoDetailPage({super.key, required this.photo});

  final Photo photo;

  static route({required Photo photo}) => MaterialPageRoute(
        builder: (_) => PhotoDetailPage(photo: photo),
      );

  @override
  Widget build(BuildContext context) {
    return PhotoDetailView(
      photo: photo,
    );
  }
}

class PhotoDetailView extends StatelessWidget {
  const PhotoDetailView({
    super.key,
    required this.photo,
  });

  final Photo photo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Row(
                  children: [
                    Icon(Icons.arrow_back_ios),
                    Text('Back'),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: Hero(
                  tag: '__${photo.id}__}',
                  flightShuttleBuilder: (
                    flightContext,
                    animation,
                    flightDirection,
                    fromHeroContext,
                    toHeroContext,
                  ) {
                    return FadeTransition(
                      opacity: animation.drive(
                        Tween<double>(begin: 0.0, end: 1.0).chain(
                          CurveTween(curve: Curves.easeInOut),
                        ),
                      ),
                      child: toHeroContext.widget,
                    );
                  },
                  child: Image.network(
                    photo.user?.profileImage?.large ??
                        'https://picsum.photos/200/300',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
