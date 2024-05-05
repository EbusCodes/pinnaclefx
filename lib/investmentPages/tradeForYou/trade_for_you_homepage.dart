import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pinnaclefx/InvestmentPages/TradeForYou/trade_for_you_amount.dart';
import 'package:pinnaclefx/Models/reuseable_widgets.dart';
import 'package:pinnaclefx/utils/api_endpoints.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TradeForYouHomePage extends StatefulWidget {
  final int asset;
  const TradeForYouHomePage({super.key, required this.asset});

  @override
  State<TradeForYouHomePage> createState() => _TradeForYouHomePageState();
}

class _TradeForYouHomePageState extends State<TradeForYouHomePage> {
  final List<Tab> tabs = [
    const Tab(
        child: Text('Ongoing',
            style: TextStyle(
              color: Color.fromRGBO(115, 3, 217, 1),
              fontWeight: FontWeight.w600,
            ))),
    const Tab(
        child: Text('Liquidated',
            style: TextStyle(
              color: Color.fromRGBO(115, 3, 217, 1),
              fontWeight: FontWeight.w600,
            ))),
  ];

  Future fetchTransactionHistory() async {
    final pref = await SharedPreferences.getInstance();
    final token = pref.getString('token') ?? '';

    var headers = {'x-access-token': token};

    var url = Uri.parse(
        ApiEndpoints.baseUrl + ApiEndpoints.accountEndPoints.investmentHistory);

    http.Response response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      print('TRANSACTION HISTORY: ${response.body}');
      return data;
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
          body: SafeArea(
              child: Column(children: [
        customPageAppBarHome(context, 'Trade For You'),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(15),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.7,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.2,
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 0.5,
                                color: Color.fromRGBO(220, 183, 244, 1)),
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                  color: Color.fromRGBO(220, 183, 244, 1),
                                  offset: Offset(5, 5))
                            ]),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Total Assets',
                              style: TextStyle(
                                  color: Color.fromRGBO(33, 17, 71, 1),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                            Text(
                              '\$${widget.asset.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}',
                              style: TextStyle(
                                  color: Color.fromRGBO(33, 17, 71, 1),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 25),
                            ),
                            Text(
                              'Deposit and earn massive returns',
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                      Container(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * 0.3,
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(220, 183, 244, 1),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                  padding: EdgeInsets.fromLTRB(0, 10.h, 0, 0),
                                  height: 40.h,
                                  child: TabBar(
                                      dividerColor: Colors.transparent,
                                      indicatorColor:
                                          Color.fromRGBO(115, 3, 217, 1),
                                      tabs: tabs)),

                              StreamBuilder(
                                  stream: fetchTransactionHistory().asStream(),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return Expanded(
                                          child: TabBarView(
                                            children: [ Center(
                                              child: CircularProgressIndicator()
                                              ),
                                              Center(child: CircularProgressIndicator())
                                            ]   
                                          ));
                                    }
                                    if (snapshot.hasData) {
                                      final data = snapshot.data!;
                                      final datas = data as List;
                                      final itemcount = data.length;

                                      return Expanded(
                                          child: TabBarView(
                                            children:[ ListView.builder(
                                                itemCount: itemcount,
                                                itemBuilder: (context, index) {
                                                  return ListTile(
                                                      isThreeLine: true,
                                                      leading: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Image.asset(
                                                              'asset/images/invest.png',
                                                              height: 30.w,
                                                              filterQuality:
                                                                  FilterQuality
                                                                      .medium,
                                                            )
                                                          ]),
                                                      title: Text(
                                                          '\$${data[index]['amount'].toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},',)}',
                                                          style: TextStyle(
                                                              color:
                                                                  Color.fromRGBO(
                                                                      33,
                                                                      17,
                                                                      71,
                                                                      1),
                                                              fontWeight:
                                                                  FontWeight.w700,
                                                              fontSize: 13.sp)),
                                                      subtitle: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            '📌 ${data[index]['dateTime'].toString().substring(0, 10)}',
                                                            style: TextStyle(
                                                                fontSize: 9.sp),
                                                          ),
                                                          Text(
                                                              '🎯 ${data[index]['endDate'].toString().substring(0, 10)}',
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      9.sp)),
                                                        ],
                                                      ),
                                                      trailing: Expanded(
                                                          child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: [
                                                                Text(
                                                                    'Daily Interest: '),
                                                                Text(
                                                                    '\$${data[index]['interest'].toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}',
                                                                    style: TextStyle(fontSize: 9.sp),)
                                                              ],
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: [
                                                                Text(
                                                                    'Total Interest: '),
                                                                Text(
                                                                    '\$${data[index]['totalInterest'].toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}',
                                                                    style: TextStyle(fontSize: 9.sp))
                                                              ],
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: [
                                                                Text(
                                                                    'Remaining days: '),
                                                                Text(
                                                                    '${data[index]['remDuration']}',
                                                                    style: TextStyle(fontSize: 9.sp))
                                                              ],
                                                            ),
                                                          ])));
                                                }),
                                                Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            'asset/images/passkey.png',
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.15,
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                              'Currently no liquidated Fixed plans',
                                              style: TextStyle(
                                                color: Color.fromRGBO(
                                                    115, 3, 217, 1),
                                                fontWeight: FontWeight.w400,
                                              ))
                                        ],
                                      )]
                                          ));
                                    } else {
                                      return Expanded(
                                          child: TabBarView(
                                            children: [Column(
                                                                                    mainAxisAlignment:
                                              MainAxisAlignment.center,
                                                                                    children: [
                                            Image.asset(
                                              'asset/images/passkey.png',
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.15,
                                            ),
                                            SizedBox(height: 5),
                                            Text(
                                                'Currently no ongoing Fixed plans',
                                                style: TextStyle(
                                                  color: Color.fromRGBO(
                                                      115, 3, 217, 1),
                                                  fontWeight: FontWeight.w400,
                                                ))
                                                                                    ],
                                                                                  ),
                                                                                  Column(
                                                                                    mainAxisAlignment:
                                              MainAxisAlignment.center,
                                                                                    children: [
                                            Image.asset(
                                              'asset/images/passkey.png',
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.15,
                                            ),
                                            SizedBox(height: 5),
                                            Text(
                                                'Currently no liquidated Fixed plans',
                                                style: TextStyle(
                                                  color: Color.fromRGBO(
                                                      115, 3, 217, 1),
                                                  fontWeight: FontWeight.w400,
                                                ))
                                                                                    ],
                                                                                  ),
                                            ]
                                          ));
                                    }
                                  })
                            ],
                          )),
                    ],
                  ),
                ),
                Container(
                  height: 60,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Color.fromRGBO(33, 17, 71, 1)),
                  child: TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const TradeForYouAmount()));
                      },
                      child: Text(
                        'Create a plan',
                        style: TextStyle(color: Colors.white),
                      )),
                ),
                SizedBox(height: 30)
              ],
            ),
          ),
        ),
      ]))),
    );
  }
}
