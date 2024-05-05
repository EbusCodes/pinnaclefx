import 'package:flutter/material.dart';
import 'package:pinnaclefx/Models/reuseable_widgets.dart';

class PhonesPage extends StatefulWidget {
  const PhonesPage({super.key});

  @override
  State<PhonesPage> createState() => _PhonesPageState();
}

class _PhonesPageState extends State<PhonesPage> {
  List<String> phone_brands = [
    'iPhone',
    'Samsung',
    'Redmi',
    'Infinix',
    'Tecno',
    'Xiaomi'
  ];
  List<String> phone_images = [
    'asset/images/iphone.png',
    'asset/images/samsung.png',
    'asset/images/redmi.png',
    'asset/images/iphone.png',
    'asset/images/tecno.png',
    'asset/images/xiaomi.png'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: SafeArea(
          child: Column(children: [
            customPageAppBar(context, 'Phones'),
            Container(
                margin: EdgeInsets.fromLTRB(25, 10, 25, 10),
                width: MediaQuery.of(context).size.width,
                height: 50,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Colors.white),
                child: TextFormField(
                    readOnly: false,
                    onTap: () {},
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(25))),
                        hintText: 'Search Phones',
                        hintStyle: TextStyle(
                            color: Colors.grey,
                            textBaseline: TextBaseline.alphabetic),
                        prefixIcon: Icon(
                          Icons.search_sharp,
                          color: Colors.grey,
                          weight: 0.1,
                          fill: 0.5,
                          size: 35,
                        )))),
            Expanded(
              child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisSpacing: 10, crossAxisCount: 2),
                  itemCount: phone_brands.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Container(
                          color: Colors.transparent,
                          width: MediaQuery.of(context).size.width * 0.4,
                          height: MediaQuery.of(context).size.height * 0.23,
                          child: Stack(children: [
                            Card(
                              elevation: 20,
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.38,
                                height:
                                    MediaQuery.of(context).size.height * 0.2,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20)),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.asset(
                                    phone_images[index],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top:
                                  MediaQuery.of(context).size.height * 0.2 - 20,
                              left: 0,
                              right: 0,
                              child: Container(
                                padding: EdgeInsets.all(5),
                                width: MediaQuery.of(context).size.width * 0.4,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Color.fromRGBO(115, 3, 217, 1),
                                          Color.fromRGBO(33, 17, 71, 1)
                                        ])),
                                child: Text(
                                  phone_brands[index],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            )
                          ]),
                        ),
                      ],
                    );
                  }),
            )
          ]),
        ),
      ),
    );
  }
}
