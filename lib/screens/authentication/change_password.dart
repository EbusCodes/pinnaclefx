// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pinnaclefx/controllers/change_password_controller.dart';
import 'package:pinnaclefx/models/reuseable_widgets.dart';

class ChangePasswordPage extends StatefulWidget {
  String resetApiUrl;
  ChangePasswordPage({super.key, required this.resetApiUrl});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _formKey = GlobalKey<FormState>();
  // TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  ChangePasswordController changePasswordContoller =
      Get.put(ChangePasswordController());

  final passwordFieldFocusNode = FocusNode();
  bool _passwordObscured = true;

  final confirmPasswordFieldFocusNode = FocusNode();
  bool _confirmPasswordbscured = true;

  bool _isPasswordEightCharacters = false;
  bool _isPasswordContainUppercase = false;
  bool _isPasswordContainSpecialCharacter = false;
  bool _isPasswordContainDigit = false;
  bool _showPasswordValidator = false;
  bool _showPasswordCheck = false;

  void _togglePasswordObscured() {
    setState(() {
      _passwordObscured = !_passwordObscured;
      if (passwordFieldFocusNode.hasPrimaryFocus) {
        return; // If focus is on text field, dont unfocus
      }
      passwordFieldFocusNode.canRequestFocus =
          false; // Prevents focus if tap on eye
    });
  }

  void _toggleConfirmPasswordObscured() {
    setState(() {
      _confirmPasswordbscured = !_confirmPasswordbscured;
      if (confirmPasswordFieldFocusNode.hasPrimaryFocus) {
        return; // If focus is on text field, dont unfocus
      }
      confirmPasswordFieldFocusNode.canRequestFocus =
          false; // Prevents focus if tap on eye
    });
  }

  void onPasswordChanged(String password) {
    final numericRegex = RegExp(r'[0-9]');
    final uppercaseRegex = RegExp(r'[A-Z]');
    final specialCharRegex = RegExp(r'[!@#\$&*_~]');

    setState(() {
      // checks for conditions and rebuilds UI as user inputs password
      _showPasswordValidator = password.isNotEmpty;
      _showPasswordCheck = false;

      _isPasswordEightCharacters = false;
      if (password.length >= 8) _isPasswordEightCharacters = true;

      _isPasswordContainDigit = false;
      if (numericRegex.hasMatch(password)) _isPasswordContainDigit = true;

      _isPasswordContainUppercase = false;
      if (uppercaseRegex.hasMatch(password)) _isPasswordContainUppercase = true;

      _isPasswordContainSpecialCharacter = false;
      if (specialCharRegex.hasMatch(password))
        _isPasswordContainSpecialCharacter = true;

      if (_isPasswordContainDigit == true &&
          _isPasswordEightCharacters == true &&
          _isPasswordContainUppercase == true &&
          _isPasswordContainSpecialCharacter == true) {
        _showPasswordValidator = false;
        _showPasswordCheck = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Change Password',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 32.sp),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.035,
              ),
              Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Password'),
                      TextFormField(
                        focusNode: passwordFieldFocusNode,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.visiblePassword,
                        controller:
                            changePasswordContoller.newPasswordController,
                        decoration: InputDecoration(
                            border: UnderlineInputBorder(),
                            suffixIcon: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                              child: GestureDetector(
                                onTap: _togglePasswordObscured,
                                child: Icon(
                                  _passwordObscured
                                      ? Icons.visibility_rounded
                                      : Icons.visibility_off_rounded,
                                  size: 24,
                                ),
                              ),
                            ),
                            prefixIcon: Visibility(
                                visible: _showPasswordCheck,
                                child: Icon(Icons.check))),
                        obscureText: _passwordObscured,
                        onChanged: (password) => onPasswordChanged(password),
                      ),

                      passwordValidatorCheck(_showPasswordValidator, _isPasswordEightCharacters, _isPasswordContainDigit, _isPasswordContainSpecialCharacter, _isPasswordContainUppercase),
                      
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.015,
                      ),
                      Text('Confrim Password'),
                      TextFormField(
                        validator: (value) {
                          if (value !=
                              changePasswordContoller
                                  .newPasswordController.text) {
                            return 'Password mismatch';
                          }
                          return null;
                        },
                        focusNode: confirmPasswordFieldFocusNode,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.visiblePassword,
                        controller: confirmPasswordController,
                        decoration: InputDecoration(
                          border: UnderlineInputBorder(),
                          suffixIcon: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                            child: GestureDetector(
                              onTap: _toggleConfirmPasswordObscured,
                              child: Icon(
                                _confirmPasswordbscured
                                    ? Icons.visibility_rounded
                                    : Icons.visibility_off_rounded,
                                size: 24,
                              ),
                            ),
                          ),
                        ),
                        obscureText: _confirmPasswordbscured,
                      ),
                    ],
                  )),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.04,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 60,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: changePasswordContoller
                                    .newPasswordController.text.isNotEmpty &&
                                confirmPasswordController.text.isNotEmpty
                            ? Color.fromRGBO(33, 17, 71, 1)
                            : Colors.grey),
                    child: TextButton(
                        onPressed: changePasswordContoller
                                    .newPasswordController.text.isNotEmpty &&
                                confirmPasswordController.text.isNotEmpty
                            ? () {
                                changePasswordContoller
                                    .changePassword(widget.resetApiUrl);
                              }
                            : null,
                        child: Text(
                          'Change Password',
                          style: TextStyle(color: Colors.white),
                        )),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
