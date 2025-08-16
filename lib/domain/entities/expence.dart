import 'package:expense_tracker_lite/data/models/category_model.dart';

class Expense {
  final String id;
  final Category? category;
  final double amount;
  final DateTime date;
  final String? receiptPath;
  double? originalAmount;
  double? convertedAmount;
  

  Expense({
    required this.id,
    this.category,
    required this.amount,
    required this.date,
    this.receiptPath,
    this.originalAmount,
    this.convertedAmount
  });
}