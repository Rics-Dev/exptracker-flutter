import 'package:exptracker/widgets/fields_widget.dart';
import 'package:flutter/material.dart';

class AddExpenseSheetWidget extends StatelessWidget {
  const AddExpenseSheetWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: MediaQuery.viewInsetsOf(context),
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TitleFieldWidget(),
              SizedBox(height: 16.0),
              AmountFieldWidget(),
              SizedBox(height: 16.0),
              DateFieldWidget(),
              SizedBox(height: 16.0),
              CategoryChoicesWidget(),
              SizedBox(height: 16.0),
              AddExpenseButtonWidget(),
              SizedBox(height: 16.0),
            ],
          ),
        ));
  }
}
