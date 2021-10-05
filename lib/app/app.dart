import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ipet/app/screens/home/home.dart';
import 'package:ipet/app/screens/login/login.dart';
import 'package:ipet/app/util/hexcolor.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FirebaseAuth.instance.currentUser != null ? Home() : Login(),
      theme: ThemeData(
        fontFamily: 'POPPINS-REGULAR',
        primaryColor: HexColor("#2fb7a7"),
      ),
    );
  }
}
