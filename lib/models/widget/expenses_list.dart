import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/models/widget/expenses_item.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class expenses_List extends StatelessWidget {
  expenses_List(
      {super.key, required this.onRemoveExpense, required this.expenses});
  void Function(Expense expense) onRemoveExpense;
  // ignore: non_constant_identifier_names
  List<Expense> expenses = [];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (ctx, index) => Dismissible(
        key: ValueKey(expenses[index]),
        background: Container(
          color: Theme.of(context).colorScheme.error,
          margin: EdgeInsets.symmetric(
              horizontal: Theme.of(context).cardTheme.margin!.horizontal),
          child: const Icon(Icons.delete),
        ),
        onDismissed: (direction) {
          onRemoveExpense(expenses[index]);
        },
        child: ExpensesItem(expenses[index]),
      ),
    );
  }
}
