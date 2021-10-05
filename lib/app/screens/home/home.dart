import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ipet/app/screens/adopt/adopt.dart';
import 'package:ipet/app/screens/donate/donate.dart';
import 'package:ipet/app/util/database.dart';
import 'package:ipet/app/util/hexcolor.dart';
import 'package:ipet/app/util/authentication.dart';
import 'package:ipet/app/widgets/custom_button.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: Padding(
        padding: EdgeInsets.only(
          top: 10,
        ),
        child: FloatingActionButton(
          backgroundColor: Colors.black.withOpacity(0.5),
          onPressed: () => Authentication.signOut(context: context),
          child: Icon(Icons.logout),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/background.png"),
            colorFilter: ColorFilter.mode(
              HexColor("#2fb7a7").withOpacity(0.9),
              BlendMode.srcATop,
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Spacer(),
            Container(
              margin: EdgeInsets.only(bottom: 15),
              alignment: Alignment.bottomCenter,
              width: 150,
              height: 150,
              child: Stack(
                children: [
                  Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(1, 1),
                          blurRadius: 5,
                          spreadRadius: 2,
                          color: Colors.black26,
                        ),
                      ],
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: FutureBuilder(
                      future: getUser(),
                      builder: (context,
                          AsyncSnapshot<DocumentSnapshot<Object?>?> userDoc) {
                        if (userDoc.hasData && userDoc.data != null) {
                          var photo = userDoc.data!.get("photo");
                          if (photo != null) {
                            return Image.memory(
                              Uint8List.fromList(
                                photo.codeUnits,
                              ),
                              fit: BoxFit.cover,
                            );
                          }
                          return Image.asset(
                            "assets/icons/default-avatar.png",
                            fit: BoxFit.cover,
                          );
                        }
                        return Center(
                          child: Padding(
                            padding: EdgeInsets.all(10.0),
                            child: CircularProgressIndicator(
                              color: HexColor("#2fb7a7"),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Text(
              FirebaseAuth.instance.currentUser!.displayName ?? "default",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 80,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: CustomButton(
                width: MediaQuery.of(context).size.width / 2,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  topLeft: Radius.circular(50),
                ),
                title: "QUERO ADOTAR!",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => Adopt(),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: CustomButton(
                width: MediaQuery.of(context).size.width / 2,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
                title: "QUERO DOAR!",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => Donate(),
                    ),
                  );
                },
              ),
            ),
            Spacer(),
            Text(
              "iPet",
              style: TextStyle(
                fontFamily: "Grobold",
                fontSize: 50,
                color: Colors.black54,
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
