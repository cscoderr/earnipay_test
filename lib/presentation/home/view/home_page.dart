import 'package:cached_network_image/cached_network_image.dart';
import 'package:earnipay_test/core/core.dart';
import 'package:earnipay_test/domain/domain.dart';
import 'package:earnipay_test/injector.dart';
import 'package:earnipay_test/presentation/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static route() => MaterialPageRoute(
        builder: (_) => const HomePage(),
      );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          PhotoCubit(getPhotoUsecase: getIt<GetPhotoUsecase>())..getPhotos(),
      lazy: false,
      child: const HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: BlocBuilder<PhotoCubit, PhotoState>(
          builder: (context, state) {
            if (state.status == PhotoStatus.success) {
              return PhotoSuccessView(photos: state.photos);
            } else if (state.status == PhotoStatus.failure) {
              return const Center(child: Text('Something went wrong'));
            }
            return const HomeLoaderShimmer();
          },
        ),
      ),
    );
  }
}

class PhotoSuccessView extends StatelessWidget {
  const PhotoSuccessView({super.key, required this.photos});

  final List<Photo> photos;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Photo Gallery',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: PhotosGridView(photos: photos),
          ),
        ],
      ),
    );
  }
}

class PhotosGridView extends StatelessWidget {
  const PhotosGridView({
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
                child: PhotoView(photo: photo),
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

class PhotoView extends StatelessWidget {
  const PhotoView({
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
        borderRadius: BorderRadius.circular(8),
        child: ColorFiltered(
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.2),
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
            // FadeInImage.assetNetwork(
            //   placeholder: Assets.images.placeholder.path,
            //   image: photo.user?.profileImage?.large ??
            //       'https://picsum.photos/200/300',
            //   fit: BoxFit.cover,
            //   placeholderFit: BoxFit.cover,
            // ),
          ),
        ),
      ),
    );
  }
}
