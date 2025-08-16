import 'package:expense_tracker_lite/core/constants/app_assets.dart';
import 'package:expense_tracker_lite/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class ProfileImage extends StatelessWidget {
  final double radius;
  
  const ProfileImage({super.key, required this.radius});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: Container(
        width: radius * 2,
        height: radius * 2,
        decoration: BoxDecoration(
          color: AppColors.white,
          border: Border.all(color: Colors.grey, width: 1),
        ),
        child: Image.asset(
          'assets/images/profile.png',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
