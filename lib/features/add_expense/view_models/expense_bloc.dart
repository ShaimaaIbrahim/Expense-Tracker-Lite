import 'package:expense_tracker_lite/core/utils/financial_calculator.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show Bloc, Emitter;

import '../../../core/utils/failure.dart';
import '../../../domain/use_case/load_expences.dart';
import '../../../domain/use_case/save_expence.dart';
import 'expense_event.dart';
import 'expense_stata.dart';

class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
  final SaveExpense saveExpense;
  final LoadExpenses getExpenses;

  final int itemsPerPage = 10;

  int _currentPage = 1;
  String? _currentFilter = "This Month"; // Default filter
  Map<String, dynamic>? _currentBalance = {
    'balance': 0,
    'income': 50000,
    'expenses': 0
  };
  ExpenseBloc({
    required this.saveExpense,
    required this.getExpenses,
  }) : super(ExpenseInitial()) {
    on<LoadExpensesEvent>(_onLoadExpenses);
    on<AddExpenseEvent>(_onAddExpense);
    on<LoadMoreExpensesEvent>(_onLoadMoreExpenses);
    on<ApplyFilterEvent>(_onApplyFilter);
  }

  Future<void> _onLoadMoreExpenses(
      LoadMoreExpensesEvent event,
      Emitter<ExpenseState> emit,
      ) async {
    if (state is ExpenseLoaded) {
      final currentState = state as ExpenseLoaded;
      if (currentState.hasReachedMax) return;

      emit(currentState.copyWith(isLoadingMore: true));

      try {
        _currentPage++;
        final newExpenses = await getExpenses(page: _currentPage, filter: _currentFilter);

        // Combine and sort by latest date (newest first)
        final combinedExpenses = [...currentState.expenses, ...newExpenses]
          ..sort((a, b) => b.date.compareTo(a.date)); // Sort in descending order
        _currentBalance = FinanceCalculator.calculateTotals(expensesList: combinedExpenses, filter: _currentFilter??"Last 7 days");
        emit(ExpenseLoaded(
          expenses: combinedExpenses,
          balance: _currentBalance,
          hasReachedMax: newExpenses.length < itemsPerPage,
        ));
      } on Failure catch (e) {
        emit(currentState.copyWith(errorMessage: e.message));
      }
    }
  }

  Future<void> _onApplyFilter(
      ApplyFilterEvent event,
      Emitter<ExpenseState> emit,
      ) async {
    _currentFilter = event.filter;
    _currentPage = 1;
    add(LoadExpensesEvent());
  }
  
  Future<void> _onLoadExpenses(
      LoadExpensesEvent event,
      Emitter<ExpenseState> emit,
      ) async {
    emit(ExpenseLoading());
    try {
      final expenses = await getExpenses();

      // Sort expenses by date (newest first)
      final sortedExpenses = [...expenses]..sort((a, b) => b.date.compareTo(a.date));
      _currentBalance = FinanceCalculator.calculateTotals(expensesList: sortedExpenses, filter: _currentFilter??"");
      emit(ExpenseLoaded(
        expenses: sortedExpenses,
        balance: _currentBalance,
        hasReachedMax: sortedExpenses.length < itemsPerPage,
      ));
    } on Failure catch (e) {
      emit(ExpenseError(e.message));
    }
  }

  Future<void> _onAddExpense(
      AddExpenseEvent event,
      Emitter<ExpenseState> emit,
      ) async {
    emit(ExpenseLoading());
    try {
      await saveExpense(event.expense);
      final expenses = await getExpenses();
      emit(ExpenseLoaded(expenses: expenses, hasReachedMax: expenses.length < itemsPerPage,));
    } on Failure catch (e) {
      emit(ExpenseError(e.message));
    }
  }
  
}