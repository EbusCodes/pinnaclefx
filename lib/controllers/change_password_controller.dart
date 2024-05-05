import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pinnaclefx/launch_page.dart';

class ChangePasswordController extends GetxController {
  TextEditingController newPasswordController = TextEditingController();

  changePassword(String resetApiUrl) async {
    try {
      var headers = {"content-type": "application/json"};
      print('URL: $resetApiUrl');
      var url = Uri.parse('https://${resetApiUrl.substring(7)}');

      Map body = {
        'password': newPasswordController.text.trimLeft(),
      };
      print('LINK $url');

      print('Password: ${newPasswordController.text}');

      showDialog(
          barrierDismissible: false,
          context: Get.context!,
          builder: (context) {
            return Center(
              child: CircularProgressIndicator(),
            );
          });

      http.Response response = await http.patch(url, body: jsonEncode(body), headers: headers);
      print('RESPONSE ${response.body}');

      if (response.statusCode == 200) {
        print('Response ${response.body}');
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
                      Text(
                          'Password changed successfully. You can now login with your new details')
                    ],
                  ),
                ),
              );
            });

        await Future.delayed(Duration(seconds: 3));

        Navigator.pushAndRemoveUntil(
            Get.context!,
            MaterialPageRoute(builder: (_) => const LaunchPage()),
            (route) => false);
      } else {
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
                    Text(e.toString().contains('ClientException')
                        ? 'No internet connection.Check your connection and try again'
                        : e.toString())
                  ],
                ),
              ),
            );
          });
    }
  }
}
