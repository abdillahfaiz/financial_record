import 'package:financial_record/pages/expense_page.dart';
import 'package:financial_record/pages/income_page.dart';
import 'package:financial_record/pages/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: {
        '/' : (context) => const DashboardScreen(),
        '/income-data' :(context) => const AddDataScreen(),
        '/expense-data' :(context) => const ExpenseScreen()
      },
      // home: const IncomeScreen(),
    );
  }
}
