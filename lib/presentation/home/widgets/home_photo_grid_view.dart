import 'package:cached_network_image/cached_network_image.dart';
import 'package:earnipay_test/core/core.dart';
import 'package:earnipay_test/domain/domain.dart';
import 'package:earnipay_test/presentation/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomePhotoGridView extends StatelessWidget {
  const HomePhotoGridView({
    super.key,
    required this.photos,
  });

  final List<Photo> photos;

  @override
  Widget build(BuildContext context) {
    final state = context.watch<PhotoCubit>().state;
    return GridView.custom(
      gridDelegate: SliverStairedGridDelegate(
        // crossAxisCount: 2,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
        startCrossAxisDirectionReversed: true,
        pattern: [
          const StairedGridTile(0.5, 3 / 4),
          const StairedGridTile(0.5, 2.8 / 4),
          const StairedGridTile(1.0, 8 / 4),
        ],
      ),
      childrenDelegate: SliverChildBuilderDelegate(
        (context, index) {
          if (index == photos.length) {
            if (state.status == PhotoStatus.failure) {
              return Center(child: Text(state.errorMessage));
            }
            if (!state.hasReachedMax) {
              return HomeLoader(
                onLoad: () => context.read<PhotoCubit>().getPhotos(
                    page: ((photos.length ~/ AppConstants.photosLimit) + 1)),
              );
            }
            return const SizedBox.shrink();
          }
          final photo = photos[index];
          return Stack(
            children: [
              Positioned.fill(
                child: HomePhotoGridViewCard(photo: photo),
              ),
              const Positioned(
                top: 10,
                right: 10,
                child: Icon(Icons.favorite_border, color: Colors.white),
              ),
              Positioned(
                bottom: 10,
                left: 10,
                right: 0,
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 15,
                      backgroundImage: CachedNetworkImageProvider(
                          photo.user?.profileImage?.medium ?? ''),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        photo.user?.name ?? '',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              color: Colors.white,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
        childCount: (photos.length + 1),
      ),
    );
  }
}
