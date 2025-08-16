import '../../../domain/entities/expence.dart';

abstract class ExpenseState {}

class ExpenseInitial extends ExpenseState {
}

class ExpenseLoading extends ExpenseState {}

class ExpenseLoaded extends ExpenseState {
  final List<Expense> expenses;
  final bool hasReachedMax;
  final bool isLoadingMore;
  final String? errorMessage;
  final Map<String, dynamic>? balance;

  ExpenseLoaded({
    required this.expenses,
    required this.hasReachedMax,
    this.isLoadingMore = false,
    this.errorMessage,
    this.balance
  });

  ExpenseLoaded copyWith({
    List<Expense>? expenses,
    bool? hasReachedMax,
    bool? isLoadingMore,
    String? errorMessage,
  }) {
    return ExpenseLoaded(
      expenses: expenses ?? this.expenses,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

class ExpenseError extends ExpenseState {
  final String message;

  ExpenseError(this.message);
}

class ExpenseAdded extends ExpenseState {}

class ExpenseDeleted extends ExpenseState {}