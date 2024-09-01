import 'package:expense_tracker/expenses.dart';
import 'package:flutter/material.dart';

var kcolorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 12, 50, 4),
);

var kdarkcolorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(255, 12, 50, 4),
);
void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,

    //darkmode theme
    darkTheme: ThemeData.dark().copyWith(
      colorScheme: kdarkcolorScheme,
      appBarTheme: const AppBarTheme().copyWith(
        backgroundColor: kdarkcolorScheme.primaryContainer,
        foregroundColor: kdarkcolorScheme.onPrimaryContainer,
        titleTextStyle: TextStyle(
            color: kdarkcolorScheme.onPrimaryContainer,
            fontSize: 20,
            fontWeight: FontWeight.bold),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            backgroundColor: kdarkcolorScheme.primaryContainer),
      ),
      cardTheme: const CardTheme().copyWith(
        color: kdarkcolorScheme.primaryContainer,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
      textTheme: ThemeData().textTheme.copyWith(
          titleLarge: TextStyle(
              color: kdarkcolorScheme.onPrimaryContainer,
              fontSize: 18,
              fontWeight: FontWeight.bold),
          titleMedium: TextStyle(color: kdarkcolorScheme.onPrimaryContainer)),
    ),

    //light mode theme
    theme: ThemeData().copyWith(
      colorScheme: kcolorScheme,
      appBarTheme: const AppBarTheme().copyWith(
        backgroundColor: kcolorScheme.primaryContainer,
        foregroundColor: kcolorScheme.onPrimaryContainer,
        titleTextStyle: TextStyle(
            color: kcolorScheme.onPrimaryContainer,
            fontSize: 20,
            fontWeight: FontWeight.bold),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            backgroundColor: kcolorScheme.primaryContainer),
      ),
      cardTheme: const CardTheme().copyWith(
        color: kcolorScheme.secondaryContainer,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
      textTheme: ThemeData().textTheme.copyWith(
            titleLarge:
                const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
    ),
    themeMode: ThemeMode.light,
    home: const Expenses(),
  ));
}
