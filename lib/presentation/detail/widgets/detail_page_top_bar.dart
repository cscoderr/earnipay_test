import 'package:flutter/material.dart';

class DetailPageTopBar extends StatelessWidget {
  const DetailPageTopBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _TopBarIcon(
          onTap: () => Navigator.pop(context),
          icon: Icons.close,
        ),
        const Spacer(),
        _TopBarIcon(
          onTap: () => Navigator.pop(context),
          icon: Icons.favorite_border,
        ),
      ],
    );
  }
}

class _TopBarIcon extends StatelessWidget {
  const _TopBarIcon({
    required this.onTap,
    required this.icon,
  });

  final VoidCallback onTap;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.5),
          borderRadius: BorderRadius.circular(10),
        ),
        alignment: Alignment.center,
        child: Icon(
          icon,
          color: Colors.white,
        ),
      ),
    );
  }
}
