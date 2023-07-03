import 'package:financial_record/api/network_manager.dart';
import 'package:financial_record/utils/app_bar.dart';
import 'package:financial_record/utils/card_history.dart';
import 'package:financial_record/models/finance_models.dart';
import 'package:financial_record/models/finance_total_models.dart';
import 'package:financial_record/utils/dialog_form_pemasukan.dart';
import 'package:financial_record/utils/dialog_form_pengeluaran.dart';
import 'package:financial_record/utils/text_config.dart';
import 'package:financial_record/utils/title_history.dart';
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late Future<FinanceTotalModel>? dataTotal;
  late Future<FinanceData>? allData;
  late Future<FinanceData>? deleteData;

  Future _refreshAction() async {
    setState(() {
      allData = NetworkManager().getAllData();
      dataTotal = NetworkManager().getTotal();
    });
    return await Future.delayed(const Duration(seconds: 1));
  }

  @override
  void initState() {
    super.initState();
    dataTotal = NetworkManager().getTotal();
    allData = NetworkManager().getAllData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0F111E),
      body: LiquidPullToRefresh(
        springAnimationDurationInMilliseconds: 700,
        animSpeedFactor: 2,
        showChildOpacityTransition: false,
        onRefresh: _refreshAction,
        child: SingleChildScrollView(
          controller: ScrollController(),
          child: SafeArea(
            child: Container(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  const AppBarCustom(),
                  Column(
                    children: [
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
                                text: snapshot.data!.data.toString());
                          } else if (snapshot.hasError) {
                            return Center(
                                child: Text('Error : ${snapshot.error}'));
                          }
                          return const Center(
                              child: CircularProgressIndicator());
                        }),
                      ),
                      const SizedBox(
                        height: 25.0,
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          DialogForm(),
                          Expense(),
                        ],
                      ),
                      const SizedBox(
                        height: 25.0,
                      ),
                      const HistoryFinanceTitle(),
                      const SizedBox(
                        height: 10.0,
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      const Text(
                        'Tips💡 : Tekan beberapa waktu untuk menghapusnya',
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            _refreshAction();
                          });
                        },
                        child: const Text(
                          'Refresh',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
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
                                  if (snapshot
                                          .data!.financeData![index].category ==
                                      'income') {
                                    return InkWell(
                                      onLongPress: () {
                                        setState(() {
                                          NetworkManager().deleteData(snapshot
                                              .data!.financeData![index].id
                                              .toString());
                                          _refreshAction();
                                        });
                                      },
                                      child: CardHistory(
                                          colorCircle: const Color(0xff0AFF96),
                                          icon: const Icon(
                                            Icons.arrow_circle_up,
                                            color:
                                                Color.fromARGB(255, 24, 24, 24),
                                          ),
                                          textTitle: snapshot
                                              .data!.financeData![index].title,
                                          textSubTitle: snapshot.data!
                                              .financeData![index].category,
                                          textCounted:
                                              '+ Rp.${snapshot.data!.financeData![index].counted.toString()}',
                                          color: const Color(0xff0AFF96)),
                                    );
                                  } else {
                                    return InkWell(
                                      onLongPress: () {
                                        setState(() {
                                          NetworkManager().deleteData(snapshot
                                              .data!.financeData![index].id
                                              .toString());
                                        });
                                        _refreshAction();
                                      },
                                      child: CardHistory(
                                          colorCircle: const Color(0xffFF002E),
                                          icon: const Icon(
                                            Icons.arrow_circle_down,
                                            color: Colors.white,
                                          ),
                                          textTitle: snapshot
                                              .data!.financeData![index].title,
                                          textSubTitle: snapshot.data!
                                              .financeData![index].category,
                                          textCounted:
                                              '- Rp.${snapshot.data!.financeData![index].counted.toString()}',
                                          color: const Color(0xffFF002E)),
                                    );
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
                        }),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
