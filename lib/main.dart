import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tf11c_0031_codiego4_qr/pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
