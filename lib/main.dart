import 'package:blood_donation_firebase/add.dart';
import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'home.dart';
// import 'add.dart';
import 'update.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: EasySplashScreen(
        logo: Image.asset(
          'assets/Blood2 copy1.gif',
          height: 300,
          fit: BoxFit.fill,
          // width: 400,
        ),
        logoWidth: 50,
        title: Text(
          "Donor Plus",
          style: TextStyle(
              fontFamily: 'FredokaOne',
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.pink[900],
              letterSpacing: 1),
        ),
        showLoader: true,
        navigator: MyHome(),
        durationInSeconds: 10,
      ),
      debugShowCheckedModeBanner: false,
      routes: {
        //It's the default Homepage(SplashPage);
        // '/': (context) =>
        '/add': (context) => AddUser(),
        '/update': (context) => UpdateUser()
      },
    );
  }
}
