import 'package:equatable/equatable.dart';
import 'package:exptracker/models/category.dart';
import 'package:exptracker/models/expense.dart';
import 'package:exptracker/repositories/expense_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'expense_list_state.dart';
part 'expense_list_event.dart';

class ExpenseListBloc extends Bloc<ExpenseListEvent, ExpenseListState> {
  ExpenseListBloc({
    required ExpenseRepository repository,
  })  : _repository = repository,
        super(ExpenseListState()) {
    on<ExpenseListSubscriptionRequested>(_onSubscriptionRequested);
    on<ExpenseListExpenseDeleted>(_onExpenseDeleted);
    on<ExpenseListCategoryFilterChange>(_onCategoryFilterChange);
  }

  final ExpenseRepository _repository;

  Future<void> _onSubscriptionRequested(
    ExpenseListSubscriptionRequested event,
    Emitter<ExpenseListState> emit,
  ) async {
    emit(state.copyWith(status: () => ExpenseListStatus.loading));

    final stream = _repository.getExpenses();

    await emit.forEach<List<Expense?>>(
      stream,
      onData: (expenses) => state.copyWith(
        status: () => ExpenseListStatus.success,
        expenses: () => expenses,
        totalExpenses: () => expenses
            .map((currentExpense) => currentExpense?.amount)
            .fold(0.0, (a, b) => a + b!),
      ),
      onError: (_, __) => state.copyWith(
        status: () => ExpenseListStatus.error,
      ),
    );
  }

  Future<void> _onExpenseDeleted(
    ExpenseListExpenseDeleted event,
    Emitter<ExpenseListState> emit,
  ) async {
    await _repository.deleteExpense(event.expense.id);
  }

  Future<void> _onCategoryFilterChange(
    ExpenseListCategoryFilterChange event,
    Emitter<ExpenseListState> emit,
  ) async {
    emit(state.copyWith(filter: () => event.filter));
  }
}
