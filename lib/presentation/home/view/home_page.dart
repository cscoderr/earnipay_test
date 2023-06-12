import 'package:earnipay_test/domain/domain.dart';
import 'package:earnipay_test/injector.dart';
import 'package:earnipay_test/presentation/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        child: Padding(
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
              Expanded(
                child: BlocBuilder<PhotoCubit, PhotoState>(
                  builder: (context, state) {
                    if (state.status == PhotoStatus.success) {
                      if (state.photos.isEmpty) {
                        return const Center(child: Text('No data available'));
                      }
                      return HomePhotoGridView(photos: state.photos);
                    } else if (state.status == PhotoStatus.failure) {
                      return const Center(child: Text('Something went wrong'));
                    }
                    return const HomeLoaderShimmer();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
