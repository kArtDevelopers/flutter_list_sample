import 'package:flutter/material.dart';

import 'data_list_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter List Sample',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromRGBO(17, 49, 70, 1.0),
        primarySwatch: Colors.blue,
      ),
      home: DataListView(),
    );
  }
}


class demo extends StatelessWidget {
  const demo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 100,),
          Row(
            children: [
              SizedBox(width: 20,),
              Stack(
                children: [
                  Container(
                      margin: EdgeInsets.only(left: 11, top: 5),
                      width: 50.0,
                      height: 50.0,
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius:
                          BorderRadius.circular(7),
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: NetworkImage('https://seatgeek.com/images/performers-landscape/texas-rangers-c2f361/16/huge.jpg')))),
                  const Icon(
                    Icons.favorite,
                    color: Colors.red,
                    size: 22.0,
                    semanticLabel: 'Text to announce in accessibility modes',
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

