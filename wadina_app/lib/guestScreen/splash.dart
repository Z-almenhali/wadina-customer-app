
import 'package:flutter/material.dart';
import 'package:wadina_app/guestScreen/intro.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    _navigatetohome();
  }

//f7f7f7
  _navigatetohome() async {
    await Future.delayed(
      Duration(milliseconds: 8500),
    );
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Intro()));
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(97, 120, 232, 1),
      body: Center(
        child: Container(
          child: Image(
            image: AssetImage('assets/Wadina.gif'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
