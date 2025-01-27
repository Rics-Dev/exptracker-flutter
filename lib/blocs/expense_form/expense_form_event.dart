part of 'expense_form_bloc.dart';

sealed class ExpenseFormEvent extends Equatable {
  const ExpenseFormEvent();

  @override
  List<Object> get props => [];
}

final class ExpenseTitleChange extends ExpenseFormEvent {
  const ExpenseTitleChange(this.title);
  final String title;

  @override
  List<Object> get props => [title];
}

final class ExpenseAmountChange extends ExpenseFormEvent {
  const ExpenseAmountChange(this.amount);
  final String amount;

  @override
  List<Object> get props => [amount];
}

final class ExpenseDateChange extends ExpenseFormEvent {
  const ExpenseDateChange(this.date);
  final DateTime date;

  @override
  List<Object> get props => [date];
}

final class ExpenseCategoryChange extends ExpenseFormEvent {
  const ExpenseCategoryChange(this.category);
  final Category category;

  @override
  List<Object> get props => [category];
}

final class ExpenseSubmitted extends ExpenseFormEvent {
  const ExpenseSubmitted();
}
