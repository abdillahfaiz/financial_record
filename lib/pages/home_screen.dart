import 'dart:convert';

import 'package:financial_record/utils/add_button.dart';
import 'package:financial_record/utils/app_bar.dart';
import 'package:financial_record/utils/card_history.dart';
import 'package:financial_record/utils/form_create.dart';
import 'package:financial_record/models/finance_models.dart';
import 'package:financial_record/models/finance_total_models.dart';
import 'package:financial_record/utils/text_config.dart';
import 'package:financial_record/utils/title_history.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

Future<FinanceTotalModel> getTotal() async {
  final response = await http.get(Uri.parse('http://127.0.0.1:8000/api/total'));
  print(response.body);
  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    FinanceTotalModel result = FinanceTotalModel.fromJson(data);
    return result;
  } else {
    throw Exception('Failed to load data');
  }
}

Future<FinanceData> getAllData() async {
  final response = await http.get(Uri.parse('http://127.0.0.1:8000/api/data'));
  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    FinanceData result = FinanceData.fromJson(data);
    return result;
  } else {
    throw Exception('Failed to Load Data');
  }
}

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late Future<FinanceTotalModel> dataTotal;
  late Future<FinanceData> allData;

  @override
  void initState() {
    super.initState();
    dataTotal = getTotal();
    allData = getAllData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0F111E),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const AppBarCustom(),
            const SizedBox(
              height: 40.0,
            ),
            MainText(
                fontSize: 14,
                color: Colors.white,
                fontWeight: FontWeight.w600,
                text: 'Saldomu Sekarang'),
            const SizedBox(
              height: 10.0,
            ),
            FutureBuilder(
              future: dataTotal,
              builder: ((context, snapshot) {
                if (snapshot.hasData) {
                  return MainText(
                      fontSize: 40,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      text: ' Rp. ${snapshot.data!.data.toString()}');
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error : ${snapshot.error}'));
                }
                return const Center(child: CircularProgressIndicator());
              }),
            ),
            const SizedBox(
              height: 25.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                    onTap: () {},
                    child: AddFinance(
                        title: 'Pemasukan', image: 'assets/icon2.png')),
                InkWell(
                    onTap: () {},
                    child: AddFinance(
                        title: 'Pengeluaran', image: 'assets/icon1.png')),
              ],
            ),
            const SizedBox(
              height: 25.0,
            ),
            const HistoryFinanceTitle(),
            const SizedBox(
              height: 10.0,
            ),
            FutureBuilder(
                future: allData,
                builder: ((context, snapshot) {
                  if (snapshot.hasData) {
                    return Expanded(
                      child: ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          separatorBuilder: (context, index) {
                            return const Divider(
                              thickness: 1,
                              color: Color(0xff212436),
                            );
                          },
                          itemCount: snapshot.data!.financeData!.length,
                          itemBuilder: (context, index) {
                            if (snapshot.data!.financeData![index].category ==
                                'income') {
                              return CardHistory(
                                  textTitle:
                                      snapshot.data!.financeData![index].title,
                                  textSubTitle: snapshot
                                      .data!.financeData![index].category,
                                  textCounted:
                                      '+ ${snapshot.data!.financeData![index].counted.toString()}',
                                  color: Colors.green);
                            } else {
                              return CardHistory(
                                  textTitle:
                                      snapshot.data!.financeData![index].title,
                                  textSubTitle: snapshot
                                      .data!.financeData![index].category,
                                  textCounted:
                                      '- ${snapshot.data!.financeData![index].counted.toString()}',
                                  color: Colors.red);
                            }
                          }),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error : ${snapshot.error}'),
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.green,
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.pushNamed(context, '/add-data');
          }),
    );
  }
}
