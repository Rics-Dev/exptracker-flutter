import 'package:exptracker/data/local_data_storage.dart';
import 'package:exptracker/models/expense.dart';

class ExpenseRepository {
  const ExpenseRepository({
    required LocalDataStorage storage,
  }) : _storage = storage;

  final LocalDataStorage _storage;

  Stream<List<Expense?>> getExpenses() => _storage.getExpenses();

  Future<void> createExpense(Expense expense) => _storage.saveExpense(expense);

  Future<void> deleteExpense(String id) => _storage.deleteExpense(id);
}
