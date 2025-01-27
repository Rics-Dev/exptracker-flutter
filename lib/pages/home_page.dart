import 'package:exptracker/extensions/extensions.dart';
import 'package:exptracker/widgets/total_expenses_widget.dart';
import 'package:exptracker/blocs/expense_list/expense_list_bloc.dart';
import 'package:exptracker/repositories/expense_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ExpenseListBloc(
        repository: context.read<ExpenseRepository>(),
      )..add(const ExpenseListSubscriptionRequested()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Expense Tracker'),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: const [
              TotalExpensesWidget(),
              SizedBox(height: 16),
              ExpenseFilterWidget(),
              SizedBox(height: 16),
              ExpensesWidget(),
              SizedBox(height: 16),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => context.showAddExpenseBottomSheet(),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
