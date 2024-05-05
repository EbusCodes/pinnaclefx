import 'package:flutter/material.dart';
import 'package:pinnaclefx/controllers/login_controller.dart';
import 'package:pinnaclefx/models/reuseable_widgets.dart' as reuseable;
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'package:pinnaclefx/launch_page.dart';
import 'package:pinnaclefx/screens/authentication/forgot_password.dart';
import 'package:pinnaclefx/screens/splashScreen/spalsh_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReturningUserLoginPage extends StatefulWidget {
  const ReturningUserLoginPage({super.key});

  @override
  State<ReturningUserLoginPage> createState() => _ReturningUserLoginPageState();
}

class _ReturningUserLoginPageState extends State<ReturningUserLoginPage> {
  final _formKey = GlobalKey<FormState>();
  final textFieldFocusNode = FocusNode();
  bool _obscured = true;
  late final LocalAuthentication auth;
  bool biometricLogin = false;
  LoginController returningUserLoginController = Get.put(LoginController());

  @override
  void initState() {
    auth = LocalAuthentication();
    super.initState();
  }

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
      body: StreamBuilder<SharedPreferences>(
          stream: SharedPreferences.getInstance().asStream(),
          builder: (context, snapshot) {
            return snapshot.hasData
                ? SafeArea(
                    child: Container(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width*0.65,
                            child: Text(
                              'Welcome back ${snapshot.requireData.getString('firstName')}',
                              style: TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 30.sp),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05,
                          ),
                          Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Email Address'),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.015,
                                  ),
                                  TextFormField(
                                    readOnly: true,
                                    initialValue:
                                        '${snapshot.data!.getString('email')}',
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    keyboardType: TextInputType.emailAddress,
                                    // controller: loginController.emailController,
                                    decoration: InputDecoration(
                                      enabledBorder: UnderlineInputBorder(),
                                    ),
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.015,
                                  ),
                                  Text('Password'),
                                  TextFormField(
                                    focusNode: textFieldFocusNode,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    keyboardType: TextInputType.visiblePassword,
                                    controller: returningUserLoginController
                                        .passwordController,
                                    decoration: InputDecoration(
                                      border: UnderlineInputBorder(),
                                      suffixIcon: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 0, 4, 0),
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
                                    color: Color.fromRGBO(33, 17, 71, 1)),
                                child: TextButton(
                                    onPressed: () {
                                      returningUserLoginController
                                          .loginWithEmailReturningUser(
                                              '${snapshot.requireData.getString('email')}');
                                    },
                                    child: Text(
                                      'Login',
                                      style: TextStyle(color: Colors.white),
                                    )),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text('Not you?'),
                                  TextButton(
                                      onPressed: () async {
                                        final SharedPreferences prefs =
                                            await SharedPreferences
                                                .getInstance();
                                        prefs..clear();
                                        Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) =>
                                                    const SplashScreen()),
                                            (route) => false);
                                      },
                                      child: Text(
                                        'Delete profile',
                                        style: TextStyle(
                                            color:
                                                Color.fromRGBO(115, 3, 217, 1)),
                                      ))
                                ],
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.01,
                              ),
                              TextButton(
                                  onPressed: () {

                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) =>
                                                const ForgotPasswordPage()));
                                  },
                                  child: Text(
                                    'Forgot Password',
                                  )),
                              Visibility(
                                visible: reuseable.showBiometricsWidget == null
                                    ? false
                                    : reuseable.showBiometricsWidget!,
                                child: Container(
                                    child: reuseable.availableBiometrics![0] ==
                                            BiometricType.weak
                                        ? GestureDetector(
                                            onTap: _authenticate,
                                            child: Image.asset(
                                                'asset/images/fingerprint.png',
                                                height: 120,
                                                color: Color.fromRGBO(
                                                    33, 17, 71, 1)),
                                          )
                                        : GestureDetector(
                                            onTap: _authenticate,
                                            child: Image.asset(
                                                'asset/images/face_recognition.png',
                                                height: 120),
                                          )),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  );
          }),
    );
  }

  Future<void> _authenticate() async {
    try {
      bool authenticated = await auth.authenticate(
          localizedReason: 'Login to PinnacleFX',
          options:
              AuthenticationOptions(stickyAuth: true, biometricOnly: true));

      if (authenticated) {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.remove('loggedout');
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return Center(
                child: CircularProgressIndicator(),
              );
            });

        await Future.delayed(Duration(seconds: 4));
        Navigator.pushAndRemoveUntil(
            Get.context!,
            MaterialPageRoute(builder: (_) => const LaunchPage()),
            (route) => false);
      }
      print('Authenticated: $authenticated');
    } on PlatformException catch (e) {
      print(e);
    }
  }
}
