// import 'package:expense_tracker_lite/data/models/currency_model.dart';
// import 'package:expense_tracker_lite/data/models/expense_model.dart';
// import '../../../core/network/api_endpoints.dart';
// import '../../../core/network/network_manager.dart';
//
import 'package:hive/hive.dart';

import '../../../core/utils/failure.dart';
import '../../models/expense_model.dart';

abstract class LocalDataSource {
  Future<void> saveExpense(ExpenseModel expense);
  Future<List<ExpenseModel>> getExpenses({int page = 1, int limit = 10, String? filter});
}

class LocalDataSourceImpl implements LocalDataSource {
  final Box<ExpenseModel> expenseBox;

  LocalDataSourceImpl({required this.expenseBox});

  @override
  Future<void> saveExpense(ExpenseModel expense) async {
    try {
      await expenseBox.put(expense.id, expense);
    } catch (e) {
      throw CacheFailure('Failed to save expense: ${e.toString()}');
    }
  }

  @override
  Future<List<ExpenseModel>> getExpenses({int page = 1, int limit = 10, String? filter}) async{
    await Future.delayed(const Duration(milliseconds: 500)); // Simulate network delay

    var expenses = expenseBox.values.toList();

    // Apply filter if provided
    if (filter != null) {
      // Implement your filter logic here
      // For example, filter by month:
      expenses = expenses.where((expense) => _matchesFilter(expense, filter)).toList();
    }

    // Apply pagination
    final startIndex = (page - 1) * limit;
    if (startIndex >= expenses.length) {
      return [];
    }

    final endIndex = startIndex + limit;
    return expenses.sublist(
      startIndex,
      endIndex > expenses.length ? expenses.length : endIndex,
    );
  }

  bool _matchesFilter(ExpenseModel expense, String filter) {
    // Implement your filter matching logic
    // Example for "This Month" filter:
    if (filter == "This Month") {
      final now = DateTime.now();
      return expense.date.month == now.month && expense.date.year == now.year;
    }
    else if (filter == "Last 7 days") {
      final now = DateTime.now();
      return expense.date.month == now.month && expense.date.day.compareTo(expense.date.day)<=7;
    }
    return true;
  }
}