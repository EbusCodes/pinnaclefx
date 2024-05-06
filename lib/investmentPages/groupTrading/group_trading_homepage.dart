import 'package:flutter/material.dart';
import 'package:pinnaclefx/InvestmentPages/GroupTrading/group_trading_amount.dart';
import 'package:pinnaclefx/Models/reuseable_widgets.dart';

class GroupTradingHomePage extends StatefulWidget {
  const GroupTradingHomePage({super.key});

  @override
  State<GroupTradingHomePage> createState() => _GroupTradingHomePageState();
}

class _GroupTradingHomePageState extends State<GroupTradingHomePage> {
  TextEditingController capitalController = TextEditingController();
  List<String> groupNumber = [
    '5-10',
    '10-20',
    '20-25',
  ];
  String? selectedGroup;
  bool showProgressIndicator = false;
  bool disableDropDownMenu = true;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Column(children: [
      customPageAppBarHome(context, 'Group Trading'),
      Container(
        height: MediaQuery.of(context).size.height * 0.7,
        padding: EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.4,
              padding: EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset('asset/images/grouptrading.png', height: 250),
                  Text(
                    'Profit is paid out at trade end and split evenly',
                    style: TextStyle(
                        color: Color.fromRGBO(33, 17, 71, 1),
                        fontWeight: FontWeight.w500,
                        fontSize: 12.5),
                  ),
                ],
              ),
            ),
            TextFormField(
              controller: capitalController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                prefixStyle: TextStyle(
                    color: Color.fromRGBO(33, 17, 71, 1),
                    fontWeight: FontWeight.w600,
                    fontSize: 20),
                prefixText: '\$  ',
                hintText: 'Enter Capital Share',
                hintStyle:
                    TextStyle(color: Colors.grey, fontWeight: FontWeight.w400),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                      width: 1.5,
                      color: Color.fromRGBO(33, 17, 71, 1),
                    )),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      width: 1.5,
                      color: Color.fromRGBO(33, 17, 71, 1),
                    )),
              ),
              // onEditingComplete: () {
              //   if(disableDropDownMenu == false){
              //     Navigator.push(
              //                 context,
              //                 MaterialPageRoute(
              //                     builder: (_) => GroupTradingAmount(
              //                           amount:
              //                               int.parse(capitalController.text),
              //                         )));
              //   }
              // },
              style: amountInputTextStyle,
              onChanged: (value) {
                setState(() {
                  disableDropDownMenu = value.isEmpty;
                },
              
                );
              },
            ),
            SizedBox(height: 10),
            AbsorbPointer(
              absorbing: disableDropDownMenu,
              child: GestureDetector(
                child: SizedBox(
                  width: double.infinity,
                  child: DropdownButtonFormField<String>(
                    disabledHint: null,
                    isExpanded: true,
                    hint: Text('Select group number'),
                    iconSize: 30,
                    iconEnabledColor: Colors.grey,
                    decoration: InputDecoration(
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
                            ))),
                    items: groupNumber
                        .map((e) => DropdownMenuItem(
                              alignment: Alignment.center,
                              child: Text(
                                e,
                                style: TextStyle(color: Colors.grey),
                              ),
                              value: e,
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        showProgressIndicator = true;
                        selectedGroup = value;
                      });
                      Future.delayed(Duration(seconds: 2)).then((value) {
                        if (capitalController.text.isNotEmpty) {
                          setState(() {
                            showProgressIndicator = false;
                          });

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => GroupTradingAmount(
                                        amount:
                                            int.parse(capitalController.text),
                                      )));
                        }
                      });
                    },
                    value: selectedGroup,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      SizedBox(height: 10),
      Visibility(
        visible: showProgressIndicator,
        child: CircularProgressIndicator(
          color: Color.fromRGBO(33, 17, 71, 1),
          backgroundColor: Colors.transparent,
        ),
      )
    ])));
  }
}
