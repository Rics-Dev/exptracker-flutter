import 'package:exptracker/app.dart';
import 'package:exptracker/data/local_data_storage.dart';
import 'package:exptracker/repositories/expense_repository.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final storage = LocalDataStorage(
    preferences: await SharedPreferences.getInstance(),
  );

  final expenseRepository = ExpenseRepository(
    storage: storage,
  );

  runApp(App(expenseRepository: expenseRepository));
}
