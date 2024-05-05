import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

List<BiometricType>? availableBiometrics;
const double defaultPadding = 12;
SharedPreferences? preferences;
bool? showBiometricsWidget;
TextStyle normalTextStyle = TextStyle(
    color: Color.fromRGBO(33, 17, 71, 1),
    fontWeight: FontWeight.w400,
    fontSize: 14.sp);

TextStyle amountInputTextStyle = TextStyle(
    color: Color.fromRGBO(33, 17, 71, 1),
    fontWeight: FontWeight.w600,
    fontSize: 20.sp);

TextStyle buttonTextStyle = TextStyle(
    color: Color.fromRGBO(33, 17, 71, 1),
    fontWeight: FontWeight.w500,
    fontSize: 15.sp);

TextStyle normalBoldTextStyle = TextStyle(
    color: Color.fromRGBO(33, 17, 71, 1),
    fontWeight: FontWeight.w700,
    fontSize: 14.sp);

TextStyle tabHeaderTextstyle = TextStyle(
    fontSize: 26.sp,
    color: Color.fromRGBO(33, 17, 71, 1),
    fontWeight: FontWeight.w600);

customPageAppBar(BuildContext context, String title) {
  return Container(
    padding: EdgeInsets.fromLTRB(0, 10, 10, 0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios_sharp,
              size: 30,
              color: Color.fromRGBO(33, 17, 71, 1),
            )),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.65,
          child: Text(
            title,
            textAlign: TextAlign.start,
            style: TextStyle(
                fontSize: 26.sp,
                color: Color.fromRGBO(33, 17, 71, 1),
                fontWeight: FontWeight.w600),
          ),
        ),
      ],
    ),
  );
}

customPageAppBarHome(BuildContext context, String title) {
  return Container(
    padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios_sharp,
              size: 30,
              color: Color.fromRGBO(33, 17, 71, 1),
            )),
        Text(
          title,
          textAlign: TextAlign.start,
          style: TextStyle(
            fontSize: 26.sp,
            fontWeight: FontWeight.w600,
            color: Color.fromRGBO(33, 17, 71, 1),
          ),
        ),
        IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.more_vert_outlined,
              size: 30,
              color: Color.fromRGBO(33, 17, 71, 1),
            )),
      ],
    ),
  );
}

shadowedBoxContainer(BuildContext context, double height, double width,
    double padding, double borderRadius, Widget child) {
  return Container(
      height: height,
      width: width,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
          border:
              Border.all(width: 0.5, color: Color.fromRGBO(220, 183, 244, 1)),
          color: Colors.white,
          borderRadius: BorderRadius.circular(borderRadius),
          boxShadow: [
            BoxShadow(
                color: Color.fromRGBO(220, 183, 244, 1), offset: Offset(4, 4))
          ]),
      child: child);
}

passwordValidatorCheck(
    bool _showPasswordValidator,
    bool _isPasswordEightCharacters,
    bool _isPasswordContainDigit,
    bool _isPasswordContainSpecialCharacter,
    bool _isPasswordContainUppercase) {
  return Visibility(
    visible: _showPasswordValidator,
    child: Column(
      children: [
        SizedBox(height: 15),
        Row(
          children: [
            AnimatedContainer(
                duration: Duration(milliseconds: 500),
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                    color: _isPasswordEightCharacters
                        ? Colors.purple
                        : Colors.transparent,
                    border: _isPasswordEightCharacters
                        ? Border.all(color: Colors.transparent)
                        : Border.all(color: Colors.grey.shade400),
                    borderRadius: BorderRadius.circular(50)),
                child: Icon(Icons.check, color: Colors.white, size: 15)),
            SizedBox(width: 10),
            Text('Contains at least eight characters',
                style: TextStyle(
                  color:
                      _isPasswordEightCharacters ? Colors.purple : Colors.red,
                ))
          ],
        ),
        SizedBox(height: 15),
        Row(
          children: [
            AnimatedContainer(
                duration: Duration(milliseconds: 500),
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                    color: _isPasswordContainDigit
                        ? Colors.purple
                        : Colors.transparent,
                    border: _isPasswordContainDigit
                        ? Border.all(color: Colors.transparent)
                        : Border.all(color: Colors.grey.shade400),
                    borderRadius: BorderRadius.circular(50)),
                child: Icon(Icons.check, color: Colors.white, size: 15)),
            SizedBox(width: 10),
            Text('Contains at least one digit',
                style: TextStyle(
                  color: _isPasswordContainDigit ? Colors.purple : Colors.red,
                ))
          ],
        ),
        SizedBox(height: 15),
        Row(
          children: [
            AnimatedContainer(
                duration: Duration(milliseconds: 500),
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                    color: _isPasswordContainSpecialCharacter
                        ? Colors.purple
                        : Colors.transparent,
                    border: _isPasswordContainSpecialCharacter
                        ? Border.all(color: Colors.transparent)
                        : Border.all(color: Colors.grey.shade400),
                    borderRadius: BorderRadius.circular(50)),
                child: Icon(Icons.check, color: Colors.white, size: 15)),
            SizedBox(width: 10),
            Text('Contains at least one special characters',
                style: TextStyle(
                  color: _isPasswordContainSpecialCharacter
                      ? Colors.purple
                      : Colors.red,
                ))
          ],
        ),
        SizedBox(height: 15),
        Row(
          children: [
            AnimatedContainer(
                duration: Duration(milliseconds: 500),
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                    color: _isPasswordContainUppercase
                        ? Colors.purple
                        : Colors.transparent,
                    border: _isPasswordContainUppercase
                        ? Border.all(color: Colors.transparent)
                        : Border.all(color: Colors.grey.shade400),
                    borderRadius: BorderRadius.circular(50)),
                child: Icon(Icons.check, color: Colors.white, size: 15)),
            SizedBox(width: 10),
            Text('Contains at least one uppercase letter',
                style: TextStyle(
                  color:
                      _isPasswordContainUppercase ? Colors.purple : Colors.red,
                ))
          ],
        )
      ],
    ),
  );
}

