import 'package:financial_record/pages/add_data_screen.dart';
import 'package:financial_record/pages/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
        '/add-data' :(context) => const AddDataScreen()
      },
      // home: const DashboardScreen(),
    );
  }
}
