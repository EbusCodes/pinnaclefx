import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinnaclefx/Models/reuseable_widgets.dart';
import 'package:pinnaclefx/controllers/investment_controller.dart';
import 'package:pinnaclefx/models/custom_radio_button.dart';
import 'package:pinnaclefx/models/custom_snackbar.dart';

class TradeForYouAmount extends StatefulWidget {
  const TradeForYouAmount({super.key});

  @override
  State<TradeForYouAmount> createState() => _TradeForYouAmountState();
}

class _TradeForYouAmountState extends State<TradeForYouAmount> {
  bool isUserTyping = false;
  int? duration;
  int amount = 0;
  InvestmentController investmentController = Get.put(InvestmentController());
  int? _value;
  DateTimeRange selectedDates =
      DateTimeRange(start: DateTime.now(), end: DateTime.now());
  bool showCustomDatePayout = false;

  @override
  void initState() {
    super.initState();
    investmentController.capitalAmountController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            customPageAppBar(context, 'Trade For You'),
            Container(
              padding: EdgeInsets.all(15),
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.7,
                    child: Column(
                      children: [
                        Visibility(
                          visible: !isUserTyping,
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.7,
                            child: Text(
                                'Enter capital amount you want to be traded for you',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Color.fromRGBO(33, 17, 71, 1),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600)),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.04,
                        ),
                        TextField(
                          keyboardType: TextInputType.number,
                          controller:
                              investmentController.capitalAmountController,
                          decoration: InputDecoration(
                            prefixStyle: TextStyle(
                                color: Color.fromRGBO(33, 17, 71, 1),
                                fontWeight: FontWeight.w600,
                                fontSize: 20),
                            prefixText: '\$  ',
                            labelText: 'Enter Capital Amount',
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
                          style: TextStyle(
                              letterSpacing: 1.5,
                              color: Color.fromRGBO(33, 17, 71, 1),
                              fontWeight: FontWeight.w700,
                              fontSize: 20),
                          onChanged: (value) {
                            setState(() {
                              isUserTyping = value.isNotEmpty;
                              amount = int.parse(value);
                            });
                          },
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.06,
                        ),
                        Visibility(
                            visible: isUserTyping,
                            child: Column(
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
                                  height:
                                      MediaQuery.of(context).size.height * 0.35,
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
                                              amount: amount,
                                              value: 30,
                                              groupValue: _value,
                                              onChanged: (value) {
                                                setState(() {
                                                  showCustomDatePayout = false;
                                                  _value = value!;
                                                });
                                              }),
                                          MyRadioListTile(
                                              days: 60,
                                              amount: amount,
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
                                              amount: amount,
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
                                              amount: amount,
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
                                              amount: amount,
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
                                                        fontWeight:
                                                            FontWeight.w700,
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
                                          'Expected Payout: \$${((amount * 0.45 * selectedDates.duration.inDays / 100) + amount).toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} ',
                                          style: normalBoldTextStyle,
                                        )),
                                        SizedBox(height: 5)
                                      ],
                                    ))
                              ],
                            )),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01),
                        Text('Profit is paid out at trade end',
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
                        onPressed: _value == null &&
                                showCustomDatePayout == false
                            ? () {
                                showSnackBarFunOneLine(
                                    context: context,
                                    text: 'Please select a trading period',
                                    color: Colors.red,
                                    time: 3);
                              }
                            : () {
                                investmentController.tradeForYouInvestment(
                                    _value ?? selectedDates.duration.inDays);
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
