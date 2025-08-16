import 'package:expense_tracker_lite/data/models/category_model.dart';
import 'package:hive/hive.dart';

import '../../domain/entities/expence.dart';

part 'expense_model.g.dart'; 


@HiveType(typeId: 0)
class ExpenseModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final Category? category;

  @HiveField(2)
  final double amount;

  @HiveField(3)
  final DateTime date;

  @HiveField(4)
  final String? receiptPath;

  @HiveField(5)
  final double? originalAmount;

  @HiveField(6)
  final double? convertedAmount;
  
  ExpenseModel({
    required this.id,
    required this.category,
    required this.amount,
    required this.date,
    this.receiptPath,
    this.originalAmount,
    this.convertedAmount,
  });

  factory ExpenseModel.fromEntity(Expense expense) {
    return ExpenseModel(
      id: expense.id,
      category: expense.category,
      amount: expense.amount,
      date: expense.date,
      receiptPath: expense.receiptPath,
      originalAmount: expense.originalAmount,
      convertedAmount: expense.convertedAmount
    );
  }

  Expense toEntity() {
    return Expense(
      id: id,
      category: category,
      amount: amount,
      date: date,
      receiptPath: receiptPath,
      originalAmount:originalAmount ,
      convertedAmount: convertedAmount
    );
  }
}