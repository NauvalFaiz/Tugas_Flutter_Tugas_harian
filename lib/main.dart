// import 'package:belajar_flutter_r7/Widgets/Pages/Akun_page/Pages_profile.dart';
// import 'package:belajar_flutter_r7/Widgets/Onbording/Onbording.dart';
// import 'package:belajar_flutter_r7/Widgets/Pages/Login_Sign_in/LoginPages.dart';
// import 'package:belajar_flutter_r7/Widgets/Pages/Login_Sign_in/Login_page.dart';
//  import 'package:belajar_flutter_r7/Pages/Login_Sign_in/splash_screen.dart';
// import 'package:belajar_flutter_r7/Widgets/Pages/HomePage.dart';
// import 'package:belajar_flutter_r7/Pages/Login_Sign_in/splash_screen.dart';
// import 'package:belajar_flutter_r7/Widgets/Pages/Navbar/root.dart';
// import 'package:belajar_flutter_r7/Pages/Login_Sign_in/LoginPages.dart';
// import 'package:belajar_flutter_r7/Pages/Login_Sign_in/Login_page.dart';
import 'package:belajar_flutter_r7/Widgets/Onbording/Splace_screen.dart';
import 'package:belajar_flutter_r7/Widgets/Pages/Navbar/root.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Music Show',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {'/': (context) => SplaceScreen(), '/home': (context) => Root()},
      theme: ThemeData(primarySwatch: Colors.blue),
    );
  }
}
