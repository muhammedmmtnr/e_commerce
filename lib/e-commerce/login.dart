import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http; // Add this import
import 'package:my_app/e-commerce/homepage.dart';
import 'package:my_app/e-commerce/registration.dart';
import 'package:my_app/e-commerce/webservice.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPageMain extends StatefulWidget {
  @override
  State<LoginPageMain> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPageMain> {
  String? username, password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _loadCounter();
  }

  void _loadCounter() async {
    final prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false; // Fix the key here
    print("is logged in = " + isLoggedIn.toString());
    if (isLoggedIn) {
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => HomePageMain()));
    }
  }

  login(String username, String password) async {
    try {
      print('webservice');
      print(username);
      print(password);
      var result;
      final Map<String, dynamic> loginData = {
        'username': username,
        'password': password,
      };

      final response = await http.post(
        Uri.parse(Webservice.mainUrl + "login.php"),
        body: loginData,
      );

      print(response.statusCode);
      if (response.statusCode == 200) {
        if (response.body.contains("success")) {
          print("login successfully completed");
          final prefs = await SharedPreferences.getInstance();
          prefs.setBool("isLoggedIn", true);
          prefs.setString("username", username);
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return HomePageMain();
            },
          ));
        } else {
          print("login failed");
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            duration: Duration(seconds: 3),
            behavior: SnackBarBehavior.floating,
            padding: EdgeInsets.all(15.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            content: Text("LOGIN FAILED !!!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                )),
          ));
        }
      } else {
        result = {print(json.decode(response.body)['error'].toString())};
      }
      return result;
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 200),
                Text(
                  "Welcome to",
                  style: TextStyle(
                    color: Color.fromARGB(255, 5, 7, 62),
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Login with your username and password \n",
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(176, 246, 244, 244),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Center(
                        child: TextFormField(
                          style: TextStyle(
                            fontSize: 15,
                          ),
                          decoration: InputDecoration.collapsed(
                            hintText: 'username',
                          ),
                          onChanged: (text) {
                            setState(() {
                              username = text;
                            });
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter Your username';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(170, 255, 255, 255),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Center(
                        child: TextFormField(
                          obscureText: true,
                          style: TextStyle(
                            fontSize: 15,
                          ),
                          decoration: InputDecoration.collapsed(
                            hintText: 'password',
                          ),
                          onChanged: (text) {
                            setState(() {
                              password = text;
                            });
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter Your password';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width / 2,
                    height: 50,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        primary: Colors.white,
                        backgroundColor: const Color.fromARGB(255, 16, 6, 111),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          print("username:" + username.toString());
                          print("password:" + password.toString());

                          login(username.toString(), password.toString());
                        }
                      },
                      child: Text(
                        "login",
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                TextButton(
                  child: Text('New user? Go to Register'),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => RegistrationPage()));
                    // Navigate to the registration page
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
