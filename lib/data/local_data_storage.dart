import 'dart:convert';

import 'package:exptracker/models/expense.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalDataStorage {
  LocalDataStorage({
    required SharedPreferences preferences,
  }) : _preferences = preferences {
    _initialize();
  }

  final SharedPreferences _preferences;

  static const expensesCollectionKey = 'expenses_collection_key';

  final _controller = BehaviorSubject<List<Expense?>>.seeded(const []);

  void _initialize() {
    final expensesJson = _preferences.getString(expensesCollectionKey);

    if (expensesJson != null) {
      final expenses = (jsonDecode(expensesJson) as List)
          .map((e) => Expense.fromJson(e))
          .toList();
      _controller.add(expenses);
    } else {
      _controller.add([]);
    }
  }

  Stream<List<Expense?>> getExpenses() => _controller.asBroadcastStream();

  Future<void> saveExpense(Expense expense) async {
    final expenses = [..._controller.value];
    final expenseIndex = expenses.indexWhere(
      (currentExpense) => currentExpense?.id == expense.id,
    );

    if (expenseIndex >= 0) {
      expenses[expenseIndex] = expense;
    } else {
      expenses.add(expense);
    }

    _controller.add(expenses);
    await _preferences.setString(expensesCollectionKey, jsonEncode(expenses));
  }

  Future<void> deleteExpense(String id) async {
    final expenses = [..._controller.value];
    final expenseIndex = expenses.indexWhere(
      (currentExpense) => currentExpense?.id == id,
    );

    if (expenseIndex >= 0) {
      expenses.removeAt(expenseIndex);
      _controller.add(expenses);
      await _preferences.setString(expensesCollectionKey, jsonEncode(expenses));
    } else {
      throw Exception('Expense not found');
    }
  }
}
