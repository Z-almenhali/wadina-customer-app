
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:wadina_app/guestScreen/splash.dart';


Future<void> main() async {
  
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(new MaterialApp(
    
    home: Splash(),
    debugShowCheckedModeBanner: false,
  ));

}
