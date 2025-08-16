import 'package:expense_tracker_lite/data/models/category_model.dart';
import 'package:expense_tracker_lite/domain/entities/expence.dart';
import 'package:expense_tracker_lite/features/add_expense/view_models/expense_bloc.dart';
import 'package:expense_tracker_lite/features/add_expense/view_models/expense_event.dart';
import 'package:expense_tracker_lite/features/add_expense/view_models/expense_stata.dart';
import 'package:expense_tracker_lite/features/dashboard/views/screens/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';


// Step 1: Create a mock Bloc
class MockExpenseBloc extends Mock implements ExpenseBloc {}

void main() {
  late MockExpenseBloc mockBloc;

  setUp(() {
    mockBloc = MockExpenseBloc();

    // Step 2: Setup mock behavior
    when(() => mockBloc.state).thenReturn(
      ExpenseLoaded(
        expenses: List.generate(10, (i) => Expense(
          date: DateTime.now(),
          amount: -100 * (i + 1),
          id: '$i',
        )),
        hasReachedMax: false,
      ),
    );
  });

  testWidgets('Triggers LoadMoreExpensesEvent when scrolled', (tester) async {
    // Step 3: Build widgets with mock bloc
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider.value(
          value: mockBloc,
          child:  DashboardScreen(),
        ),
      ),
    );

    // Step 4: Verify initial state
    expect(find.text('Manually'), findsOneWidget);

    // Step 5: Simulate scroll
    await tester.drag(
      find.byType(ListView),
      const Offset(0, -500), // Scroll up
    );
    await tester.pumpAndSettle();

    // Step 6: Verify event was added
    verify(() => mockBloc.add(any(that: isA<LoadMoreExpensesEvent>())))
        .called(1);
  });
}