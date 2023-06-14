import 'dart:convert';

import 'package:financial_record/api/network_manager.dart';
import 'package:financial_record/models/finance_models.dart';
import 'package:financial_record/models/finance_total_models.dart';
import 'package:financial_record/utils/form_create.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddDataScreen extends StatefulWidget {
  const AddDataScreen({super.key});

  @override
  State<AddDataScreen> createState() => _AddDataScreenState();
}

class _AddDataScreenState extends State<AddDataScreen> {
  final titleController = TextEditingController();
  final countedController = TextEditingController();
  late Future<FinanceData> futureData;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pemasukan'),
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
                            'income');
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
