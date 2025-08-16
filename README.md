# Expense-Tracker-Lite
📱 Overview
A Flutter-based expense tracking application with dashboard analytics and expense management features. The app helps users track their spending across categories with currency conversion capabilities.

https://2.png https://1.png

🔹 Architecture & State Management
Architecture
The app follows a clean architecture approach with:

Presentation Layer: UI components and BLoCs

Domain Layer: Business logic and use cases

Data Layer: Repositories and data sources

State Management
BLoC pattern (flutter_bloc) for all state management

Each feature has its own BLoC:

DashboardBloc - Manages dashboard data and filtering

ExpenseBloc - Handles expense creation and management

CurrencyBloc - Manages currency conversion

UI reacts to state changes using BlocBuilder and BlocListener

🛠 Core Features Implementation
1. Dashboard Screen
dart
BlocProvider(
  create: (context) => DashboardBloc(
    expenseRepository: context.read<ExpenseRepository>(),
  )..add(LoadDashboardData()),
  child: DashboardView(),
)
2. Add Expense Screen
dart
BlocProvider(
  create: (context) => ExpenseBloc(
    saveExpense: context.read<SaveExpenseUseCase>(),
    currencyBloc: context.read<CurrencyBloc>(),
  ),
  child: AddExpenseView(),
)
3. Currency Conversion (API Integration)
dart
class CurrencyBloc extends Bloc<CurrencyEvent, CurrencyState> {
  final CurrencyRepository repository;
  
  Future<void> _convertCurrency(ConvertCurrency event, Emitter emit) async {
    final rate = await repository.getExchangeRate(
      from: event.fromCurrency,
      to: event.toCurrency
    );
    emit(CurrencyConverted(rate));
  }
}
4. Pagination
dart
class ExpenseRepository {
  Future<PaginationResult<Expense>> getExpenses({
    required int page,
    required int limit,
    ExpenseFilter? filter,
  }) async {
    // Implementation
  }
}
5. Local Storage
dart
@HiveType(typeId: 0)
class ExpenseModel {
  @HiveField(0)
  final double amount;
  // Other fields
}

// Initialize
await Hive.initFlutter();
Hive.registerAdapter(ExpenseModelAdapter());
6. Expense Summary
dart
class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  Future<void> _loadSummary(LoadDashboardData event, Emitter emit) async {
    final summary = await repository.getSummary(filter: event.filter);
    emit(DashboardLoaded(summary));
  }
}
🏗 Project Structure
text
lib/
├── core/
│   ├── di/                # Dependency injection
│   ├── theme/             # App styling
│   └── utils/             # Utilities
├── data/
│   ├── datasources/       # Local and remote data sources
│   ├── models/            # Data models
│   └── repositories/      # Repository implementations
├── domain/
│   ├── entities/          # Business entities
│   ├── repositories/      # Repository interfaces
│   └── usecases/          # Business logic
└── features/
    ├── dashboard/         # Dashboard feature
    ├── expense/           # Expense management
    └── currency/          # Currency conversion
🚀 How to Run
Clone the repository

Install dependencies:

bash
flutter pub get
Generate files (if using injectable):

bash
flutter pub run build_runner build
Run the app:

bash
flutter run
⚖️ Trade-offs & Assumptions
Using Hive for local storage for simplicity (could use SQLite for more complex queries)

Mock API for currency conversion in development

Assumes single-user device storage (no cloud sync)

Pagination implemented client-side for demo purposes

🐛 Known Issues
Receipt image upload compression not optimized

Currency conversion rates not cached

No offline-first support for API calls

Limited error handling for edge cases

🔮 Future Improvements
Implement biometric authentication

Add expense categorization AI

Multi-currency wallet support

Export/import functionality

Recurring expenses feature

📊 MVVM Structure
While using BLoC pattern, we maintain MVVM separation:

Model: Data layer (entities, repositories)

View: UI components

ViewModel: BLoCs that prepare data for views

dart
// Example ViewModel (BLoC)
class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final GetDashboardSummaryUseCase getSummary;
  
  Stream<DashboardState> mapEventToState(DashboardEvent event) async* {
    if (event is LoadDashboardData) {
      yield* _mapLoadDashboardToState(event);
    }
  }
  
  Stream<DashboardState> _mapLoadDashboardToState(LoadDashboardData event) async* {
    try {
      final summary = await getSummary(event.filter);
      yield DashboardLoaded(summary);
    } catch (e) {
      yield DashboardError(e.toString());
    }
  }
}
