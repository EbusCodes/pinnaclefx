import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pinnaclefx/Models/reuseable_widgets.dart';
import 'package:pinnaclefx/screens/splashScreen/spalsh_screen.dart';
import 'package:pinnaclefx/services/local_notifications_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().initNotification();
  await Permission.notification.isDenied.then((value) {
        if (value) {
          Permission.notification.request();
        }
      });
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: false,
      designSize: Size(390, 844),
      builder: (_, chhild) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'PinnacleFX',
        theme: ThemeData(
          switchTheme: SwitchThemeData(
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            thumbIcon: MaterialStatePropertyAll(Icon(Icons.light_mode_outlined)),
            trackOutlineWidth: MaterialStatePropertyAll(1)
            ),
          textButtonTheme: TextButtonThemeData(
            style: ButtonStyle(textStyle: MaterialStatePropertyAll(buttonTextStyle))
          ),
          dialogBackgroundColor: Color.fromRGBO(255, 255, 255, 1),
          dialogTheme: DialogTheme(
            shadowColor: Color.fromRGBO(33, 17, 71, 1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30),
              topRight: Radius.circular(30))
            )
          ),
          disabledColor: Colors.grey,
            textTheme: TextTheme(
              bodyMedium: TextStyle(fontSize: 13.5.sp, color: Color.fromRGBO(33, 17, 71, 1)),
            ),
            colorScheme:
                ColorScheme.fromSeed(seedColor: Color.fromRGBO(115, 3, 217, 1)),
            useMaterial3: true,
            fontFamily: 'Montserrat'),
        home: const SplashScreen(),
      ),
    );
  }
}
