import 'package:flutter/material.dart';

import 'package:ipet/app/util/hexcolor.dart';

class GenreSelect extends StatefulWidget {
  void Function(String) onChange;
  GenreSelect({
    Key? key,
    required this.onChange,
  }) : super(key: key);

  @override
  _GenreSelectState createState() => _GenreSelectState();
}

class _GenreSelectState extends State<GenreSelect> {
  String genre = "";
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      width: 130,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      clipBehavior: Clip.antiAlias,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  genre = "Macho";
                  widget.onChange(genre);
                });
              },
              child: Container(
                height: 52,
                color: genre == "Macho"
                    ? HexColor("#2fb7a7").withOpacity(0.2)
                    : Colors.transparent,
                padding: EdgeInsets.all(10),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 5),
                      child: Text(
                        "M",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color:
                              genre == "Macho" ? Colors.black87 : Colors.grey,
                        ),
                      ),
                    ),
                    Image.asset(
                      "assets/icons/male.png",
                      height: 20,
                      color: HexColor("#2fb7a7"),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  genre = "Fêmea";
                  widget.onChange(genre);
                });
              },
              child: Container(
                height: 52,
                color: genre == "Fêmea"
                    ? HexColor("#2fb7a7").withOpacity(0.2)
                    : Colors.transparent,
                padding: EdgeInsets.all(10),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 5),
                      child: Text(
                        "F",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color:
                              genre == "Fêmea" ? Colors.black87 : Colors.grey,
                        ),
                      ),
                    ),
                    Image.asset(
                      "assets/icons/female.png",
                      height: 22,
                      color: HexColor("#2fb7a7"),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
