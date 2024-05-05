import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pinnaclefx/controllers/login_controller.dart';
import 'package:pinnaclefx/screens/Authentication/register_page.dart';
import 'package:pinnaclefx/screens/authentication/forgot_password.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final textFieldFocusNode = FocusNode();
  bool _obscured = true;
  LoginController loginController = Get.put(LoginController());

  void _toggleObscured() {
    setState(() {
      _obscured = !_obscured;
      if (textFieldFocusNode.hasPrimaryFocus) {
        return; // If focus is on text field, dont unfocus
      }
      textFieldFocusNode.canRequestFocus =
          false; // Prevents focus if tap on eye
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
            children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                'Login',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 40.sp),
              ),
              Text('Securely Login to your PinnFX', style: TextStyle(fontWeight: FontWeight.w600),),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.035,
              ),
              Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Email Address'),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.015,
                      ),
                      TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          keyboardType: TextInputType.emailAddress,
                          controller: loginController.emailController,
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(),
                          )),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.015,
                      ),
                      Text('Password'),
                      TextFormField(
                        focusNode: textFieldFocusNode,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.visiblePassword,
                        controller: loginController.passwordController,
                        decoration: InputDecoration(
                          border: UnderlineInputBorder(),
                          suffixIcon: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                            child: GestureDetector(
                              onTap: _toggleObscured,
                              child: Icon(
                                _obscured
                                    ? Icons.visibility_rounded
                                    : Icons.visibility_off_rounded,
                                size: 24,
                              ),
                            ),
                          ),
                        ),
                        obscureText: _obscured,
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
                        color:
                            loginController.emailController.text.isNotEmpty &&
                                    loginController
                                        .passwordController.text.isNotEmpty
                                ? Color.fromRGBO(33, 17, 71, 1)
                                : Colors.grey),
                    child: TextButton(
                        onPressed:
                            loginController.emailController.text.isNotEmpty &&
                                    loginController
                                        .passwordController.text.isNotEmpty
                                ? () {
                                    loginController.loginWithEmail();
                                  }
                                : null,
                        child: Text(
                          'Login',
                          style: TextStyle(color: Colors.white),
                        )),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Don\'t have an account?'),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const SignupPage()));
                          },
                          child: Text(
                            'Register',
                            style: TextStyle(
                                color: Color.fromRGBO(115, 3, 217, 1)),
                          ))
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  TextButton(
                      onPressed: () {

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const ForgotPasswordPage()));
                      },
                      child: Text(
                        'Forgot Password',
                      )),
                ],
              ),
                  ],
                ),
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}
