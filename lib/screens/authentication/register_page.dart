import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:pinnaclefx/controllers/registration_controller.dart';
import 'package:pinnaclefx/models/reuseable_widgets.dart';
import 'package:pinnaclefx/screens/Authentication/login_page.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();

  final passwordFieldFocusNode = FocusNode();
  bool _passwordObscured = true;

  final confirmPasswordFieldFocusNode = FocusNode();
  bool _confirmPasswordbscured = true;

  RegistrationController registrationController =
      Get.put(RegistrationController());

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
        child: SingleChildScrollView (
          child: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Register',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 40.sp),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.002,
                ),
                Text('Create a PinFX account', style: TextStyle(fontWeight: FontWeight.w600)),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.035,
                ),
                Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Full Name'),
                        TextFormField(
                          validator: (value) {
                            if (value!.contains(RegExp(r'^\w+\s\w+$')) == false) {
                              return 'First and Last names required';
                            }
          
                            return null;
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          keyboardType: TextInputType.text,
                          controller: registrationController.nameController,
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.015,
                        ),
                        Text('Email'),
                        TextFormField(
                            validator: (value) {
                              if (value!.isEmail == false) {
                                return 'Please enter a valid email address';
                              }
          
                              return null;
                            },
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            keyboardType: TextInputType.emailAddress,
                            controller: registrationController.emailController,
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(),
                            )),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.015,
                        ),
                        Text('Phone Number'),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.015,
                        ),
                        IntlPhoneField(
                          decoration: const InputDecoration(
                              enabledBorder: UnderlineInputBorder()),
                          initialCountryCode: 'NG',
                          onChanged: (phone) {
                            registrationController.phoneNumberController.text =
                                phone.completeNumber;
                          },
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.015,
                        ),
                        Text('Password'),
                        TextFormField(
                          focusNode: passwordFieldFocusNode,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          keyboardType: TextInputType.visiblePassword,
                          controller: registrationController.passwordController,
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
                                registrationController.passwordController.text) {
                              return 'Password mismatch';
                            }
                            return null;
                          },
                          focusNode: confirmPasswordFieldFocusNode,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          keyboardType: TextInputType.visiblePassword,
                          controller:
                              registrationController.confirmPasswordController,
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
                  children: [
                    Container(
                      height: 60,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: (_showPasswordValidator == false &&
                                  registrationController
                                      .passwordController.text.isNotEmpty &&
                                  registrationController.nameController.text
                                      .contains(RegExp(r'^\w+\s\w+$')) &&
                                  registrationController
                                      .nameController.text.isNotEmpty &&
                                  registrationController
                                          .confirmPasswordController.text ==
                                      registrationController
                                          .passwordController.text &&
                                  registrationController
                                          .phoneNumberController.text.length >=
                                      14 &&
                                  registrationController
                                      .emailController.text.isEmail)
                              ? Color.fromRGBO(33, 17, 71, 1)
                              : Colors.grey),
                      child: TextButton(
                          onPressed: (_showPasswordValidator == false &&
                                  registrationController
                                      .passwordController.text.isNotEmpty &&
                                  registrationController
                                      .nameController.text.isNotEmpty &&
                                  registrationController.nameController.text
                                      .contains(RegExp(r'^\w+\s\w+$')) &&
                                  registrationController
                                          .confirmPasswordController.text ==
                                      registrationController
                                          .passwordController.text &&
                                  registrationController
                                          .phoneNumberController.text.length >=
                                      14 &&
                                  registrationController
                                      .emailController.text.isEmail)
                              ? () {
                                  
                                  registrationController.registerWithEmail();
                                }
                              : null,
                          child: Text(
                            'Register',
                            style: TextStyle(color: Colors.white),
                          )),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Already have an account?'),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => const LoginPage()));
                            },
                            child: Text(
                              'Login',
                              style: TextStyle(
                                  color: Color.fromRGBO(115, 3, 217, 1)),
                            ))
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
