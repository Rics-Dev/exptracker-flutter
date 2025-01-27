// expense_form_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import 'package:equatable/equatable.dart';
import 'package:exptracker/models/category.dart';
import 'package:exptracker/models/expense.dart';
import 'package:exptracker/repositories/expense_repository.dart';

part 'expense_form_state.dart';
part 'expense_form_event.dart';

class ExpenseFormBloc extends Bloc<ExpenseFormEvent, ExpenseFormState> {
  ExpenseFormBloc({
    required ExpenseRepository repository,
  })  : _repository = repository,
        super(ExpenseFormState(date: DateTime.now())) {
    on<ExpenseTitleChange>(_onTitleChange);
    on<ExpenseAmountChange>(_onAmountChange);
    on<ExpenseDateChange>(_onDateChange);
    on<ExpenseCategoryChange>(_onCategoryChange);
    on<ExpenseSubmitted>(_onSubmitted);
  }

  final ExpenseRepository _repository;

  void _onTitleChange(
    ExpenseTitleChange event,
    Emitter<ExpenseFormState> emit,
  ) {
    emit(state.copyWith(title: event.title));
  }

  void _onAmountChange(
    ExpenseAmountChange event,
    Emitter<ExpenseFormState> emit,
  ) {
    emit(state.copyWith(amount: double.parse(event.amount)));
  }

  void _onDateChange(
    ExpenseDateChange event,
    Emitter<ExpenseFormState> emit,
  ) {
    emit(state.copyWith(date: event.date));
  }

  void _onCategoryChange(
    ExpenseCategoryChange event,
    Emitter<ExpenseFormState> emit,
  ) {
    emit(state.copyWith(category: event.category));
  }

  Future<void> _onSubmitted(
    ExpenseSubmitted event,
    Emitter<ExpenseFormState> emit,
  ) async {
    final expense = Expense(
      id: const Uuid().v4(),
      title: state.title!,
      amount: state.amount!,
      date: state.date,
      category: state.category,
    );

    emit(state.copyWith(status: ExpenseFormStatus.loading));

    try {
      await _repository.createExpense(expense);
      emit(state.copyWith(status: ExpenseFormStatus.success));
      emit(ExpenseFormState(date: DateTime.now()));
    } catch (e) {
      emit(state.copyWith(status: ExpenseFormStatus.failure));
    }
  }
}
