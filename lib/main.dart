import 'package:flutter/material.dart';

import 'screens/data_list_view.dart';

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

