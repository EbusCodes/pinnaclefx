import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pinnaclefx/controllers/deposit_controller.dart';
import 'package:pinnaclefx/models/reuseable_widgets.dart';

class DepositPage extends StatefulWidget {
  final String linkedAccountID;
  const DepositPage({super.key, required this.linkedAccountID});

  @override
  State<DepositPage> createState() => _DepositPageState();
}

List<String> virtualAccounts = ['Linked virtual card', 'Card'];

class _DepositPageState extends State<DepositPage> {
  DepositController depositController = Get.put(DepositController());
  final _formKey = GlobalKey<FormState>();
  String currentAccount = virtualAccounts[0];

  @override
  void initState() {
    depositController.amountController.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          customPageAppBar(context, 'Deposit'),
          Expanded(
              child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: 0.5,
                            color: Color.fromRGBO(220, 183, 244, 1)),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                              color: Color.fromRGBO(220, 183, 244, 1),
                              offset: Offset(5, 5))
                        ]),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Enter an amount', style: normalBoldTextStyle),
                        Row(
                          children: [
                            Text(
                              '\$',
                              style: TextStyle(fontSize: 20.sp),
                            ),
                            SizedBox(width: 5),
                            Form(
                              key: _formKey,
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.7,
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  controller:
                                      depositController.amountController,
                                  decoration: InputDecoration(
                                    hintText: '10 - 100,000',
                                    enabledBorder: UnderlineInputBorder(),
                                  ),
                                  style: TextStyle(fontSize: 18.sp),
                                  validator: (value) {
                                    if (int.parse(value!) < 10 ||
                                        int.parse(value) > 100000) {
                                      return 'Amount must be between \$10 - \$100,000';
                                    }

                                    return null;
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                Center(
                  child: Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: 0.5,
                            color: Color.fromRGBO(220, 183, 244, 1)),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                              color: Color.fromRGBO(220, 183, 244, 1),
                              offset: Offset(5, 5))
                        ]),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Funding method', style: normalBoldTextStyle),
                        ListTile(
                          title: Text('Linked virtual card'),
                          leading: Radio(
                              value: virtualAccounts[0],
                              groupValue: currentAccount,
                              onChanged: (value) {}),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.08),
                Container(
                  height: 60,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: depositController
                                  .amountController.text.isNotEmpty &&
                              int.parse(
                                      depositController.amountController.text) >
                                  10 &&
                              int.parse(depositController
                                      .amountController.text) <=
                                  100000
                          ? Color.fromRGBO(33, 17, 71, 1)
                          : Colors.grey),
                  child: TextButton(
                      onPressed:
                          depositController.amountController.text.isNotEmpty &&
                                  int.parse(depositController
                                          .amountController.text) >
                                      10 &&
                                  int.parse(depositController
                                          .amountController.text) <=
                                      100000
                              ? () {
                                  depositController
                                      .deposit(widget.linkedAccountID);
                                }
                              : null,
                      child: Text(
                        'Deposit',
                        style: TextStyle(color: Colors.white, fontSize: 16.sp),
                      )),
                ),
              ],
            ),
          ))
        ]),
      ),
    );
  }
}
