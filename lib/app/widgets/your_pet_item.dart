import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ipet/app/util/hexcolor.dart';

class YourPetItem extends StatelessWidget {
  String image;
  YourPetItem({
    Key? key,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      height: 170,
      margin: EdgeInsets.only(left: 25),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            offset: Offset(1, 1),
            blurRadius: 5,
            spreadRadius: 2,
            color: Colors.black26,
          ),
        ],
      ),
      child: CachedNetworkImage(
        imageUrl: image,
        fit: BoxFit.cover,
        placeholder: (context, url) => Center(
          child: CircularProgressIndicator(
            strokeWidth: 6.0,
            color: HexColor("#2fb7a7"),
          ),
        ),
      ),
    );
  }
}
