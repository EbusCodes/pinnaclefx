// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:pinnaclefx/InvestmentPages/GroupTrading/group_trading_success.dart';
import 'package:pinnaclefx/Models/reuseable_widgets.dart';
import 'package:pinnaclefx/models/custom_radio_button.dart';
import 'package:pinnaclefx/services/local_notifications_service.dart';

class GroupTradingAmount extends StatefulWidget {
  int amount;
  GroupTradingAmount({super.key, required this.amount});

  @override
  State<GroupTradingAmount> createState() => _GroupTradingAmountState();
}

class _GroupTradingAmountState extends State<GroupTradingAmount> {
  int? _value;
   DateTimeRange selectedDates =
      DateTimeRange(start: DateTime.now(), end: DateTime.now());
  bool showCustomDatePayout = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            customPageAppBar(context, 'Group Trading'),
            Container(
              padding: EdgeInsets.all(15),
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.7,
                    child: Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.04,
                        ),
                        TextFormField(
                          readOnly: true,
                          initialValue:
                              '${widget.amount.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}',
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            prefixStyle: TextStyle(
                                color: Color.fromRGBO(33, 17, 71, 1),
                                fontWeight: FontWeight.w600,
                                fontSize: 20),
                            prefixText: '\$  ',
                            labelText: 'Enter Capital Share',
                            labelStyle: TextStyle(
                                color: Color.fromRGBO(33, 17, 71, 1),
                                fontSize: 18,
                                fontWeight: FontWeight.w600),
                            hintStyle: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w500),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                  width: 1.5,
                                  color: Color.fromRGBO(33, 17, 71, 1),
                                )),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                  width: 1.5,
                                  color: Color.fromRGBO(33, 17, 71, 1),
                                )),
                          ),
                          style: amountInputTextStyle,
                          onChanged: (value) {
                            setState(() {
                              widget.amount = int.parse(value);
                            });
                          },
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.06,
                        ),
                        Column(
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      MyRadioListTile(
                                          days: 30,
                                          amount: widget.amount,
                                          value: 30,
                                          groupValue: _value,
                                          onChanged: (value){
                                                setState(() {
                                                  showCustomDatePayout = false;
                                                  _value = value!;
                                                });
                                              }),
                                      MyRadioListTile(
                                          days: 60,
                                          amount: widget.amount,
                                          value: 60,
                                          groupValue: _value,
                                          onChanged: (value) {
                                                setState(() {
                                                  showCustomDatePayout = false;
                                                  _value = value!;
                                                });
                                              })
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      MyRadioListTile(
                                          days: 90,
                                          amount: widget.amount,
                                          value: 90,
                                          groupValue: _value,
                                          onChanged: (value) {
                                                setState(() {
                                                  showCustomDatePayout = false;
                                                  _value = value!;
                                                });
                                              }),
                                      MyRadioListTile(
                                          days: 180,
                                          amount: widget.amount,
                                          value: 180,
                                          groupValue: _value,
                                          onChanged: (value) {
                                                setState(() {
                                                  showCustomDatePayout = false;
                                                  _value = value!;
                                                });
                                              })
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      MyRadioListTile(
                                          days: 365,
                                          amount: widget.amount,
                                          value: 365,
                                          groupValue: _value,
                                          onChanged: (value) {
                                                setState(() {
                                                  showCustomDatePayout = false;
                                                  _value = value!;
                                                });
                                              }),
                                      GestureDetector(
                                        onTap: () async {
                                              final DateTimeRange?
                                                  dateTimeRange =
                                                  await showDateRangePicker(
                                                      context: context,
                                                      firstDate: DateTime.now(),
                                                      lastDate: DateTime(2500));
                                              if (dateTimeRange != null) {
                                                setState(() {
                                                  showCustomDatePayout = true;
                                                  _value = null;
                                                  selectedDates = dateTimeRange;
                                                });
                                              }
                                            },
                                        child: Container(
                                          padding: EdgeInsets.all(5),
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.08,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.35,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            border: Border.all(
                                                width: 2,
                                                color: Color.fromRGBO(
                                                    33, 17, 71, 1)),
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Image.asset(
                                                'asset/images/calendar.png',
                                                height: 25,
                                              ),
                                              Text(
                                                'Pick Date',
                                                style: TextStyle(
                                                    color: Color.fromRGBO(
                                                        33, 17, 71, 1),
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 15),
                                              )
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Visibility(
                                    visible: showCustomDatePayout,
                                    child: Column(
                                      children: [
                                        Center(
                                            child: Text(
                                                'You have selected a trading period of ${selectedDates.duration.inDays} days')),
                                        Center(
                                            child: Text(
                                          'Expected Payout: \$${((widget.amount * 0.45 * selectedDates.duration.inDays / 100) + widget.amount).toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} ',
                                          style: normalBoldTextStyle,
                                        )),
                                        SizedBox(height: 5)
                                      ],
                                    ))
                          ],
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height*0.01),
                        Text('Profit is paid out at trade end and split evenly',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Color.fromRGBO(33, 17, 71, 1),
                                fontSize: 13,
                                fontWeight: FontWeight.w400)),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(width: 2, color: Color(0xFF211147)),
                    ),
                    child: TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => GroupTradingSuccess(
                                        amount: widget.amount,
                                      )));
                          NotificationService().showNotification(
                              id: 1,
                              title: 'Hurray!',
                              body:
                                  'You have successfully placed a trade of \$${widget.amount.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} for you and your team');
                        },
                        child: Text(
                          'Create a plan',
                          style:
                              TextStyle(color: Color.fromRGBO(33, 17, 71, 1)),
                        )),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
