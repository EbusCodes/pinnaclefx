import 'package:flutter/material.dart';
import 'package:pinnaclefx/Models/reuseable_widgets.dart';

class LaptopsPage extends StatefulWidget {
  const LaptopsPage({super.key});

  @override
  State<LaptopsPage> createState() => _LaptopsPageState();
}

class _LaptopsPageState extends State<LaptopsPage> {
  List<String> laptop_brands = ['Lenovo', 'Macbooks', 'HP'];
  List<String> laptop_images = [
    'asset/images/lenovo.png',
    'asset/images/macbooks.png',
    'asset/images/hp.png'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: SafeArea(
          child: Column(children: [
            customPageAppBar(context, 'Laptops'),
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
                        hintText: 'Search Laptops',
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
              child: ListView.builder(
                  itemCount: laptop_brands.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.8,
                          height: MediaQuery.of(context).size.height * 0.3,
                          child: Stack(children: [
                            Card(
                              elevation: 20,
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.8,
                                height:
                                    MediaQuery.of(context).size.height * 0.25,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20)),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.asset(
                                    laptop_images[index],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: MediaQuery.of(context).size.height * 0.25 -
                                  20,
                              left: MediaQuery.of(context).size.width * 0.2,
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
                                  laptop_brands[index],
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
                        SizedBox(
                          height: 10,
                        )
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
