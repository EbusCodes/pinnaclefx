import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinnaclefx/screens/Authentication/login_page.dart';
import 'package:pinnaclefx/screens/Authentication/register_page.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(vsync: this, duration: Duration(seconds: 3))
        ..repeat(reverse: true);
  late Animation<Offset> _animation = Tween(
    begin: Offset.zero,
    end: Offset(0, 0.08),
  ).animate(_controller);

  final colorizeColors = [
  Colors.black,
  Colors.blue,
  Colors.yellow,
  Colors.red,
];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.8,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SlideTransition(
                  position: _animation,
                  child: Image.asset(
                    'asset/images/welcome_screen_asset.png',
                    height: MediaQuery.of(context).size.height * 0.65,
                    width: MediaQuery.of(context).size.width * 0.85,
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: AnimatedTextKit(
                    animatedTexts: [
                      ColorizeAnimatedText('Trade securely and at ease',
                      textAlign: TextAlign.center,
                       textStyle: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 38.sp,
                          height: 0.85),
                      colors: colorizeColors,
                      speed: Duration(milliseconds: 250))
                    ],
                    repeatForever: true,
                    
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                height: 55,
                width: 150,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Color.fromRGBO(33, 17, 71, 1)),
                child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (_, __, ___) => SignupPage(),
                          transitionDuration: Duration(milliseconds: 1500),
                          transitionsBuilder: (_, a, __, c) =>
                              FadeTransition(opacity: a, child: c),
                        ),
                      );
                    },
                    child: Text(
                      'Register',
                      style: TextStyle(color: Colors.white),
                    )),
              ),
              Container(
                width: 150,
                height: 55,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(
                      width: 3, color: Color.fromRGBO(33, 17, 71, 1)),
                ),
                child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (_, __, ___) => LoginPage(),
                          transitionDuration: Duration(milliseconds: 1500),
                          transitionsBuilder: (_, a, __, c) =>
                              FadeTransition(opacity: a, child: c),
                        ),
                      );
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(color: Color.fromRGBO(33, 17, 71, 1)),
                    )),
              )
            ],
          )
        ],
      )),
    );
  }
}
