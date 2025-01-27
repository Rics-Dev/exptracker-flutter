part of 'expense_list_bloc.dart';

enum ExpenseListStatus { initial, loading, success, error }

final class ExpenseListState extends Equatable {
  const ExpenseListState({
    this.expenses = const [],
    this.status = ExpenseListStatus.initial,
    this.totalExpenses = 0.0,
    this.filter = Category.other,
  });

  final List<Expense?> expenses;
  final ExpenseListStatus status;
  final double totalExpenses;
  final Category filter;

  ExpenseListState copyWith({
    List<Expense?> Function()? expenses,
    ExpenseListStatus Function()? status,
    double Function()? totalExpenses,
    Category Function()? filter,
  }) {
    return ExpenseListState(
      expenses: expenses != null ? expenses() : this.expenses,
      status: status != null ? status() : this.status,
      totalExpenses:
          totalExpenses != null ? totalExpenses() : this.totalExpenses,
      filter: filter != null ? filter() : this.filter,
    );
  }

  factory ExpenseListState.initial() => const ExpenseListState();

  @override
  List<Object?> get props => [expenses, status, totalExpenses, filter];
}
