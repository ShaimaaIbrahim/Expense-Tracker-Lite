import '../../../domain/entities/expence.dart';

abstract class ExpenseEvent {}

class LoadExpensesEvent extends ExpenseEvent {}

class AddExpenseEvent extends ExpenseEvent {
  final Expense expense;

  AddExpenseEvent(this.expense);
}
class LoadMoreExpensesEvent extends ExpenseEvent {}


class ApplyFilterEvent extends ExpenseEvent {
  final String? filter;

  ApplyFilterEvent(this.filter);
}
