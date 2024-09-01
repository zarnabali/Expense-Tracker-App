import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/models/widget/chart/chart.dart';
import 'package:expense_tracker/models/widget/expenses_list.dart';
import 'package:expense_tracker/new_expenses.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _Expenses();
  }
}

class _Expenses extends State<Expenses> {
  List<Color> BackgroundColor = [
    const Color.fromARGB(255, 12, 50, 4),
    const Color.fromARGB(255, 0, 0, 0)
  ];

  final List<Expense> _registeredExpenses = [
    Expense(
        title: 'Shoes',
        amount: 100,
        date: DateTime.now(),
        category: Category.leisure),
    Expense(
        title: 'Cinema',
        amount: 50,
        date: DateTime.now(),
        category: Category.leisure),
    Expense(
        title: 'KFC', amount: 20, date: DateTime.now(), category: Category.food)
  ];

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpenses(onAddExpense: _addExpense),
    );
  }

  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    int index = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text("Expense Deleted"),
        action: SnackBarAction(
            label: 'Undo',
            onPressed: () {
              setState(() {
                _registeredExpenses.insert(index, expense);
              });
            }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = const Center(
        child: Text(
      'No Expense try adding one!',
      style: TextStyle(
        color: Colors.white,
      ),
    ));
    if (_registeredExpenses.isNotEmpty) {
      mainContent = expenses_List(
        onRemoveExpense: _removeExpense,
        expenses: _registeredExpenses,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Tracker'),
        actions: [
          IconButton(
              onPressed: _openAddExpenseOverlay, icon: const Icon(Icons.add))
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: BackgroundColor,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight),
        ),
        child: Column(
          children: [
            Chart(expenses: _registeredExpenses),
            Expanded(child: mainContent)
          ],
        ),
      ),
    );
  }
}
