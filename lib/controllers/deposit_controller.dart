import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pinnaclefx/investmentPages/tradeForYou/trade_for_you_success.dart';
import 'package:pinnaclefx/launch_page.dart';
import 'package:pinnaclefx/models/reuseable_widgets.dart';
import 'package:pinnaclefx/services/local_notifications_service.dart';
import 'package:pinnaclefx/utils/api_endpoints.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DepositController extends GetxController {
  TextEditingController amountController = TextEditingController();

  deposit(String accountID) async {
    try {
      final pref = await SharedPreferences.getInstance();
      final token = pref.getString('token') ?? '';

      var headers = {
        'x-access-token': token,
        "Accept": "application/json",
        "content-type": "application/json"
      };
      var url = Uri.parse(
          ApiEndpoints.baseUrl + ApiEndpoints.accountEndPoints.deposit);

      Map body = {
        'amount': amountController.text,
        'linkedAccountId': accountID
      };

      showDialog(
          barrierDismissible: false,
          barrierColor: Colors.transparent,
          context: Get.context!,
          builder: (context) {
            return Center(
              child: CircularProgressIndicator(),
            );
          });

      http.Response response =
          await http.post(url, body: jsonEncode(body), headers: headers);

      if (response.statusCode == 200) {
        print('DEPOSIT RESPONSE: ${response.body}');
        
        Get.back();
        showDialog(
            context: Get.context!,
            builder: (context) {
              return Dialog(
                child: Container(
                  height: 150,
                  padding: EdgeInsets.all(15),
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Image.asset('asset/images/checkbox.png', height: 70),
                      Text('Deposit Successul!')
                    ],
                  ),
                ),
              );
            });
        await Future.delayed(Duration(seconds: 2));
        NotificationService().showNotification(
            id: 1,
            title: 'Deposit successful',
            body:
                'You have successfully deposited \$${amountController.text.replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}. You can now trade and enjoy great returns');
        Navigator.pushAndRemoveUntil(
            Get.context!,
            PageRouteBuilder(
              pageBuilder: (_, __, ___) => LaunchPage(),
              transitionDuration: Duration(seconds: 2),
              transitionsBuilder: (_, a, __, c) =>
                  FadeTransition(opacity: a, child: c),
            ),
            (route) => false);
      } else {
        print('RESPONSE: ${response.body}');
        throw jsonDecode(response.body)['message'] ??
            'error code: ${response.statusCode}';
      }
    } catch (e) {
      Get.back();
      showDialog(
          context: Get.context!,
          builder: (context) {
            return Dialog(
              child: Container(
                height: 150,
                padding: EdgeInsets.all(15),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(Icons.warning_amber_rounded,
                        color: Colors.red, size: 42),
                    Text(
                      e.toString().contains('ClientException')
                          ? 'No internet connection'
                          : e.toString(),
                      style: normalTextStyle,
                    )
                  ],
                ),
              ),
            );
          });
    }
  }
}
