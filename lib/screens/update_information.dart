import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:pinnaclefx/controllers/update_information_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdateInformationPage extends StatefulWidget {
  final String? firstName;
  final String? lastName;
  final String? email;
  final int? balance;
  final int? asset;
  final String? phoneNumber;
  final int? interest;
  const UpdateInformationPage(
      {super.key,
      this.asset,
      this.balance,
      this.email,
      this.firstName,
      this.interest,
      this.lastName,
      this.phoneNumber});

  @override
  State<UpdateInformationPage> createState() => _UpdateInformationPageState();
}

class _UpdateInformationPageState extends State<UpdateInformationPage> {
  String dateOfBirth = 'Select Date of Birth';
  UpdateInformationController updateInformationController =
      Get.put(UpdateInformationController());
  String? name;
  String? email;
  String? phone;

  @override
  void initState() {
  name = '${widget.firstName} ${widget.lastName}';
  email = '${widget.email}';
  phone = '${widget.phoneNumber}';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 15),
            Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 1,
              ),
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.close_rounded, size: 30,)),
            ],
          ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(20),
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        
                        Text('Full Name', style: TextStyle(fontWeight: FontWeight.w600)),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.015,
                        ),
                        TextFormField(
                          initialValue: name,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(),
                          ),
                          onFieldSubmitted: (value) async {
                            final SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            prefs.setString('name', value);
                            name = value;
                            print('NAME $name');
                          },
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        Text('Email Address',
                            style: TextStyle(fontWeight: FontWeight.w600)),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.015,
                        ),
                        TextFormField(
                          readOnly: true,
                          initialValue: email,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(),
                          ),
                          onFieldSubmitted: (value) async {
                            final SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            prefs.setString('email', value);
                            email = value;
                          },
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        Text('Phone Number', style: TextStyle(fontWeight: FontWeight.w600)),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.015,
                        ),
                        TextFormField(
                          initialValue: phone,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(),
                          ),
                          onFieldSubmitted: (value) async {
                            final SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            prefs.setString('phone', value);
                            phone = value;
                          },
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        Text('Date of Birth',
                            style: TextStyle(fontWeight: FontWeight.w600)),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.015,
                        ),
                        TextFormField(
                          onTap: () {
                            showDatePicker(
                                    context: context,
                                    firstDate: DateTime(1900),
                                    lastDate: DateTime(2300),
                                    initialDate: DateTime.now())
                                .then((value) {
                              setState(() {
                                dateOfBirth =
                                    '${value!.day.toString()}-${value.month.toString()}-${value.year.toString()}';
                              });
                            });
                          },
                          readOnly: true,
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(),
                            prefixIcon: Icon(Icons.calendar_month_outlined),
                            hintText: dateOfBirth,
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.08,
                        ),
                        Center(
                          child: Container(
                            width: 250,
                            height: 55,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              border: Border.all(
                                  width: 3, color: Color.fromRGBO(33, 17, 71, 1)),
                            ),
                            child: TextButton(
                                onPressed: phone != '${widget.phoneNumber}' ||
                                        email != '${widget.email}' ||
                                        dateOfBirth != 'Select Date of Birth' ||
                                        name != '${widget.firstName} ${widget.lastName}'
                                    ? () async {
                                        final SharedPreferences prefs =
                                            await SharedPreferences.getInstance();
                                        updateInformationController
                                            .updateAccountInformation(
                                                prefs.getString('email') ?? email!,
                                                prefs.getString('name') ?? name!,
                                                prefs.getString('phone') ?? phone!);
                                      }
                                    : () => null,
                                child: Text(
                                  'Update Information',
                                  style: TextStyle(color: Color.fromRGBO(33, 17, 71, 1)),
                                )),
                          ),
                        ),
                        SizedBox(height: 15)
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
