import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pinnaclefx/investmentPages/tradeForYou/trade_for_you_success.dart';
import 'package:pinnaclefx/models/reuseable_widgets.dart';
import 'package:pinnaclefx/services/local_notifications_service.dart';
import 'package:pinnaclefx/utils/api_endpoints.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InvestmentController extends GetxController {
  TextEditingController capitalAmountController = TextEditingController();

  tradeForYouInvestment(int duration) async {
    try {
      final pref = await SharedPreferences.getInstance();
      final token = pref.getString('token') ?? '';

      var headers = {
        'x-access-token': token,
        "Accept": "application/json",
        "content-type": "application/json"
      };
      var url = Uri.parse(
          ApiEndpoints.baseUrl + ApiEndpoints.accountEndPoints.invest);

      Map body = {'amount': capitalAmountController.text, 'duration': duration};

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
        print('RESPONSE: ${response.body}');
        Get.back();
        Navigator.push(
            Get.context!,
            MaterialPageRoute(
                builder: (_) => TradeForYouSuccess(
                      amount: int.parse(capitalAmountController.text),
                    )));
        NotificationService().showNotification(
            id: 1,
            title: 'Hurray!',
            body:
                'You have successfully placed a trade of \$${capitalAmountController.text.replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}. Investment will mature after $duration days');
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
