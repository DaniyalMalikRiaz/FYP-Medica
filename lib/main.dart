import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:home_screen/global/global.dart';
//import 'package:home_screen/authScreens/login.dart';
import 'package:home_screen/home/home_screen.dart';
import 'package:home_screen/doctorProfile/doctor_profile.dart';
import 'package:home_screen/findPage/find_doctors.dart';
//import 'package:home_screen/history/history_page.dart';
import 'package:home_screen/history/history_taking.dart';
import 'package:home_screen/userAccount/settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'authScreens/signin.dart';

//import 'login.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPreferences = await SharedPreferences.getInstance();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Signin(),
    );
  }
}
