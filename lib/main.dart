import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:my_app/e-commerce/homepage.dart';
import 'package:my_app/e-commerce/login.dart';
import 'package:my_app/model/cart_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => Cart()),
  ], child: MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool? isLoggedIn;
  @override
  void initState() {
    super.initState();
    _checkSession();
  }

  void _checkSession() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    });
    log("isloggedin = " + isLoggedIn.toString());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: isLoggedIn == true ? HomePageMain() : LoginPageMain());
  }
}
