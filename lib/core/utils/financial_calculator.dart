import 'package:expense_tracker_lite/domain/entities/expence.dart';

class FinanceCalculator {
   static Map<String, dynamic> calculateTotals({
    required List<Expense> expensesList,
    required String filter, // 'last7days' or 'thismonth'
  }) {
    // 1. Filter transactions based on selected period
    final now = DateTime.now();
    final filteredExpenses = expensesList.where((t) {
      if (filter == 'Last 7 days') {
        return t.date.isAfter(now.subtract(Duration(days: 7)));
      } else { // 'thismonth'
        return t.date.month == now.month && t.date.year == now.year;
      }
    }).toList();

    // 2. Calculate totals
    //we assume we have income value = 50,000 USD
    double income = 50000;
    double expenses = 0;

    for (final t in filteredExpenses) {
        expenses += (t.convertedAmount??0).abs();
    }

    // 3. Calculate balance (Income - Expenses)
    final balance = income - expenses;

    return {
      'balance': balance,
      'income': income,
      'expenses': expenses
    };
  }
}
