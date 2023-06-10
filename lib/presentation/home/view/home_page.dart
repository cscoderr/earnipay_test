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
        child: BlocBuilder<PhotoCubit, PhotoState>(
          builder: (context, state) {
            if (state.status == PhotoStatus.success) {
              return HomeSuccessView(photos: state.photos);
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
