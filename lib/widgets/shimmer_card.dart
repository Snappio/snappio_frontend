import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class ShimmerCard extends StatelessWidget {
  const ShimmerCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SkeletonItem(
                child: SkeletonAvatar(
                  style: SkeletonAvatarStyle(
                      height: 175,
                      width: 175,
                      borderRadius: BorderRadius.circular(20)),
                ),
              ),
              SkeletonItem(
                child: SkeletonAvatar(
                  style: SkeletonAvatarStyle(
                      height: 175,
                      width: 175,
                      borderRadius: BorderRadius.circular(20)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SkeletonItem(
                child: SkeletonAvatar(
                  style: SkeletonAvatarStyle(
                      height: 175,
                      width: 175,
                      borderRadius: BorderRadius.circular(20)),
                ),
              ),
              SkeletonItem(
                child: SkeletonAvatar(
                  style: SkeletonAvatarStyle(
                      height: 175,
                      width: 175,
                      borderRadius: BorderRadius.circular(20)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
