part of 'expense_list_bloc.dart';

sealed class ExpenseListEvent extends Equatable {
  const ExpenseListEvent();

  @override
  List<Object> get props => [];
}

final class ExpenseListSubscriptionRequested extends ExpenseListEvent {
  const ExpenseListSubscriptionRequested();
}

final class ExpenseListExpenseDeleted extends ExpenseListEvent {
  const ExpenseListExpenseDeleted(this.expense);
  final Expense expense;

  @override
  List<Object> get props => [];
}

final class ExpenseListCategoryFilterChange extends ExpenseListEvent {
  const ExpenseListCategoryFilterChange(this.filter);
  final Category filter;

  @override
  List<Object> get props => [filter];
}
