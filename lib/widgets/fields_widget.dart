import 'package:exptracker/blocs/expense_form/expense_form_bloc.dart';
import 'package:exptracker/models/category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class TitleFieldWidget extends StatelessWidget {
  const TitleFieldWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final state = context.watch<ExpenseFormBloc>().state;

    return TextFormField(
      style: textTheme.displaySmall?.copyWith(fontSize: 30),
      onChanged: (value) {
        context.read<ExpenseFormBloc>().add(ExpenseTitleChange(value));
      },
      decoration: InputDecoration(
        enabled: state.status != ExpenseFormStatus.loading,
        labelText: 'Title',
        labelStyle: textTheme.displaySmall?.copyWith(fontSize: 30),
        border: InputBorder.none,
        hintText: 'Expense title',
      ),
    );
  }
}

// Amount Field Widget
class AmountFieldWidget extends StatelessWidget {
  const AmountFieldWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final state = context.watch<ExpenseFormBloc>().state;

    return TextFormField(
      keyboardType: TextInputType.number,
      style: textTheme.displaySmall?.copyWith(fontSize: 30),
      onChanged: (value) {
        final amount = double.tryParse(value) ?? 0.0;
        context
            .read<ExpenseFormBloc>()
            .add(ExpenseAmountChange(amount.toString()));
      },
      decoration: InputDecoration(
        enabled: state.status != ExpenseFormStatus.loading,
        labelText: 'Amount',
        labelStyle: textTheme.displaySmall?.copyWith(fontSize: 30),
        border: InputBorder.none,
        hintText: 'Enter amount',
        prefixText: '\$',
      ),
    );
  }
}

// Date Field Widget
class DateFieldWidget extends StatelessWidget {
  const DateFieldWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final state = context.watch<ExpenseFormBloc>().state;

    final formattedDate = DateFormat('dd/MM/yyyy').format(state.date);

    return InkWell(
      onTap: state.status != ExpenseFormStatus.loading
          ? () async {
              final selectedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
              );
              if (selectedDate != null) {
                context
                    .read<ExpenseFormBloc>()
                    .add(ExpenseDateChange(selectedDate));
              }
            }
          : null,
      child: InputDecorator(
        decoration: InputDecoration(
          enabled: state.status != ExpenseFormStatus.loading,
          labelText: 'Date',
          labelStyle: textTheme.displaySmall?.copyWith(fontSize: 30),
          border: InputBorder.none,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              state.date.toLocal().toString().split(' ')[0],
              style: textTheme.displaySmall?.copyWith(fontSize: 30),
            ),
            const Icon(Icons.calendar_today),
          ],
        ),
      ),
    );
  }
}

// Category Choices Widget
class CategoryChoicesWidget extends StatelessWidget {
  const CategoryChoicesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final state = context.watch<ExpenseFormBloc>().state;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Category',
          style: textTheme.displaySmall?.copyWith(fontSize: 30),
        ),
        const SizedBox(height: 8.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: Category.values.map((category) {
            return ChoiceChip(
              label: Text(category.toString().split('.').last),
              selected: state.category == category,
              onSelected: (selected) {
                if (selected) {
                  context
                      .read<ExpenseFormBloc>()
                      .add(ExpenseCategoryChange(category));
                }
              },
            );
          }).toList(),
        ),
      ],
    );
  }
}

// Add Expense Button Widget
class AddExpenseButtonWidget extends StatelessWidget {
  const AddExpenseButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ExpenseFormBloc>().state;

    return ElevatedButton(
      onPressed: state.status != ExpenseFormStatus.loading
          ? () {
              context.read<ExpenseFormBloc>().add(const ExpenseSubmitted());
            }
          : null,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: state.status == ExpenseFormStatus.loading
            ? const CircularProgressIndicator()
            : const Text(
                'Add Expense',
                style: TextStyle(fontSize: 20),
              ),
      ),
    );
  }
}
