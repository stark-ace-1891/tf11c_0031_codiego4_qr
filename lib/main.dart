import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tf11c_0031_codiego4_qr/pages/home_page.dart';
import 'package:tf11c_0031_codiego4_qr/utils/global_variable.dart';
import 'package:tf11c_0031_codiego4_qr/utils/notification_util.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await NotificationUtil.initMessaging();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: GlobalVariable.navState,
      title: "qrApp",
      home: HomePage(),
    );
  }
}
