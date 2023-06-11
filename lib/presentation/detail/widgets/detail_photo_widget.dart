import 'package:cached_network_image/cached_network_image.dart';
import 'package:earnipay_test/domain/domain.dart';
import 'package:earnipay_test/gen/assets.gen.dart';
import 'package:flutter/material.dart';

class DetailPhotoWidget extends StatelessWidget {
  const DetailPhotoWidget({
    super.key,
    required this.photo,
  });

  final Photo photo;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: '__${photo.id}__}',
      flightShuttleBuilder: (
        flightContext,
        animation,
        flightDirection,
        fromHeroContext,
        toHeroContext,
      ) {
        return ScaleTransition(
          scale: animation.drive(
            Tween<double>(
              begin: 0.5,
              end: 1,
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
        placeholder: (context, url) => const Center(
          child: CircularProgressIndicator(),
        ),
        errorWidget: (context, _, __) =>
            Assets.images.placeholder.image(fit: BoxFit.cover),
      ),
    );
  }
}
