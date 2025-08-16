import 'package:expense_tracker_lite/core/constants/app_colors.dart';
import 'package:expense_tracker_lite/core/ui/custom_text.dart';
import 'package:expense_tracker_lite/core/utils/format_number.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/app_assets.dart';
import 'income_expense_item.dart';

class BalanceCardWidget extends StatelessWidget {
  Map<String, dynamic> balance;
   BalanceCardWidget({super.key, required this.balance});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
            image: AssetImage(AppAssets.balCardImage),
            fit: BoxFit.cover
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            'Total Balance',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: AppColors.white,
            ),
          ),
          const SizedBox(height: 8),
          CustomText(
            '\$ ${formatNumber((balance["balance"]??0).toInt())}',
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: AppColors.white,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IncomeExpenseItem(
                title: 'Income',
                amount: '${(balance["income"]??0).toInt()}',
                color: AppColors.white,
                icon: AppAssets.arrowUp
              ),
              IncomeExpenseItem(
                title: 'Expenses',
                amount: '${(balance["expenses"]??0).toInt()}',
                color: AppColors.white,
                icon: AppAssets.arrowDown
              ),
            ],
          ),
        ],
      ),
    );
  }
}
