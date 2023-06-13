import 'dart:convert';

import 'package:financial_record/models/finance_models.dart';
import 'package:financial_record/utils/form_create.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<FinanceData> createData(
    String title, int counted, String category) async {
  // return  = await http.post(Uri.parse('http://127.0.0.1:8000/api/create'),

  final response = await http.post(
      Uri.parse('http://127.0.0.1:8000/api/create'),
      body: jsonEncode(<String, dynamic>{
        'title': title,
        'counted': counted,
        'category': category
      }));

  if (response.statusCode == 201) {
    return FinanceData.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to create data');
  }
}

class AddDataScreen extends StatefulWidget {
  const AddDataScreen({super.key});

  @override
  State<AddDataScreen> createState() => _AddDataScreenState();
}

class _AddDataScreenState extends State<AddDataScreen> {
  final titleController = TextEditingController();
  final countedController = TextEditingController();
  String _category = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            Container(
              width: double.infinity,
              child: Column(
                children: [
                  // RadioListTile(value: value, groupValue: groupValue, onChanged: onChanged)
                  RadioListTile(
                      title: const Text('Pemasukan'),
                      value: 'income',
                      groupValue: _category,
                      onChanged: (value) {
                        setState(() {
                          _category = value!;
                        });
                      }),
                  RadioListTile(
                      title: const Text('Pengeluaran'),
                      value: 'expense',
                      groupValue: _category,
                      onChanged: (value) {
                        setState(() {
                          _category = value!;
                        });
                      }),
                ],
              ),
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
                      createData(titleController.text,
                          int.parse(countedController.text), _category);
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
