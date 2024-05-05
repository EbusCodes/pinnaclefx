import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinnaclefx/InvestmentPages/Gadgets/gadgets_homepage.dart';
import 'package:pinnaclefx/InvestmentPages/GroupTrading/group_trading_homepage.dart';
import 'package:pinnaclefx/InvestmentPages/RealEstate/real_estate_homepage.dart';
import 'package:pinnaclefx/InvestmentPages/TradeForYou/trade_for_you_homepage.dart';

class InvestPage extends StatefulWidget {
  final int balance;
  final int asset;
  final int interest;
  const InvestPage({super.key, required this.asset, required this.balance, required this.interest});

  @override
  State<InvestPage> createState() => _InvestPageState();
}

class _InvestPageState extends State<InvestPage> {
  bool showBalance = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.fromLTRB(15, 20, 15, 15),
        child: SafeArea(
            child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.15,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(15)),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Total Balance',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Color.fromRGBO(33, 17, 71, 1),
                                      fontSize: 16.sp),
                                ),
                                IconButton(
                                    onPressed: () {
                                      setState(() {
                                        showBalance = !showBalance;
                                        print('$showBalance');
                                      });
                                    },
                                    icon: Icon(
                                      showBalance
                                          ? Icons.visibility_rounded
                                          : Icons.visibility_off_rounded,
                                      color: Color.fromRGBO(33, 17, 71, 1),
                                    ))
                              ],
                            ),
                            Text(
                              'Total Interest',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Color.fromRGBO(33, 17, 71, 1),
                                  fontSize: 16.sp),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              showBalance ? '\$${widget.balance.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}' : '******',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Color.fromRGBO(33, 17, 71, 1),
                                  fontSize: 28.sp),
                            ),
                            Text(
                              showBalance ? '\$${widget.interest.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}' : '******',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Color.fromRGBO(33, 17, 71, 1),
                                  fontSize: 28.sp),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              'asset/images/trend.png',
                              height: 25,
                            ),
                            SizedBox(width: 5),
                            Text(
                              'Total Assets',
                              style: TextStyle(
                                  color: Color.fromRGBO(33, 17, 71, 1),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.sp),
                            )
                          ],
                        ),
                        Text(
                          'Investment packages',
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w400,
                              fontSize: 14.sp),
                        ),
                        Text(
                          showBalance ? '\$${widget.asset.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}' : '*****',
                          style: TextStyle(
                              color: Color.fromRGBO(33, 17, 71, 1),
                              fontWeight: FontWeight.bold,
                              fontSize: 25.sp),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => RealEstateHomePage()));
                            },
                            child: Container(
                              padding: EdgeInsets.all(10),
                              width: MediaQuery.of(context).size.width * 0.425,
                              height: MediaQuery.of(context).size.height * 0.17,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Color.fromRGBO(220, 183, 244, 1)),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Row(
                                    children: [
                                      Image.asset(
                                        'asset/images/real_estate.png',
                                        height: 20,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        'Real Estate',
                                        style: TextStyle(
                                            color:
                                                Color.fromRGBO(33, 17, 71, 1),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15.sp),
                                      )
                                    ],
                                  ),
                                  Text(
                                    'Invest profits into real estate',
                                    style: TextStyle(
                                        color: Color.fromRGBO(115, 3, 217, 1),
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => GroupTradingHomePage()));
                            },
                            child: Container(
                              padding: EdgeInsets.all(10),
                              width: MediaQuery.of(context).size.width * 0.425,
                              height: MediaQuery.of(context).size.height * 0.17,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Color.fromRGBO(220, 183, 244, 1)),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Row(
                                    children: [
                                      Image.asset(
                                        'asset/images/real_estate.png',
                                        height: 20,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        'Group Trading',
                                        style: TextStyle(
                                            color:
                                                Color.fromRGBO(33, 17, 71, 1),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15.sp),
                                      )
                                    ],
                                  ),
                                  Text(
                                    'Pool group capital to trade',
                                    style: TextStyle(
                                        color: Color.fromRGBO(115, 3, 217, 1),
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => TradeForYouHomePage(asset: widget.asset,)));
                            },
                            child: Container(
                              padding: EdgeInsets.all(10),
                              width: MediaQuery.of(context).size.width * 0.425,
                              height: MediaQuery.of(context).size.height * 0.17,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Color.fromRGBO(220, 183, 244, 1)),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Row(
                                    children: [
                                      Image.asset(
                                        'asset/images/real_estate.png',
                                        height: 20,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        'Trade for you',
                                        style: TextStyle(
                                            color:
                                                Color.fromRGBO(33, 17, 71, 1),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15.sp),
                                      )
                                    ],
                                  ),
                                  Text(
                                    'Lock capital and receive interest',
                                    style: TextStyle(
                                        color: Color.fromRGBO(115, 3, 217, 1),
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => const GadgetsHomePage()));
                            },
                            child: Container(
                              padding: EdgeInsets.all(10),
                              width: MediaQuery.of(context).size.width * 0.425,
                              height: MediaQuery.of(context).size.height * 0.17,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Color.fromRGBO(220, 183, 244, 1)),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Row(
                                    children: [
                                      Image.asset(
                                        'asset/images/real_estate.png',
                                        height: 20,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        'Gadgets',
                                        style: TextStyle(
                                            color:
                                                Color.fromRGBO(33, 17, 71, 1),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15.sp),
                                      )
                                    ],
                                  ),
                                  Text(
                                    'Get gadgets with trade profits',
                                    style: TextStyle(
                                        color: Color.fromRGBO(115, 3, 217, 1),
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        )),
      ),
    );
  }
}
