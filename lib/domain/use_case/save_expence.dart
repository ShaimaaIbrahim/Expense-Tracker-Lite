import '../entities/expence.dart';
import '../repository/expence_repository.dart';

class SaveExpense {
  final ExpenseRepository repository;

  SaveExpense(this.repository);

  Future<void> call(Expense expense) async {
    return await repository.saveExpense(expense);
  }
}