showInvestmentOptions(BuildContext context, int? amount) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Select Trade Period',
        style: TextStyle(
            color: Color.fromRGBO(33, 17, 71, 1),
            fontWeight: FontWeight.w700,
            fontSize: 15),
      ),
      Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.35,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.all(5),
                  height: MediaQuery.of(context).size.height * 0.08,
                  width: MediaQuery.of(context).size.width * 0.35,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                        width: 2, color: Color.fromRGBO(33, 17, 71, 1)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '30 days',
                        style: TextStyle(
                            color: Color.fromRGBO(33, 17, 71, 1),
                            fontWeight: FontWeight.w400,
                            fontSize: 15),
                      ),
                      Text(
                        '\$${((amount ?? 0 * 0.45 * 30 / 100) + amount!).toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}',
                        style: TextStyle(
                            color: Color.fromRGBO(33, 17, 71, 1),
                            fontWeight: FontWeight.w700,
                            fontSize: 15),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(5),
                  height: MediaQuery.of(context).size.height * 0.08,
                  width: MediaQuery.of(context).size.width * 0.35,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                        width: 2, color: Color.fromRGBO(33, 17, 71, 1)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '60 days',
                        style: TextStyle(
                            color: Color.fromRGBO(33, 17, 71, 1),
                            fontWeight: FontWeight.w400,
                            fontSize: 15),
                      ),
                      Text(
                        '\$${((amount * 0.45 * 60 / 100) + amount).toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}',
                        style: TextStyle(
                            color: Color.fromRGBO(33, 17, 71, 1),
                            fontWeight: FontWeight.w700,
                            fontSize: 15),
                      )
                    ],
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.all(5),
                  height: MediaQuery.of(context).size.height * 0.08,
                  width: MediaQuery.of(context).size.width * 0.35,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                        width: 2, color: Color.fromRGBO(33, 17, 71, 1)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '90 days',
                        style: TextStyle(
                            color: Color.fromRGBO(33, 17, 71, 1),
                            fontWeight: FontWeight.w400,
                            fontSize: 15),
                      ),
                      Text(
                        '\$${((amount * 0.45 * 90 / 100) + amount).toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}',
                        style: TextStyle(
                            color: Color.fromRGBO(33, 17, 71, 1),
                            fontWeight: FontWeight.w700,
                            fontSize: 15),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(5),
                  height: MediaQuery.of(context).size.height * 0.08,
                  width: MediaQuery.of(context).size.width * 0.35,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                        width: 2, color: Color.fromRGBO(33, 17, 71, 1)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '180 days',
                        style: TextStyle(
                            color: Color.fromRGBO(33, 17, 71, 1),
                            fontWeight: FontWeight.w400,
                            fontSize: 15),
                      ),
                      Text(
                        '\$${((amount * 0.45 * 180 / 100) + amount).toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}',
                        style: TextStyle(
                            color: Color.fromRGBO(33, 17, 71, 1),
                            fontWeight: FontWeight.w700,
                            fontSize: 15),
                      )
                    ],
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.all(5),
                  height: MediaQuery.of(context).size.height * 0.08,
                  width: MediaQuery.of(context).size.width * 0.35,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                        width: 2, color: Color.fromRGBO(33, 17, 71, 1)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '365 days',
                        style: TextStyle(
                            color: Color.fromRGBO(33, 17, 71, 1),
                            fontWeight: FontWeight.w400,
                            fontSize: 15),
                      ),
                      Text(
                        '\$${((amount * 0.45 * 365 / 100) + amount).toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}',
                        style: TextStyle(
                            color: Color.fromRGBO(33, 17, 71, 1),
                            fontWeight: FontWeight.w700,
                            fontSize: 15),
                      )
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    showDateRangePicker(
                        context: context,
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2075));
                  },
                  child: Container(
                    padding: EdgeInsets.all(5),
                    height: MediaQuery.of(context).size.height * 0.08,
                    width: MediaQuery.of(context).size.width * 0.35,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                          width: 2, color: Color.fromRGBO(33, 17, 71, 1)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'asset/images/calendar.png',
                          height: 25,
                        ),
                        Text(
                          'Pick Date',
                          style: TextStyle(
                              color: Color.fromRGBO(33, 17, 71, 1),
                              fontWeight: FontWeight.w700,
                              fontSize: 15),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      )
    ],
  );
}
