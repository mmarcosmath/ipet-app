import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:interactiveviewer_gallery/interactiveviewer_gallery.dart';
import 'package:ipet/app/util/database.dart';
import 'package:ipet/app/util/hexcolor.dart';
import 'package:ipet/app/util/messages.dart';
import 'package:ipet/app/widgets/custom_button.dart';
import 'package:ipet/app/widgets/photo_view_pets.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';

class Details extends StatelessWidget {
  QueryDocumentSnapshot doc;
  Details({
    Key? key,
    required this.doc,
  }) : super(key: key);

  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch("tel:$url")) {
      await launch("tel:$url");
    }
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
          onPressed: () => Navigator.pop(context),
          child: Icon(Icons.close),
        ),
      ),
      body: Stack(
        children: [
          PhotoViewPets(
            photos: [
              ...doc.get("photos").split(","),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 25),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                image: DecorationImage(
                  image: AssetImage("assets/background.png"),
                  colorFilter: ColorFilter.mode(
                    HexColor("#2fb7a7").withOpacity(0.9),
                    BlendMode.srcATop,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              width: double.infinity,
              height: MediaQuery.of(context).size.height - 350,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 25,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            doc.get("name"),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              height: 1,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Image.asset(
                          "assets/icons/${doc.get("genre") == "Macho" ? "male" : "female"}.png",
                          height: 20,
                          color: Colors.white,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            doc.get("genre"),
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      doc.get("date"),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Container(
                      width: double.infinity,
                      child: Text(
                        doc.get("description"),
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          height: 1,
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 80,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.all(25),
              width: double.infinity,
              child: CustomButton(
                sufix: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.phone,
                    size: 26,
                  ),
                ),
                title: "Entrar em contato",
                onPressed: () async {
                  var user = await getUser(doc.get("email"));
                  if (user != null) {
                    await _makePhoneCall(user.get("phone"));
                  } else {
                    Message.showMessage(context, "Contato não encontrado!");
                  }
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
