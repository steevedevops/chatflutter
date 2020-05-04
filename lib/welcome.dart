import 'package:flutter/material.dart';
import 'package:morse/screens/authenticate/login.dart';
import 'package:morse/screens/home-screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {

  @override
  void initState() {
    super.initState();
    _nextScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FlutterLogo(
          size: 300,
        ),
      ),
    );
  }

  void _nextScreen() async {
    Future.delayed(
      Duration(seconds: 3),
      () async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        print('Ten session id');
        print(prefs.getString('sessionid'));
        if(prefs.getString('sessionid') != null){
          Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
        }else{
          Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
        }
      }
    );
  }
}