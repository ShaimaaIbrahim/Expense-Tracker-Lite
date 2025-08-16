import '../entities/expence.dart';

abstract class ExpenseRepository {
  Future<void> saveExpense(Expense expense);
  Future<List<Expense>> getExpenses(
      {
        int page = 1,
        int limit = 10,
        String? filter,
        DateTime? startDate,
        DateTime? endDate,
      }
      );
}