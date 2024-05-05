import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pinnaclefx/controllers/update_information_controller.dart';
import 'package:pinnaclefx/models/reuseable_widgets.dart' as reuseable;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:local_auth/local_auth.dart';
import 'package:pinnaclefx/models/reuseable_widgets.dart';
import 'package:pinnaclefx/screens/splashScreen/spalsh_screen.dart';
import 'package:pinnaclefx/screens/update_information.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MePage extends StatefulWidget {
  final String firstName;
  final String lastName;
  final String email;
  final int balance;
  final int asset;
  final String phoneNumber;
  final int interest;
  const MePage(
      {super.key,
     required this.asset,
     required this.balance,
     required this.email,
     required this.firstName,
     required this.interest,
     required this.lastName,
     required this.phoneNumber});

  @override
  State<MePage> createState() => _MePageState();
}

class _MePageState extends State<MePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late final LocalAuthentication auth;
  String dateOfBirth = 'Select Date of Birth';
  UpdateInformationController updateInformationController =
      Get.put(UpdateInformationController());

  displayBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: 150,
            width: double.infinity,
            padding: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    Icon(Icons.camera_alt_outlined,
                        color: Color.fromRGBO(33, 17, 71, 1)),
                    SizedBox(width: 10),
                    Text('Upload Image from camera',
                        style: TextStyle(color: Color.fromRGBO(33, 17, 71, 1)))
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.image_outlined,
                        color: Color.fromRGBO(33, 17, 71, 1)),
                    SizedBox(width: 10),
                    Text('Upload Image from gallery',
                        style: TextStyle(color: Color.fromRGBO(33, 17, 71, 1)))
                  ],
                ),
              ],
            ),
          );
        });
  }

  @override
  void initState() {
    auth = LocalAuthentication();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
              padding: EdgeInsets.fromLTRB(5, 20, 5, 0),
              child: Column(
                children: [
                  Stack(children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(75),
                        child: Image.asset(
                          'asset/images/user_profile.png',
                          height: 150,
                          fit: BoxFit.cover,
                          filterQuality: FilterQuality.medium,
                        )),
                    Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          width: 35,
                          height: 35,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Color.fromRGBO(33, 17, 71, 1)),
                          child: IconButton(
                              icon: const Icon(
                                Icons.edit,
                                color: Colors.white,
                                size: 20,
                              ),
                              onPressed: displayBottomSheet),
                        ))
                  ]),
                  SizedBox(height: 15),
                  Text(
                    '${widget.firstName} ${widget.lastName}',
                    style: tabHeaderTextstyle,
                  ),
                  Text(
                    '${widget.email}',
                    style: normalTextStyle,
                  ),
                  Divider(),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (_, __, ___) => UpdateInformationPage(
                              email: widget.email,
                              phoneNumber: widget.phoneNumber,
                              lastName: widget.lastName,
                              firstName: widget.firstName),
                          transitionDuration: Duration(milliseconds: 500),
                          transitionsBuilder: (_, a, __, c) =>
                              FadeTransition(opacity: a, child: c),
                        ),
                      );
                    },
                    child: ListTile(
                      title: Text(
                        'Update Information',
                        style: TextStyle(fontSize: 18.sp),
                      ),
                      trailing: Icon(Icons.arrow_forward_ios_outlined),
                    ),
                  ),
                  
                  ListTile(
                    title: Text(
                      'Security',
                      style: TextStyle(fontSize: 18.sp),
                    ),
                    trailing: Icon(Icons.arrow_forward_ios_outlined),
                  ),
                  ListTile(
                    title: Text(
                      'Payment',
                      style: TextStyle(fontSize: 18.sp),
                    ),
                    trailing: Icon(Icons.arrow_forward_ios_outlined),
                  ),
                  ListTile(
                    title: Text(
                      'Support',
                      style: TextStyle(fontSize: 18.sp),
                    ),
                    trailing: Icon(Icons.arrow_forward_ios_outlined),
                  ),
                  SwitchListTile(
                      title: Text(
                        'Login with Biometrics',
                        style: TextStyle(fontSize: 18.sp),
                      ),
                      value: reuseable.showBiometricsWidget == null
                          ? false
                          : reuseable.showBiometricsWidget!,
                      onChanged: (switcher) {
                        _authenticate();
                        setState(() {
                          reuseable.showBiometricsWidget;
                        });
                      }),
                  ListTile(
                    title: Text(
                      'Version',
                      style: TextStyle(fontSize: 18.sp),
                    ),
                    trailing: Text(
                      '1.0.24',
                      style: TextStyle(fontSize: 18.sp),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      showLogoutDialogue();
                    },
                    child: ListTile(
                        title: Text(
                          'Signout',
                          style: TextStyle(
                              fontSize: 18.sp,
                              color: Colors.red,
                              fontWeight: FontWeight.w500),
                        ),
                        trailing: Icon(
                          Icons.logout_sharp,
                          color: Colors.red,
                        )),
                  ),
                  Divider(),
                  TextButton(
                    onPressed: () async {},
                    child: ListTile(
                        title: Text(
                      'Delete Account',
                      style: TextStyle(
                          fontSize: 18.sp,
                          color: Colors.red,
                          fontWeight: FontWeight.w500),
                    )),
                  ),
                ],
              )),
        ),
      ),
    );
  }

  Future<void> _authenticate() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    ;
    try {
      bool authenticated = await auth.authenticate(
          localizedReason: 'Activate biometric login',
          options:
              AuthenticationOptions(stickyAuth: true, biometricOnly: true));

      if (authenticated) {
        if (reuseable.showBiometricsWidget == null) {
          setState(() {
            reuseable.showBiometricsWidget = authenticated;
            prefs.setBool('biometric', authenticated);
          });
        } else {
          reuseable.showBiometricsWidget = !reuseable.showBiometricsWidget!;
          setState(() {
            prefs.setBool('biometric', reuseable.showBiometricsWidget!);
          });
        }
      }
      print('Authenticated: $authenticated');
      print('Show: ${reuseable.showBiometricsWidget}');
    } on PlatformException catch (e) {
      print(e);
    }
  }

  displayUpdateInformationSheet() {
    showCupertinoModalPopup(
        barrierDismissible: true,
        context: context,
        builder: ((context) {
          return Material();
        }));
  }

  showLogoutDialogue() {
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return Dialog(
            child: Container(
              padding: EdgeInsets.all(10),
              height: MediaQuery.of(context).size.height * 0.2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('Are you sure you want to signout?',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18.sp)),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('CANCEL')),
                      TextButton(
                          onPressed: () async {
                            Navigator.pop(context);
                            final SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            prefs.setString('loggedout', 'true');

                            showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (context) {
                                  return Center(
                                    child: Container(
                                      height: 120,
                                      child: Column(
                                        children: [
                                          CircularProgressIndicator(),
                                          SizedBox(height: 10),
                                          Text('Logging out...',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 23.sp))
                                        ],
                                      ),
                                    ),
                                  );
                                });

                            await Future.delayed(Duration(seconds: 3)).then(
                                (value) => Navigator.push(
                                    _scaffoldKey.currentContext!,
                                    MaterialPageRoute(
                                        builder: (_) => const SplashScreen())));
                          },
                          child: Text(
                            'SIGNOUT',
                            style: TextStyle(color: Colors.red),
                          ))
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}
