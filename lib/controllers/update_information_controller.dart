import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pinnaclefx/launch_page.dart';
import 'package:pinnaclefx/utils/api_endpoints.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdateInformationController extends GetxController {
  updateAccountInformation(String email, String name, String phone) async {
    try {
      final pref = await SharedPreferences.getInstance();
      final token = pref.getString('token') ?? '';

      var headers = {
        'x-access-token': token,
        "Accept": "application/json",
        "content-type": "application/json"
        };
      var url = Uri.parse(
          ApiEndpoints.baseUrl + ApiEndpoints.accountEndPoints.update);

      Map body = {
        'email': email.trim(),
        'firstName': name.split(' ')[0],
        'lastName': name.split(' ')[1],
        'phoneNumber': phone
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
          await http.put(url, body: jsonEncode(body), headers: headers);

      if (response.statusCode == 200) {
        final prefs = await SharedPreferences.getInstance();
        prefs.setString('email', email.trim());
        prefs.setString('firstName', name.split(' ')[0]);
        Get.back();

        showDialog(
            barrierDismissible: false,
            context: Get.context!,
            builder: (context) {
              return Material(
                color: Colors.transparent,
                child: Container(
                  height: 200,
                  width: double.infinity,
                  child: Center(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('asset/images/checkbox.png',
                                  height: 100.h)
                              .animate(
                                  onPlay: (controller) => controller.repeat())
                              .fadeOut(duration: Duration(milliseconds: 3200)),
                          Text('Account information updated successfully',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                  fontSize: 18.sp))
                        ]),
                  ),
                ),
              );
            });
        await Future.delayed(Duration(seconds: 3));

        Navigator.pushAndRemoveUntil(Get.context!,
            MaterialPageRoute(builder: (_) => LaunchPage()),
            ((route) => false));

        Get.back();
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
