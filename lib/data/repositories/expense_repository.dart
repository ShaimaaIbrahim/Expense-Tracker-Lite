
import '../../domain/entities/expence.dart';
import '../../domain/repository/expence_repository.dart';
import '../data_source/local/expenses_local_data_source.dart';
import '../models/expense_model.dart';

class ExpenseRepositoryImpl implements ExpenseRepository {
  final LocalDataSource localDataSource;

  ExpenseRepositoryImpl({required this.localDataSource});

  @override
  Future<void> saveExpense(Expense expense) async {
    await localDataSource.saveExpense(ExpenseModel.fromEntity(expense));
  }

  @override
  Future<List<Expense>> getExpenses({int page = 1, int limit = 10, String? filter, DateTime? startDate, DateTime? endDate}) async{
    final models = await localDataSource.getExpenses(page: page, limit: limit, filter: filter);
    return models.map((model) => model.toEntity()).toList();
  }

}