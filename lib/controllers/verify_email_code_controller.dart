import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pinnaclefx/screens/authentication/change_password.dart';
import 'package:pinnaclefx/utils/api_endpoints.dart';

class VerifyEmailCodeController extends GetxController {
  verifyCode(int code) async {
    try {
      var headers = {'content-Type': 'application/json'};
      var url = Uri.parse(
          ApiEndpoints.baseUrl + ApiEndpoints.authEndPoints.verifyCode);

      Map body = {
        'code': code,
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
        final json = jsonDecode(response.body);
        final resetEndpointUrl = json['resetEndpoint'].toString();

        print('Response ${response.body}');
        Get.back();
        Navigator.push(
            Get.context!,
            MaterialPageRoute(
                builder: (_) =>
                    ChangePasswordPage(resetApiUrl: resetEndpointUrl)));
        
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
