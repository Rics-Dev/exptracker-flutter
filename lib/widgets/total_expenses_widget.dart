// total_expenses_widget.dart
import 'package:exptracker/blocs/expense_list/expense_list_bloc.dart';
import 'package:exptracker/models/category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TotalExpensesWidget extends StatelessWidget {
  const TotalExpensesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExpenseListBloc, ExpenseListState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.all(16),
          color: Theme.of(context).primaryColor.withOpacity(0.1),
          child: Column(
            children: [
              Text(
                'Total Expenses',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Text(
                '\$${state.totalExpenses.toStringAsFixed(2)}',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class ExpenseFilterWidget extends StatelessWidget {
  const ExpenseFilterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExpenseListBloc, ExpenseListState>(
      builder: (context, state) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              FilterChip(
                label: const Text('All'),
                selected: state.filter == null,
                onSelected: (selected) {
                  context.read<ExpenseListBloc>().add(
                        const ExpenseListCategoryFilterChange(Category.other),
                      );
                },
              ),
              const SizedBox(width: 8),
              ...Category.values.map(
                (category) => Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    label: Text(category.name),
                    selected: state.filter == category,
                    onSelected: (selected) {
                      context.read<ExpenseListBloc>().add(
                            ExpenseListCategoryFilterChange(
                              selected ? category : Category.other,
                            ),
                          );
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// expenses_widget.dart

class ExpensesWidget extends StatelessWidget {
  const ExpensesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExpenseListBloc, ExpenseListState>(
      builder: (context, state) {
        if (state.status == ExpenseListStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.status == ExpenseListStatus.error) {
          return const Center(
            child: Text('Something went wrong! Please try again.'),
          );
        }

        final expenses = state.filter == null
            ? state.expenses
            : state.expenses
                .where((expense) => expense?.category == state.filter)
                .toList();

        if (expenses.isEmpty) {
          return Center(
            child: Text(
              state.filter == null
                  ? 'No expenses yet!'
                  : 'No expenses for ${state.filter?.name}!',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          );
        }

        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: expenses.length,
          itemBuilder: (context, index) {
            final expense = expenses[index];
            if (expense == null) return const SizedBox();

            return Dismissible(
              key: Key('expense_${expense.id}'),
              direction: DismissDirection.endToStart,
              background: Container(
                color: Colors.red,
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(right: 16),
                child: const Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
              ),
              onDismissed: (_) {
                context.read<ExpenseListBloc>().add(
                      ExpenseListExpenseDeleted(expense),
                    );
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${expense.title} deleted'),
                    action: SnackBarAction(
                      label: 'Undo',
                      onPressed: () {
                        // Add undo functionality if needed
                      },
                    ),
                  ),
                );
              },
              child: ListTile(
                title: Text(expense.title),
                subtitle: Text(expense.date.toString()),
                trailing: Text(
                  '\$${expense.amount.toStringAsFixed(2)}',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Theme.of(context).primaryColor,
                      ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
