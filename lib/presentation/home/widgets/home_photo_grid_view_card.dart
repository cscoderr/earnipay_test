import 'package:cached_network_image/cached_network_image.dart';
import 'package:earnipay_test/domain/domain.dart';
import 'package:earnipay_test/presentation/presentation.dart';
import 'package:flutter/material.dart';

class HomePhotoGridViewCard extends StatelessWidget {
  const HomePhotoGridViewCard({
    super.key,
    required this.photo,
  });

  final Photo photo;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        DetailPage.route(photo: photo),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: ColorFiltered(
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.3),
            BlendMode.srcOver,
          ),
          child: Hero(
            tag: '__${photo.id}__}',
            flightShuttleBuilder: (
              flightContext,
              animation,
              flightDirection,
              fromHeroContext,
              toHeroContext,
            ) {
              return SlideTransition(
                position: animation.drive(
                  Tween<Offset>(
                    begin: const Offset(0, 1),
                    end: const Offset(1, 0),
                  ).chain(
                    CurveTween(curve: Curves.easeInOut),
                  ),
                ),
                child: toHeroContext.widget,
              );
            },
            child: CachedNetworkImage(
              imageUrl: photo.urls?.regular ?? 'https://picsum.photos/200/300',
              fit: BoxFit.cover,
              placeholder: (context, url) => const HomeChildLoaderShimmer(),
            ),
          ),
        ),
      ),
    );
  }
}
