import 'package:flutter/material.dart';
import 'package:tf11c_0031_codiego4_qr/pages/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "qrApp",
      home: HomePage(),
    );
  }
}
