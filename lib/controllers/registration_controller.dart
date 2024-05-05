import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pinnaclefx/screens/authentication/login_page.dart';
import 'package:pinnaclefx/services/local_notifications_service.dart';
import 'package:pinnaclefx/utils/api_endpoints.dart';
import 'package:http/http.dart' as http;

class RegistrationController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  registerWithEmail() async {
    try {
      var headers = {'content-Type': 'application/json'};
      var url =
          Uri.parse(ApiEndpoints.baseUrl + ApiEndpoints.authEndPoints.register);

      Map body = {
        'firstName': nameController.text.split(' ')[0],
        'lastName': nameController.text.split(' ')[1],
        'email': emailController.text.trim(),
        'password': passwordController.text,
        'phoneNumber': phoneNumberController.text
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

      print("response: ${response.body}");

      if (response.statusCode == 201) {
        final json = jsonDecode(response.body);
        print('$json');
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
                              .animate()
                              .fadeOut(duration: Duration(milliseconds: 3500))
                              .swap(
                                  builder: (_, child) => Image.asset(
                                          'asset/images/thumbsup.png',
                                          height: 100.h,
                                          color:
                                              Color.fromRGBO(179, 93, 253, 1))
                                      .animate()
                                      .fadeIn(duration: Duration(milliseconds: 3600))),
                          Text(
                              'Account created successfully. Please wait while we redirect you to the login page...',
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

        await Future.delayed(Duration(seconds: 7));

        nameController.clear();
        passwordController.clear();
        confirmPasswordController.clear();
        phoneNumberController.clear();
        emailController.clear();

        NotificationService().showNotification(
            id: 108,
            title: 'Welcome ${nameController.text.split(' ')[0]}!',
            body:
                'Your account has been successfully created. Please proceed to login');

        Navigator.pushAndRemoveUntil(
            Get.context!,
            MaterialPageRoute(builder: (_) => const LoginPage()),
            (route) => false);
        
      } else {
        throw jsonDecode(response.body)['message'] ??
            'error code: ${response.statusCode}';
      }
    } catch (e) {
      Get.back();
      showDialog(
          barrierColor: Colors.transparent,
          context: Get.context!,
          builder: (context) {
            return Dialog(
              child: Container(
                padding: EdgeInsets.all(15),
                height: 150,
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
