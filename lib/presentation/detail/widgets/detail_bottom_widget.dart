import 'package:cached_network_image/cached_network_image.dart';
import 'package:earnipay_test/core/core.dart';
import 'package:earnipay_test/domain/domain.dart';
import 'package:flutter/material.dart';

class DetailBottomWidget extends StatelessWidget {
  const DetailBottomWidget({
    super.key,
    required this.photo,
  });

  final Photo photo;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.5),
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          AppRoundedImage(
            url: photo.user?.profileImage?.large ?? '',
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  photo.user?.name ?? '',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Colors.white,
                      ),
                ),
                Text(
                  photo.description ?? '',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.white,
                      ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () => _showMoreDetailBottomSheet(context, photo: photo),
            icon: const Icon(Icons.more_vert, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Future<void> _showMoreDetailBottomSheet(BuildContext context,
      {required Photo photo}) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const BeveledRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      showDragHandle: true,
      builder: (_) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20)
            .add(const EdgeInsets.only(bottom: 30)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: CachedNetworkImageProvider(
                    photo.user?.profileImage?.medium ?? '',
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        photo.user?.name ?? '',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: Colors.black,
                            ),
                      ),
                      Text(
                        photo.description ?? '',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Colors.black,
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      const Icon(Icons.visibility_outlined),
                      Text(photo.height?.toString() ?? '')
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      const Icon(Icons.download_done_outlined),
                      Text(photo.user?.totalPhotos?.toString() ?? '')
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      const Icon(Icons.thumb_up_alt_outlined),
                      Text(photo.user?.totalLikes?.toString() ?? '')
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const Icon(Icons.location_pin),
                const SizedBox(width: 15),
                Text(
                  photo.user?.location ?? '',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: Colors.black,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const Icon(Icons.calendar_month),
                const SizedBox(width: 15),
                Text(
                  photo.createdAt ?? '',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: Colors.black,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                fixedSize: Size(MediaQuery.of(context).size.width, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text('Download'),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
