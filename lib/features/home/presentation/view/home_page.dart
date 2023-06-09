import 'package:cached_network_image/cached_network_image.dart';
import 'package:earnipay_test/features/home/home.dart';
import 'package:earnipay_test/features/photo_detail/photo_detail.dart';
import 'package:earnipay_test/injector.dart';
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
    final state = context.watch<PhotoCubit>().state;
    return Scaffold(
      body: SafeArea(
          child: switch (state) {
        PhotoSuccess(:List<Photo> photos) => PhotoSuccessView(photos: photos),
        PhotoFailure(:String message) => Center(child: Text(message)),
        _ => const Center(child: CircularProgressIndicator()),
      }),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite_outline), label: 'Favourite'),
        ],
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
      child: PhotosGridView(photos: photos),
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
          return Stack(
            children: [
              Positioned.fill(
                child: PhotoView(photo: photos[index]),
              ),
              Positioned(
                bottom: 10,
                left: 10,
                right: 0,
                child: Text(
                  photos[index].user?.name ?? '',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Colors.white,
                      ),
                ),
              ),
            ],
          );
        },
        childCount: photos.length,
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
        PhotoDetailPage.route(photo: photo),
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
              return FadeTransition(
                opacity: animation.drive(
                  Tween<double>(begin: 0.0, end: 1.0).chain(
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
