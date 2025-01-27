part of 'expense_form_bloc.dart';

enum ExpenseFormStatus { initial, loading, success, failure }

final class ExpenseFormState extends Equatable {
  const ExpenseFormState({
    this.title,
    this.amount,
    required this.date,
    this.category = Category.other,
    this.status = ExpenseFormStatus.initial,
  });

  final String? title;
  final double? amount;
  final DateTime date; // Changed from DateTime? to DateTime since it's required
  final Category
      category; // Changed from Category? to Category since it has a default value
  final ExpenseFormStatus status;

  ExpenseFormState copyWith({
    String? title,
    double? amount,
    DateTime? date,
    Category? category,
    ExpenseFormStatus? status,
  }) {
    return ExpenseFormState(
      title: title ?? this.title,
      amount: amount ?? this.amount,
      date: date ?? this.date,
      category: category ?? this.category,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [title, amount, date, category, status];

  bool get isFormValid => title != null && amount != null;
}
