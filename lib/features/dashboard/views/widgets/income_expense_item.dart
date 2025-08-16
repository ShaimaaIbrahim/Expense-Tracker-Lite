import 'package:expense_tracker_lite/core/ui/custom_text.dart';
import 'package:expense_tracker_lite/core/ui/space.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/format_number.dart';

class IncomeExpenseItem extends StatelessWidget {
  final String title;
  final String amount;
  final Color color;
  final String icon;
  const IncomeExpenseItem({super.key, required this.title, required this.amount, required this.color, required this.icon});
  
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 25,
              height: 25,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.arrowBg,
              ),
              child: Transform.scale(
                  scale: 0.55, // 5/50 = 0.1
                  child: Image.asset(icon, color: AppColors.white)
              ),
            ),
            Space(width: 5),
            CustomText(
              title,
              style: TextStyle(
                fontSize: 14,
                color: AppColors.white,
              ),
            ),  
          ],
        ),
        const SizedBox(height: 4),
        Text(
          "\$ ${formatNumber(int.parse(amount))}",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }
}
