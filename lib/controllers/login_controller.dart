import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pinnaclefx/launch_page.dart';
import 'package:pinnaclefx/utils/api_endpoints.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  loginWithEmail() async {
    try {
      var headers = {'content-Type': 'application/json'};
      var url =
          Uri.parse(ApiEndpoints.baseUrl + ApiEndpoints.authEndPoints.login);

      Map body = {
        'email': emailController.text.trim(),
        'password': passwordController.text
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
        final json = jsonDecode(response.body);
        var token = json['account']['token'].toString();
        var firstName = json['account']['firstName'].toString();

        final SharedPreferences prefs = await _prefs;
        await prefs.setString('token', token);
        await prefs.setString('firstName', firstName);
        await prefs.setString('email', emailController.text.trim());

        Get.back();
        passwordController.clear();
        emailController.clear();
        
        showDialog(
            barrierDismissible: false,
            barrierColor: Colors.white,
            context: Get.context!,
            builder: (context) {
              return Center(
                child: Image.asset('asset/images/checkbox.png', height: 150.h)
              );
            });

        await Future.delayed(Duration(seconds: 2));

        Navigator.pushAndRemoveUntil(
        Get.context!,
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => LaunchPage(),
            transitionDuration: Duration(milliseconds: 1500),
            transitionsBuilder: (_, a, __, c) =>
            FadeTransition(opacity: a, child: c),
                        ),
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
                        ? 'No internet connection'
                        : e.toString())
                  ],
                ),
              ),
            );
          });
    }
  }

  loginWithEmailReturningUser(String email) async {
    try {
      var headers = {'content-Type': 'application/json'};
      var url =
          Uri.parse(ApiEndpoints.baseUrl + ApiEndpoints.authEndPoints.login);

      Map body = {'email': email.trim(), 'password': passwordController.text};

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
        final json = jsonDecode(response.body);
        var token = json['account']['token'].toString();
        var firstName = json['account']['firstName'].toString();

        final SharedPreferences prefs = await _prefs;
        await prefs.setString('token', token);
        await prefs.setString('firstName', firstName);
        await prefs.remove('loggedout');
        await prefs.setString('email', email.trim());

        Get.back();
        passwordController.clear();
        showDialog(
            barrierDismissible: false,
            barrierColor: Colors.white,
            context: Get.context!,
            builder: (context) {
              return Center(
                child: Image.asset('asset/images/checkbox.png', height: 150.h)
              );
            });
        await Future.delayed(Duration(seconds: 2));

        Navigator.pushAndRemoveUntil(
            Get.context!,
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => LaunchPage(),
            transitionDuration: Duration(milliseconds: 1500),
            transitionsBuilder: (_, a, __, c) =>
            FadeTransition(opacity: a, child: c)),
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
