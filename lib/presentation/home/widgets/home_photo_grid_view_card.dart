import 'package:cached_network_image/cached_network_image.dart';
import 'package:earnipay_test/core/core.dart';
import 'package:earnipay_test/domain/domain.dart';
import 'package:earnipay_test/gen/assets.gen.dart';
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
      onTap: () => context.pushWithAnimation(
        DetailPage(photo: photo),
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
              return RotationTransition(
                turns: animation.drive(
                  Tween<double>(
                    begin: 0,
                    end: 1,
                  ).chain(
                    CurveTween(curve: Curves.elasticOut),
                  ),
                ),
                child: toHeroContext.widget,
              );
            },
            child: CachedNetworkImage(
              imageUrl: photo.urls?.regular ?? 'https://picsum.photos/200/300',
              fit: BoxFit.cover,
              placeholder: (context, url) => const HomeChildLoaderShimmer(),
              errorWidget: (context, _, __) =>
                  Assets.images.placeholder.image(fit: BoxFit.cover),
            ),
          ),
        ),
      ),
    );
  }
}
