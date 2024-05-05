import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

showSnackBarFunOneLine(
    {required BuildContext context,
    required final String text,
    required final Color color,
    required final int time}) {
  SnackBar snackBar = SnackBar(
    content: Text(text, style: TextStyle(fontSize: 15.sp)),
    backgroundColor: color,
    dismissDirection: DismissDirection.up,
    elevation: 10,
    behavior: SnackBarBehavior.floating,
    margin: EdgeInsets.only(
      top: 10,
        bottom: MediaQuery.of(context).size.height -
            MediaQuery.of(context).size.height * 0.11,
        left: 10,
        right: 10),
    duration: Duration(seconds: time),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

showSnackBarFunTwoLines(
    {required BuildContext context,
    required final String text,
    required final Color color,
    required final int time}) {
  SnackBar snackBar = SnackBar(
    content: Text(text, style: TextStyle(fontSize: 15.sp)),
    backgroundColor: color,
    dismissDirection: DismissDirection.up,
    elevation: 10,
    behavior: SnackBarBehavior.floating,
    margin: EdgeInsets.only(
      top: 10,
        bottom: MediaQuery.of(context).size.height -
            MediaQuery.of(context).size.height * 0.15,
        left: 10,
        right: 10),
    duration: Duration(seconds: time),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}