import 'dart:convert';

import 'package:floating_snackbar/floating_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pinnaclefx/models/custom_snackbar.dart';
import 'package:pinnaclefx/screens/authentication/forgot_password_code_confirm.dart';
import 'package:pinnaclefx/services/local_notifications_service.dart';
import 'package:pinnaclefx/utils/api_endpoints.dart';

class ForgotPasswordController extends GetxController {
  TextEditingController emailController = TextEditingController();

  forgotPassword() async {
    try {
      var headers = {'content-Type': 'application/json'};
      var url = Uri.parse(
          ApiEndpoints.baseUrl + ApiEndpoints.authEndPoints.forgotPassword);

      Map body = {
        'email': emailController.text.trim(),
      };

      showDialog(
          barrierDismissible: false,
          context: Get.context!,
          builder: (context) {
            return Center(
              child: CircularProgressIndicator(),
            );
          });

      http.Response response =
          await http.post(url, body: jsonEncode(body), headers: headers);

      if (response.statusCode == 200) {
        print('Response ${response.body}');
        Get.back();

        Navigator.push(Get.context!,
            MaterialPageRoute(builder: (_) => ForgotPasswordCodeConfirmPage()));

        showSnackBarFunTwoLines(
  context: Get.context!, 
  text: 'Please check your mailbox a verification code has been sent',
  time: 4,
  color: Colors.black);

        
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
                        ? 'No internet connection'
                        : e.toString())
                  ],
                ),
              ),
            );
          });
    }
  }
}
