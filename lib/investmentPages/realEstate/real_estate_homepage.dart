import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pinnaclefx/Models/reuseable_widgets.dart';

class RealEstateHomePage extends StatefulWidget {
  const RealEstateHomePage({super.key});

  @override
  State<RealEstateHomePage> createState() => _RealEstateHomePageState();
}

class _RealEstateHomePageState extends State<RealEstateHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: SafeArea(
          child: Column(children: [
            customPageAppBarHome(context, 'Real Estate'),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  padding: EdgeInsets.all(15),
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.4,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Positioned(
                          bottom: 0,
                          child: Container(
                            padding: EdgeInsets.all(8),
                            width: MediaQuery.of(context).size.width - 30,
                            height: MediaQuery.of(context).size.height * 0.15,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 0.5,
                                    color: Color.fromRGBO(220, 183, 244, 1)),
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                      color: Color.fromRGBO(179, 93, 253, 1),
                                      offset: Offset(5, 5))
                                ]),
                            child: Column(
                              children: [
                                SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.065),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Builder(builder: (context) {
                                    return GestureDetector(
                                      onTap: () {},
                                      child: Container(
                                        padding: EdgeInsets.all(5),
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.4,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            gradient: LinearGradient(
                                                begin: Alignment.topCenter,
                                                end: Alignment.bottomCenter,
                                                colors: [
                                                  Color.fromRGBO(
                                                      115, 3, 217, 1),
                                                  Color.fromRGBO(33, 17, 71, 1)
                                                ])),
                                        child: Text(
                                          'Houses',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20),
                                        ),
                                      ),
                                    );
                                  }),
                                ),
                              ],
                            ),
                          )),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.2,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset(
                              'asset/images/houses.jpeg',
                              height: MediaQuery.of(context).size.height * 0.2,
                            ),
                          )),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(15),
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.4,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Positioned(
                          bottom: 0,
                          child: Container(
                            padding: EdgeInsets.all(8),
                            width: MediaQuery.of(context).size.width - 30,
                            height: MediaQuery.of(context).size.height * 0.15,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 0.5,
                                    color: Color.fromRGBO(220, 183, 244, 1)),
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                      color: Color.fromRGBO(179, 93, 253, 1),
                                      offset: Offset(5, 5))
                                ]),
                            child: Column(
                              children: [
                                SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.065),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: GestureDetector(
                                    onTap: () {},
                                    child: Container(
                                      padding: EdgeInsets.all(5),
                                      width: MediaQuery.of(context).size.width *
                                          0.4,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          gradient: LinearGradient(
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                              colors: [
                                                Color.fromRGBO(115, 3, 217, 1),
                                                Color.fromRGBO(33, 17, 71, 1)
                                              ])),
                                      child: Text(
                                        'Lands',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.2,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset(
                              'asset/images/lands.jpeg',
                              height: MediaQuery.of(context).size.height * 0.2,
                            ),
                          )),
                    ],
                  ),
                ),
              ],
            )
          ]),
        ),
      ),
    );
  }
}
