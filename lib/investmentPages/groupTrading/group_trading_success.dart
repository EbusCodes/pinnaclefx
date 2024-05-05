// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinnaclefx/launch_page.dart';

class GroupTradingSuccess extends StatelessWidget {
  int amount;
  GroupTradingSuccess({super.key, required this.amount});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(children: [
        SizedBox(height: 15),
        Text('Group Trading',
            textAlign: TextAlign.start,
            style: TextStyle(
                fontSize: 26.sp,
                color: Color.fromRGBO(33, 17, 71, 1),
                fontWeight: FontWeight.w600)),
        Container(
            height: MediaQuery.of(context).size.height * 0.7,
            padding: EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'asset/images/checkbox.png',
                  height: MediaQuery.of(context).size.height * 0.25,
                ),
                SizedBox(height: 20),
                Text(
                  '\$${amount.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}',
                  style: TextStyle(
                      color: Color.fromRGBO(33, 17, 71, 1),
                      fontWeight: FontWeight.w700,
                      fontSize: 28),
                ),
                SizedBox(height: 10),
                Text(
                  'Deposit successful',
                  style: TextStyle(
                      color: Color.fromRGBO(1, 1, 2, 1),
                      fontWeight: FontWeight.w500,
                      fontSize: 16),
                ),
                SizedBox(height: 10),
                Text(
                  'You contributed 32.8% of group capital',
                  style: TextStyle(
                      color: Color.fromRGBO(1, 1, 2, 1),
                      fontWeight: FontWeight.w500,
                      fontSize: 16),
                ),
              ],
            )),
        Padding(
          padding: const EdgeInsets.all(15),
          child: Container(
            width: double.infinity,
            height: 60,
            decoration: BoxDecoration(
              color: Color.fromRGBO(33, 17, 71, 1),
              borderRadius: BorderRadius.circular(25),
              border:
                  Border.all(width: 2, color: Color.fromRGBO(33, 17, 71, 1)),
            ),
            child: TextButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (_, __, ___) => LaunchPage(),
                        transitionDuration: Duration(seconds: 1),
                        transitionsBuilder: (_, a, __, c) =>
                            FadeTransition(opacity: a, child: c),
                      ),
                      (route) => false);
                },
                child: Text(
                  'Done',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                )),
          ),
        )
      ]),
    ));
  }
}
