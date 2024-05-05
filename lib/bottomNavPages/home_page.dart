import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinnaclefx/Models/reuseable_widgets.dart';
import 'package:pinnaclefx/models/modal_classes.dart';
import 'package:pinnaclefx/screens/transactions/deposit.dart';
import 'package:pinnaclefx/screens/transactions/transfer.dart';
import 'package:pinnaclefx/screens/transactions/withdrawal.dart';

class HomePage extends StatefulWidget {
  final String linkedAccountID;
  final String firstName;
  final int balance;
  HomePage({super.key, required this.firstName, required this.balance, required this.linkedAccountID});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
      child: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Hello! ${widget.firstName}', style: tabHeaderTextstyle),
                Image.asset(
                  'asset/images/profile.png',
                  height: 30,
                  filterQuality: FilterQuality.medium,
                )
              ],
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.15,
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Color.fromRGBO(115, 3, 217, 1),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Trading Balance',
                              style: TextStyle(color: Colors.white),
                            ),
                            IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.more_horiz,
                                  color: Colors.white,
                                ))
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '\$${widget.balance.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 28),
                            ),
                            Container(
                              width: 100,
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40),
                                color: Color.fromRGBO(33, 17, 71, 1),
                              ),
                              child: Center(
                                child: Text(
                                  'USD',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16),
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        child: ShadowedBoxes(
                          height: 120,
                          width: MediaQuery.of(context).size.width * 0.25,
                          padding: 8,
                          borderRadius: 15,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset(
                                'asset/images/chart1.png',
                                height: 40,
                                filterQuality: FilterQuality.medium,
                              ),
                              Text(
                                'Deposit',
                                style: TextStyle(
                                    color: Color.fromRGBO(33, 17, 71, 1),
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                'Minimum \$100',
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey,
                                    fontSize: 10.sp),
                              )
                            ],
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => DepositPage(linkedAccountID: widget.linkedAccountID,),
                              ));
                        },
                      ),
                      GestureDetector(
                        child: ShadowedBoxes(
                          height: 120,
                          width: MediaQuery.of(context).size.width * 0.25,
                          padding: 8,
                          borderRadius: 15,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset(
                                'asset/images/chart2.png',
                                filterQuality: FilterQuality.medium,
                                height: 40,
                              ),
                              Text(
                                'Withdraw',
                                style: TextStyle(
                                    color: Color.fromRGBO(33, 17, 71, 1),
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                'Max \$100k',
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey,
                                    fontSize: 11.5.sp),
                              )
                            ],
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => WithdrawalPage(),
                              ));
                        },
                      ),
                      GestureDetector(
                        child: ShadowedBoxes(
                            height: 120,
                            width: MediaQuery.of(context).size.width * 0.25,
                            padding: 8,
                            borderRadius: 15,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset(
                                  'asset/images/chart3.png',
                                  filterQuality: FilterQuality.medium,
                                  height: 40,
                                ),
                                Text(
                                  'Transfer',
                                  style: TextStyle(
                                      color: Color.fromRGBO(33, 17, 71, 1),
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  '5 per day',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey,
                                      fontSize: 11.5.sp),
                                )
                              ],
                            )),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => TransferPage(),
                              ));
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.3,
                    width: double.infinity,
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Color.fromRGBO(115, 3, 217, 1)),
                    child: Stack(children: [
                      LineChartWidget(),
                      Positioned(child: LineChartSample())
                    ]),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
