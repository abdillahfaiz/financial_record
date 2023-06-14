import 'package:financial_record/api/network_manager.dart';
import 'package:financial_record/utils/add_button.dart';
import 'package:financial_record/utils/app_bar.dart';
import 'package:financial_record/utils/card_history.dart';
import 'package:financial_record/models/finance_models.dart';
import 'package:financial_record/models/finance_total_models.dart';
import 'package:financial_record/utils/text_config.dart';
import 'package:financial_record/utils/title_history.dart';
import 'package:flutter/material.dart';

// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late Future<FinanceTotalModel> dataTotal;
  late Future<FinanceData>? allData;

  refreshAction() {
    setState(() {
      allData = NetworkManager().getAllData();
      dataTotal = NetworkManager().getTotal();
    });
  }

  @override
  void initState() {
    super.initState();
    // getTotal();
    // getAllData();
    dataTotal = NetworkManager().getTotal();
    allData = NetworkManager().getAllData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0F111E),
      body: SingleChildScrollView(
        controller: ScrollController(),
        child: Container(
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
                        text: ' Rp ${snapshot.data!.data.toString()}');
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
                      onTap: () {
                        Navigator.pushNamed(context, '/income-data');
                      },
                      child: AddFinance(
                          title: 'Pemasukan', image: 'assets/icon2.png')),
                  InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/expense-data');
                      },
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
              TextButton(
                  onPressed: () {
                    refreshAction();
                  },
                  child: const Text('Refresh')),
              FutureBuilder(
                  future: allData,
                  builder: ((context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.separated(
                          shrinkWrap: true,
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
                          });
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
      ),
    );
  }
}
