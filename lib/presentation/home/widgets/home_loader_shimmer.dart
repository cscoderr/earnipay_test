import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shimmer/shimmer.dart';

class HomeLoaderShimmer extends StatelessWidget {
  const HomeLoaderShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: GridView.custom(
          gridDelegate: SliverStairedGridDelegate(
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
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
              );
            },
            childCount: 6,
          ),
        ),
      ),
    );
  }
}

class HomeChildLoaderShimmer extends StatelessWidget {
  const HomeChildLoaderShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: double.infinity,
        height: 250,
        color: Colors.white,
      ),
    );
  }
}
