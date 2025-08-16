import 'package:expense_tracker_lite/core/constants/app_assets.dart';
import 'package:expense_tracker_lite/core/constants/app_colors.dart';
import 'package:expense_tracker_lite/core/ui/custom_dropdown.dart';
import 'package:expense_tracker_lite/core/ui/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../core/ui/space.dart';
import '../../../add_expense/view_models/expense_bloc.dart';
import '../../../add_expense/view_models/expense_event.dart';
import '../../../add_expense/view_models/expense_stata.dart'
    show
        ExpenseState,
        ExpenseInitial,
        ExpenseLoading,
        ExpenseError,
        ExpenseLoaded;
import '../widgets/balance_card.dart';
import '../widgets/expense_item.dart';
import '../widgets/profile_image.dart';

class DashboardScreen extends HookWidget {
  DashboardScreen({super.key});

  var listFilter = ["This Month", "Last 7 days"];

  @override
  Widget build(BuildContext context) {
    var filterValue = useState("Last 7 days");
    var balanceValue = useState(<String, dynamic>{
      'balance': 0,
      'income': 50000,
      'expenses': 0,
    });

    return Scaffold(
      appBar: AppBar(backgroundColor: AppColors.primaryColor, toolbarHeight: 0),
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.24,
              decoration: BoxDecoration(
                color: AppColors.secondaryColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
                image: DecorationImage(
                  image: AssetImage(AppAssets.bagCardImage),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header with greeting
                    Row(
                      //direction :Axis.horizontal,
                      children: [
                        Row(
                          children: [
                            //Profile image here.
                            ProfileImage(radius: 24),
                            Space(width: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  'Good Morning',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.white,
                                  ),
                                ),
                                const Space(height: 4),
                                Text(
                                  'Shaimaa Salama',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.white,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Spacer(),
                        CustomDropdown(
                          items: listFilter,
                          onChanged: (v) {
                            filterValue.value = v!.toString();
                            context.read<ExpenseBloc>().add(
                              ApplyFilterEvent("${v}"),
                            );
                          },
                          dropdownWidth: 130,
                          dropdownHeight: 35,
                          fillColor: AppColors.white,
                          value: filterValue.value,
                        ),
                      ],
                    ),
                    const SizedBox(height: 50),
                    // Recent expenses with animation
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Balance card with animation
                        BalanceCardWidget(balance: balanceValue.value),
                        const Space(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Recent Expenses',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: Text(
                                'see all',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: AppColors.darkBackground,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          height: 600,
                          child: BlocConsumer<ExpenseBloc, ExpenseState>(
                            builder: (BuildContext context, state) {
                              if (state is ExpenseInitial) {
                                context.read<ExpenseBloc>().add(
                                  LoadExpensesEvent(),
                                );
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else if (state is ExpenseLoading) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else if (state is ExpenseError) {
                                return Center(child: Text(state.message));
                              } else if (state is ExpenseLoaded) {
                                if (state.expenses.isEmpty) {
                                  return const Center(
                                    child: Text('No expenses found'),
                                  );
                                }
                                return NotificationListener<ScrollNotification>(
                                  onNotification: (notification) {
                                    if (notification is ScrollEndNotification &&
                                        notification.metrics.pixels ==
                                            notification
                                                .metrics
                                                .maxScrollExtent &&
                                        !state.hasReachedMax &&
                                        !state.isLoadingMore) {
                                      context.read<ExpenseBloc>().add(
                                        LoadMoreExpensesEvent(),
                                      );
                                    }
                                    return false;
                                  },
                                  child: ListView.builder(
                                    itemCount: (state.expenses.length - 1),
                                    itemBuilder: (context, index) {
                                      final expense = state.expenses[index];
                                      // Show loading indicator at bottom
                                      if (index >= state.expenses.length) {
                                        return Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Center(
                                            child: state.isLoadingMore
                                                ? const CircularProgressIndicator()
                                                : const SizedBox.shrink(),
                                          ),
                                        );
                                      }
                                      return AnimatedExpenseItem(
                                        category: expense.category!,
                                        amount: expense.amount.toString(),
                                        type: expense.category!.name,
                                        time: expense.date,
                                        delay: index * 100,
                                      );
                                    },
                                  ),
                                );
                              }
                              return Container();
                            },
                            listener: (ctx, state) {
                              if (state is ExpenseLoaded) {
                                balanceValue.value = state.balance ?? {};
                                debugPrint("balance: ${balanceValue.value}");
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
