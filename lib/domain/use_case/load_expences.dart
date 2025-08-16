import 'package:expense_tracker_lite/core/utils/failure.dart';

import '../entities/expence.dart';
import '../repository/expence_repository.dart';

class LoadExpenses {
  final ExpenseRepository repository;

  LoadExpenses(this.repository);

  Future<List<Expense>> call({
    int page = 1,
    int limit = 10,
    String? filter,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    try {
      return await repository.getExpenses(
        page: page,
        limit: limit,
        filter: filter,
        startDate: startDate,
        endDate: endDate,
      );
    } catch (e) {
       rethrow;
      //throw Failure('Failed to load expenses: ${e.toString()}');
    }
  }
}