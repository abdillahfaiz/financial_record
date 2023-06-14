import 'dart:convert';

import 'package:financial_record/api/network_manager.dart';
import 'package:financial_record/models/finance_models.dart';
import 'package:financial_record/utils/form_create.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ExpenseScreen extends StatefulWidget {
  const ExpenseScreen({super.key});

  @override
  State<ExpenseScreen> createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends State<ExpenseScreen> {
  final titleController = TextEditingController();
  final countedController = TextEditingController();
  String _category = '';

  late Future<FinanceData> futureData;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengeluaran'),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FormCreateData(
              formController: titleController,
              hintText: 'Masukkan Judul',
              typeInput: TextInputType.multiline,
            ),
            FormCreateData(
              formController: countedController,
              hintText: 'Terbilang',
              typeInput: TextInputType.number,
            ),
            Row(
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                        color: Colors.redAccent,
                      ),
                    )),
                TextButton(
                    onPressed: () {
                      setState(() {
                        futureData = NetworkManager().createData(
                            titleController.text,
                            int.parse(countedController.text),
                            'expense');
                      });
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Save',
                      style: TextStyle(
                        color: Colors.green,
                      ),
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
