import 'package:exptracker/blocs/expense_form/expense_form_bloc.dart';
import 'package:exptracker/repositories/expense_repository.dart';
import 'package:exptracker/widgets/add_expense_sheet_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

extension AppX on BuildContext {
  Future<void> showAddExpenseBottomSheet() async {
    showModalBottomSheet(
      context: this,
      isScrollControlled: true,
      useRootNavigator: true,
      showDragHandle: true,
      builder: (context) => BlocProvider(
        create: (context) => ExpenseFormBloc(
          repository: read<ExpenseRepository>(),
        ),
        child: const AddExpenseSheetWidget(),
      ),
    );
  }
}
