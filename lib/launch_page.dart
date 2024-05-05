import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:pinnaclefx/Models/reuseable_widgets.dart';
import 'package:pinnaclefx/bottomNavPages/home_page.dart';
import 'package:pinnaclefx/bottomNavPages/invest.dart';
import 'package:pinnaclefx/bottomNavPages/learn.dart';
import 'package:pinnaclefx/bottomNavPages/me.dart';
import 'package:pinnaclefx/models/skeleton.dart';
import 'package:pinnaclefx/utils/api_endpoints.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LaunchPage extends StatefulWidget {
  const LaunchPage({super.key});

  @override
  State<LaunchPage> createState() => _LaunchPageState();
}

class _LaunchPageState extends State<LaunchPage> {
  int selectedIndex = 0;

  void changeSelectedIndex(int pageNumber) {
    setState(() {
      selectedIndex = pageNumber;
    });
  }

  Future<Map<String, dynamic>> fetchData() async {
    final pref = await SharedPreferences.getInstance();
    final token = pref.getString('token') ?? '';

    var headers = {'x-access-token': token};

    var url = Uri.parse(
        ApiEndpoints.baseUrl + ApiEndpoints.accountEndPoints.userData);

    http.Response response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print('Account data: $data');
      return data;
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Map<String, dynamic>>(
        stream: fetchData().asStream(),
        builder: (context, snapshot) {

          if (snapshot.hasData)  {
            final data = snapshot.data!;
            final firstName = data['firstName'];
            final lastName = data['lastName'];
            final email = data['email'];
            final phoneNumber = data['phoneNumber'];
            final balance = data['balance'];
            final asset = data['asset'];
            final interest = data['interest'];
            final linkedAccountID = data['linkedAccounts'][0];

            List bottomNavPages = [
              HomePage(firstName: firstName,
              balance: balance,
              linkedAccountID: linkedAccountID),
              LearnPage(firstName: firstName), 
              InvestPage(
                balance: balance,
              asset: asset,
              interest: interest,
              ), 
              MePage(firstName: firstName,
              lastName: lastName,
              email: email,
              phoneNumber: phoneNumber,
              balance: balance,
              asset: asset,
              interest: interest,)];

            return Scaffold(
              bottomNavigationBar: Container(
                decoration: BoxDecoration(
                  border: Border(top: BorderSide(width: 1, color: Color.fromRGBO(115, 3, 217, 1)))
                ),
                child: BottomNavigationBar(
                  items: [
                    BottomNavigationBarItem(
                        icon: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: selectedIndex == 0
                                  ? Color.fromRGBO(115, 3, 217, 1)
                                  : null),
                          padding: EdgeInsets.fromLTRB(7, 5, 7, 5),
                          child: Image.asset(
                            'asset/images/home.png',
                            filterQuality: FilterQuality.medium,
                            color: selectedIndex == 0 ? Colors.white : null,
                            height: 20.sp,
                          ),
                        ),
                        label: 'Home'),
                    BottomNavigationBarItem(
                        icon: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: selectedIndex == 1
                                  ? Color.fromRGBO(115, 3, 217, 1)
                                  : null),
                          padding: EdgeInsets.fromLTRB(7, 5, 7, 5),
                          child: Image.asset(
                            'asset/images/learn.png',
                            filterQuality: FilterQuality.medium,
                            color: selectedIndex == 1 ? Colors.white : null,
                            height: 20.sp,
                          ),
                        ),
                        label: 'Learn'),
                    BottomNavigationBarItem(
                        icon: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: selectedIndex == 2
                                  ? Color.fromRGBO(115, 3, 217, 1)
                                  : null),
                          padding: EdgeInsets.fromLTRB(7, 5, 7, 5),
                          child: Image.asset(
                            'asset/images/invest.png',
                            filterQuality: FilterQuality.medium,
                            color: selectedIndex == 2 ? Colors.white : null,
                            height: 20.sp,
                          ),
                        ),
                        label: 'Invest'),
                    BottomNavigationBarItem(
                        icon: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: selectedIndex == 3
                                  ? Color.fromRGBO(115, 3, 217, 1)
                                  : null),
                          padding: EdgeInsets.fromLTRB(7, 5, 7, 5),
                          child: Image.asset(
                            'asset/images/me.png',
                            filterQuality: FilterQuality.medium,
                            color: selectedIndex == 3 ? Colors.white : null,
                            height: 20.sp,
                          ),
                        ),
                        label: 'Me')
                  ],
                  currentIndex: selectedIndex,
                  unselectedItemColor: Color.fromRGBO(33, 17, 71, 1),
                  selectedItemColor: Color.fromRGBO(33, 17, 71, 1),
                  showUnselectedLabels: true,
                  onTap: (value) {
                    changeSelectedIndex(value);
                  },
                  selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              body: Center(
                child: bottomNavPages.elementAt(selectedIndex),
              ),
            );
          } 
          else {
            return Scaffold(
              bottomNavigationBar: Container(
                decoration: BoxDecoration(
                  border: Border(top: BorderSide(width: 1, color: Color.fromRGBO(115, 3, 217, 1)))
                ),
                child: BottomNavigationBar(
                  items: [
                    BottomNavigationBarItem(
                        icon: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color:
                                   Color.fromRGBO(115, 3, 217, 1)
                                  ),
                          padding: EdgeInsets.fromLTRB(7, 5, 7, 5),
                          child: Image.asset(
                            'asset/images/home.png',
                            filterQuality: FilterQuality.medium,
                            color: Colors.white,
                            height: 20.sp,
                          ),
                        ),
                        label: 'Home',
                        ),
                    BottomNavigationBarItem(
                        icon: Container(
                          padding: EdgeInsets.fromLTRB(7, 5, 7, 5),
                          child: Image.asset(
                            'asset/images/learn.png',
                            filterQuality: FilterQuality.medium,
                            height: 20.sp,
                          ),
                        ),
                        label: 'Learn'),
                    BottomNavigationBarItem(
                        icon: Container(
                          padding: EdgeInsets.fromLTRB(7, 5, 7, 5),
                          child: Image.asset(
                            'asset/images/invest.png',
                            filterQuality: FilterQuality.medium,
                            height: 20.sp,
                          ),
                        ),
                        label: 'Invest'),
                    BottomNavigationBarItem(
                        icon: Container(
                          padding: EdgeInsets.fromLTRB(7, 5, 7, 5),
                          child: Image.asset(
                            'asset/images/me.png',
                            filterQuality: FilterQuality.medium,
                            height: 20.sp,
                          ),
                        ),
                        label: 'Me')
                  ],
                  currentIndex: selectedIndex,
                  unselectedItemColor: Color.fromRGBO(33, 17, 71, 1),
                  selectedItemColor: Color.fromRGBO(33, 17, 71, 1),
                  showUnselectedLabels: true,
                  selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              body: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.separated(
                  itemCount: 6,
                  itemBuilder: (context, index) => const NewsCardSkelton(),
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: defaultPadding),
                                ),
                ),
              ),
            );
          }
        });
  }
}
