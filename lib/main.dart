import 'package:expense_tracker_lite/core/network/api_endpoints.dart';
import 'package:expense_tracker_lite/core/network/network_manager.dart';
import 'package:expense_tracker_lite/data/data_source/remote/currency_conversion_data_source.dart';
import 'package:expense_tracker_lite/domain/use_case/load_expences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'data/data_source/local/expenses_local_data_source.dart';
import 'data/models/category_model.dart';
import 'data/models/expense_model.dart';
import 'data/repositories/expense_repository.dart';
import 'domain/repository/expence_repository.dart';
import 'domain/use_case/save_expence.dart';
import 'features/add_expense/view_models/expense_bloc.dart';
import 'features/add_expense/view_models/expense_event.dart';


final getIt = GetIt.instance;

void main() async{
  await Hive.initFlutter();
  Hive.registerAdapter(ExpenseModelAdapter());
  Hive.registerAdapter(CategoryAdapter());
  // _setupLocators(); // Added await
  checkDependencies();
  final expenseBox = await Hive.openBox<ExpenseModel>('expenses');

  runApp( MyApp(expenseBox: expenseBox));
}

class MyApp extends StatelessWidget {
  final Box<ExpenseModel> expenseBox;

  const MyApp({super.key, required this.expenseBox});
  
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            final localDataSource = LocalDataSourceImpl(expenseBox: expenseBox);
            final repository = ExpenseRepositoryImpl(localDataSource: localDataSource);
            return ExpenseBloc(
              saveExpense: SaveExpense(repository),
              getExpenses: LoadExpenses(repository),
            )..add(LoadExpensesEvent());
          },
        ),
    ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'My App',
        theme: AppTheme.light(),
        darkTheme: AppTheme.dark(),
        themeMode: ThemeMode.system,
        routerConfig: appRouter,
      )
    );
  }
}
void _setupLocators() async{
  final expenseBox = await Hive.openBox<ExpenseModel>('expenses');

  getIt.registerFactory<NetworkManager>(
        ()=> NetworkManager(baseUrl: ApiEndpoints.baseUrl),
  );
  getIt.registerFactory<CurrencyRemoteDataSource>(
        ()=> CurrencyRemoteDataSourceImp(GetIt.I<NetworkManager>()) ,
  );
  // Setup dependency injection
  getIt.registerFactory<LocalDataSource>(
      ()=> LocalDataSourceImpl(expenseBox: expenseBox) ,
  );

  getIt.registerFactory<ExpenseRepository>(
        ()=> ExpenseRepositoryImpl(localDataSource: GetIt.I<LocalDataSource>()),
  );

  getIt.registerFactory<SaveExpense>(
        ()=> SaveExpense(GetIt.I<ExpenseRepository>()),
  );

  getIt.registerFactory<LoadExpenses>(
        ()=> LoadExpenses(GetIt.I<ExpenseRepository>()),
  );
  getIt.registerFactory<ExpenseBloc>(
        () => ExpenseBloc(
      saveExpense: GetIt.I<SaveExpense>(),
      getExpenses: GetIt.I<LoadExpenses>(),
    ),
  );
}
void checkDependencies() {
  try {
    print('Testing dependency chain...');
    print('DataSource: ${getIt<LocalDataSource>()}');
    print('Repository: ${getIt<ExpenseRepository>()}');
    print('SaveExpense: ${getIt<SaveExpense>()}');
    print('BLoC: ${getIt<ExpenseBloc>()}');
    print('All dependencies registered correctly!');
  } catch (e) {
    print('Dependency error: $e');
  }
}
