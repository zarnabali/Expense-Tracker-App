import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ExpensesItem extends StatelessWidget {
  ExpensesItem(this.item, {super.key});

  final Expense item;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        child: Column(
          children: [
            Text(
              item.title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(
              height: 4,
            ),
            Row(
              children: [
                Text(
                  '\$ ${item.amount.toStringAsFixed(2)}',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const Spacer(),
                Row(
                  children: [
                    Icon(CategoryIcons[item.category]),
                    Text(
                      item.formattedDate,
                      style: Theme.of(context).textTheme.titleMedium,
                    )
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
