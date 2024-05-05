import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:pinnaclefx/launch_page.dart';
import 'package:pinnaclefx/models/reuseable_widgets.dart' as reuseable;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pinnaclefx/screens/WelcomeScreen/welcome_screen.dart';
import 'package:pinnaclefx/screens/authentication/login_page_returning_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final LocalAuthentication auth = LocalAuthentication();

  void navigate() async {
    Future.delayed(const Duration(seconds: 4), () async {
      final prefs = await _prefs;
      reuseable.showBiometricsWidget = prefs.getBool('biometric');
      prefs.getString('token') != null && prefs.getString('loggedout') == 'true'
          ? Navigator.pushAndRemoveUntil(
              context,
                        PageRouteBuilder(
                          pageBuilder: (_, __, ___) => ReturningUserLoginPage(),
                          transitionDuration: Duration(seconds: 1),
                          transitionsBuilder: (_, a, __, c) =>
                              FadeTransition(opacity: a, child: c),
                        ),
              (route) => false)
          : prefs.getString('token') != null &&
                  prefs.getString('loggedout') == null
              ? Navigator.pushAndRemoveUntil(
                  context,
                        PageRouteBuilder(
                          pageBuilder: (_, __, ___) => LaunchPage(),
                          transitionDuration: Duration(seconds: 2),
                          transitionsBuilder: (_, a, __, c) =>
                              FadeTransition(opacity: a, child: c),
                        ),
                  (route) => false)
              : Navigator.pushAndRemoveUntil(
                  context,
                        PageRouteBuilder(
                          pageBuilder: (_, __, ___) => WelcomeScreen(),
                          transitionDuration: Duration(milliseconds: 1900),
                          transitionsBuilder: (_, a, __, c) =>
                              FadeTransition(opacity: a, child: c),
                        ),
                  (route) => false);
    });
  }

  Future<void> _availableBiometricMethods() async {
    reuseable.availableBiometrics = await auth.getAvailableBiometrics();

    print('Biometrics: ${reuseable.availableBiometrics}');
  }

  @override
  void initState() {
    _availableBiometricMethods();
    navigate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
              Color.fromRGBO(115, 3, 217, 1),
              Color.fromRGBO(33, 17, 71, 1)
            ])),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SafeArea(
          child: Center(
            child: SvgPicture.asset(
              'asset/images/pinnacle_logo.svg',
              height: 250,
            ),
          ),
        ),
      ),
    );
  }
}
