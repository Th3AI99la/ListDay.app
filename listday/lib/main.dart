import 'package:flutter/material.dart';
import 'package:listday/pages/pageone.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //MaterialApp e resposnsavel por muita coisa
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Listdayapp(),
    );
  }
}
