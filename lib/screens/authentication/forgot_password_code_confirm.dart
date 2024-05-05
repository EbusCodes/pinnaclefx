// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pinnaclefx/controllers/verify_email_code_controller.dart';
import 'package:pinnaclefx/models/modal_classes.dart';
import 'package:pinnaclefx/models/reuseable_widgets.dart';

class ForgotPasswordCodeConfirmPage extends StatefulWidget {
  ForgotPasswordCodeConfirmPage({super.key});

  @override
  State<ForgotPasswordCodeConfirmPage> createState() =>
      _ForgotPasswordCodeConfirmPageState();
}

class _ForgotPasswordCodeConfirmPageState
    extends State<ForgotPasswordCodeConfirmPage> {
  List<String> currentPin = ['', '', '', '', '', ''];
  TextEditingController pinOneController = TextEditingController();
  TextEditingController pinTwoController = TextEditingController();
  TextEditingController pinThreeController = TextEditingController();
  TextEditingController pinFourController = TextEditingController();
  TextEditingController pinFiveController = TextEditingController();
  TextEditingController pinSixController = TextEditingController();
  VerifyEmailCodeController verifyEmailCodeController =
      Get.put(VerifyEmailCodeController());

  var outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: Colors.transparent));

  int pinIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            customPageAppBar(context, ''),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text('Verify email address',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25.sp)),
                    Text(
                      'Enter the 6 digit code sent to your email address. The code expires in 15 minutes',
                      textAlign: TextAlign.center,
                    ),
                    Container(
                      height: 100,
                      child: buildPinRow(),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Didn\'t receive any code?'),
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              "Try again",
                            )),
                      ],
                    ),
                    buildNumberPad()
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  buildNumberPad() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      child: Padding(
        padding: EdgeInsets.only(bottom: 1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                KeyboardNumber(
                  n: 1,
                  onPressed: () {
                    pinIndexSetup('1');
                  },
                ),
                KeyboardNumber(
                  n: 2,
                  onPressed: () {
                    pinIndexSetup('2');
                  },
                ),
                KeyboardNumber(
                  n: 3,
                  onPressed: () {
                    pinIndexSetup('3');
                  },
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                KeyboardNumber(
                  n: 4,
                  onPressed: () {
                    pinIndexSetup('4');
                  },
                ),
                KeyboardNumber(
                  n: 5,
                  onPressed: () {
                    pinIndexSetup('5');
                  },
                ),
                KeyboardNumber(
                  n: 6,
                  onPressed: () {
                    pinIndexSetup('6');
                  },
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                KeyboardNumber(
                  n: 7,
                  onPressed: () {
                    pinIndexSetup('7');
                  },
                ),
                KeyboardNumber(
                  n: 8,
                  onPressed: () {
                    pinIndexSetup('8');
                  },
                ),
                KeyboardNumber(
                  n: 9,
                  onPressed: () {
                    pinIndexSetup('9');
                  },
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 60,
                  child: MaterialButton(
                    onPressed: () {},
                    child: Icon(
                      Icons.abc_rounded,
                      color: Color.fromRGBO(33, 17, 71, 1),
                      size: 28,
                    ),
                  ),
                ),
                KeyboardNumber(
                  n: 0,
                  onPressed: () {
                    pinIndexSetup('0');
                  },
                ),
                Container(
                  width: 60,
                  child: MaterialButton(
                    height: 60,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(60)),
                    onPressed: () {
                      clearPin();
                    },
                    child: Icon(
                      Icons.close,
                      color: Color.fromRGBO(33, 17, 71, 1),
                      size: 28,
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  clearPin() {
    if (pinIndex == 0)
      pinIndex = 0;
    else if (pinIndex == 6) {
      setPin(pinIndex, '');
      currentPin[pinIndex - 1] = '';
      pinIndex--;
    } else {
      setPin(pinIndex, '');
      currentPin[pinIndex - 1] = '';
      pinIndex--;
    }
  }

  pinIndexSetup(String text) {
    if (pinIndex == 0)
      pinIndex = 1;
    else if (pinIndex < 6) pinIndex++;
    setPin(pinIndex, text);
    currentPin[pinIndex - 1] = text;
    String strPin = '';
    currentPin.forEach((element) {
      strPin += element;
    });

    if (pinIndex == 6) {
      verifyEmailCodeController.verifyCode(int.parse(strPin));
      print('Code: $strPin');
    }
  }

  setPin(int n, String text) {
    switch (n) {
      case 1:
        pinOneController.text = text;
        break;
      case 2:
        pinTwoController.text = text;
        break;
      case 3:
        pinThreeController.text = text;
        break;
      case 4:
        pinFourController.text = text;
        break;
      case 5:
        pinFiveController.text = text;
        break;
      case 6:
        pinSixController.text = text;
        break;
    }
  }

  buildPinRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        PINNumber(
            outlineInputBorder: outlineInputBorder,
            textEditingController: pinOneController),
        PINNumber(
            outlineInputBorder: outlineInputBorder,
            textEditingController: pinTwoController),
        PINNumber(
            outlineInputBorder: outlineInputBorder,
            textEditingController: pinThreeController),
        PINNumber(
            outlineInputBorder: outlineInputBorder,
            textEditingController: pinFourController),
        PINNumber(
            outlineInputBorder: outlineInputBorder,
            textEditingController: pinFiveController),
        PINNumber(
            outlineInputBorder: outlineInputBorder,
            textEditingController: pinSixController),
      ],
    );
  }
}

class PINNumber extends StatelessWidget {
  final TextEditingController textEditingController;
  final OutlineInputBorder outlineInputBorder;
  PINNumber(
      {required this.textEditingController, required this.outlineInputBorder});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(),
      child: TextFormField(
        controller: textEditingController,
        enabled: false,
        obscureText: true,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20, 0, 0, -55),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 30.sp, color: Colors.black),
      ),
    );
  }
}

// ignore: must_be_immutable

