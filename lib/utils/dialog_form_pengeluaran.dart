// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:financial_record/models/finance_total_models.dart';
import 'package:flutter/material.dart';

import 'package:financial_record/api/network_manager.dart';
import 'package:financial_record/models/finance_models.dart';
import 'package:financial_record/utils/add_button.dart';
import 'package:financial_record/utils/form_create.dart';

class Expense extends StatefulWidget {
  const Expense({
    Key? key,
  }) : super(key: key);

  @override
  State<Expense> createState() => _DialogFormState();
}

class _DialogFormState extends State<Expense> {
  final titleController = TextEditingController();
  final countedController = TextEditingController();
  late Future<FinanceData> futureData;
  late Future<FinanceData>? allData;
  late Future<FinanceTotalModel>? dataTotal;

  Future _refreshAction() async {
    setState(() {
      allData = NetworkManager().getAllData();
      dataTotal = NetworkManager().getTotal();
    });
    return await Future.delayed(const Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  title: const Text("Pengeluaran"),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      FormCreateData(
                        formController: titleController,
                        hintText: 'Masukkan Judul',
                        typeInput: TextInputType.multiline,
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      FormCreateData(
                        formController: countedController,
                        hintText: 'Jumlah',
                        typeInput: TextInputType.number,
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.redAccent[400],
                                borderRadius: BorderRadius.circular(5)),
                            child: TextButton(
                              onPressed: () {
                                titleController.clear();
                                countedController.clear();
                                Navigator.pop(context);
                              },
                              child: const Text(
                                'Cancel',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(5)),
                            child: TextButton(
                                onPressed: () {
                                  
                                  setState(() {
                                    futureData = NetworkManager().createData(
                                        titleController.text,
                                        int.parse(countedController.text),
                                        'expense');
                                    _refreshAction();
                                  });
                                  Navigator.pop(context);
                                  titleController.clear();
                                  countedController.clear();
                                },
                                child: const Text(
                                  'Save',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                )),
                          ),
                        ],
                      )
                    ],
                  ),
                );
              });
        },
        child: AddFinance(title: 'Pengeluaran', image: 'assets/icon1.png'));
  }
}
