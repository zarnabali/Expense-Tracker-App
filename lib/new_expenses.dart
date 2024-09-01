import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class NewExpenses extends StatefulWidget {
  NewExpenses({super.key, required this.onAddExpense});

  void Function(Expense expense) onAddExpense;
  @override
  State<NewExpenses> createState() {
    return _NewExpenses();
  }
}

class _NewExpenses extends State<NewExpenses> {
  final _titleController = TextEditingController();
  Category _selectedCategpry = Category.leisure;
  final _amountController = TextEditingController();
  DateTime? _selectedDate;

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _showDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 24, now.month, now.day);
    var datepicker = await showDatePicker(
      context: context,
      firstDate: firstDate,
      lastDate: now,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
              dialogBackgroundColor: const Color.fromARGB(255, 11, 73, 40),
              colorScheme: const ColorScheme.light(
                primary: Colors.green, //header and selced day background color
                onPrimary: Colors.white, // titles and
                onSurface: Colors.black,
              )),
          child: child!,
        );
      },
    );
    setState(() {
      _selectedDate = datepicker;
    });
  }

  void _submitExpenseData() {
    final enteredAmount = double.tryParse(_amountController.text);
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;

    if (_titleController.text.trim().isEmpty ||
        _selectedDate == null ||
        amountIsInvalid) {
      print('errroeerrr');
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid Input'),
          content: const Text(
              'Please make sure a valid title, amount , date and category  was entered.'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(ctx);
                },
                child: const Text('Okay'))
          ],
        ),
      );
      return;
    }

    widget.onAddExpense(
      Expense(
          title: _titleController.text,
          amount: enteredAmount,
          date: _selectedDate!,
          category: _selectedCategpry),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return
        // decoration: const BoxDecoration(
        //   gradient: LinearGradient(colors: [
        //     Color.fromARGB(255, 41, 82, 50),
        //     Color.fromARGB(255, 67, 83, 15)
        //   ], begin: Alignment.topLeft, end: Alignment.bottomRight),
        // ),
        Padding(
      padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
      child: Column(
        children: [
          TextField(
            maxLength: 50,
            controller: _titleController,
            decoration: const InputDecoration(
              label: Text('Title'),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    prefixText: '\$',
                    label: Text('Amount'),
                  ),
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(_selectedDate == null
                      ? 'No Date Selected'
                      : formatter.format(_selectedDate!)),
                  IconButton(
                      onPressed: _showDatePicker,
                      icon: const Icon(Icons.calendar_month))
                ],
              ))
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            children: [
              DropdownButton(
                  value: _selectedCategpry,
                  items: Category.values
                      .map((category) => DropdownMenuItem(
                            value: category,
                            child: Text(
                              category.name.toUpperCase(),
                            ),
                          ))
                      .toList(),
                  onChanged: (value) {
                    if (value == null) {
                      return;
                    }
                    setState(() {
                      _selectedCategpry = value;
                    });
                  }),
              const Spacer(),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel')),
              ElevatedButton(
                  onPressed: () {
                    _submitExpenseData();
                  },
                  child: const Text('Save Expense'))
            ],
          )
        ],
      ),
    );
  }
}
