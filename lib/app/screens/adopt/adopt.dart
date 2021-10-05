import 'package:flutter/material.dart';
import 'package:ipet/app/screens/details/details.dart';
import 'package:ipet/app/util/database.dart';
import 'package:ipet/app/util/hexcolor.dart';
import 'package:ipet/app/widgets/adopt_item.dart';
import 'package:ipet/app/widgets/your_pet_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Adopt extends StatelessWidget {
  Adopt({Key? key}) : super(key: key);

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
      body: Container(
        height: MediaQuery.of(context).size.height,
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
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 60,
              ),
              FutureBuilder(
                  future: getMyPets(),
                  builder: (context,
                      AsyncSnapshot<List<QueryDocumentSnapshot>> docs) {
                    if (docs.hasData && docs.data!.length > 0) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 25,
                            ),
                            child: Text(
                              "Seus pets",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            height: 170,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                ...docs.data!.map(
                                  (e) => GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => Details(
                                            doc: e,
                                          ),
                                        ),
                                      );
                                    },
                                    child: YourPetItem(
                                      image: e.get("photos").split(",").first,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                        ],
                      );
                    }
                    return SizedBox();
                  }),
              FutureBuilder(
                  future: getAdoptionPets(),
                  builder: (context,
                      AsyncSnapshot<List<QueryDocumentSnapshot>> docs) {
                    if (docs.hasData && docs.data!.length > 0) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 25,
                            ),
                            child: Text(
                              "Adote agora",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          ...docs.data!.map((e) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => Details(
                                      doc: e,
                                    ),
                                  ),
                                );
                              },
                              child: AdoptItem(
                                name: e.get("name"),
                                date: e.get("date"),
                                description: e.get("description"),
                                genre: e.get("genre"),
                                image: e.get("photos").split(",").first,
                              ),
                            );
                          }),
                        ],
                      );
                    }
                    return Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 25,
                        ),
                        child: Text(
                          "Não há pets para adoção no momento...",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
