import 'package:expense_tracker_lite/core/constants/app_colors.dart';
import 'package:expense_tracker_lite/core/ui/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../core/ui/space.dart';

class CategoryCard extends HookWidget {
  final String icon;
  final int? bg;
  final int iconColor;
  final String text;
  final bool selected;
  const CategoryCard( {super.key, required this.icon,  this.bg, required this.text, required this.iconColor,required this.selected,});
  
  @override
  Widget build(BuildContext context) {
    return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
    Container(
    height: 50,
    width: 50,
    decoration: BoxDecoration(
    color: selected ? AppColors.primaryColor: Color(bg??0xFFFFFFFF),
    shape: BoxShape.circle
    ),
    child: bg == null ?  Image.asset(icon, color: Color(iconColor)) : Transform.scale(
    scale: 0.55, // 5/50 = 0.1
    child: Image.asset(icon, color: selected ? AppColors.white: Color(iconColor))
  ),
  ),
  Space(height: 8),
  CustomText(text, fontSize: 12, fontWeight: FontWeight.bold)
  ],
  );
  }
}
