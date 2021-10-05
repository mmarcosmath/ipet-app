import 'package:flutter/material.dart';
import 'package:ipet/app/util/hexcolor.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final void Function()? onPressed;
  final BorderRadiusGeometry? borderRadius;
  final double width;
  final Widget? sufix;
  const CustomButton({
    Key? key,
    required this.title,
    this.onPressed,
    this.borderRadius,
    this.width = 100,
    this.sufix,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          sufix ?? SizedBox(),
          Text(
            title,
          ),
        ],
      ),
      style: TextButton.styleFrom(
        fixedSize: Size(width, 50),
        primary: HexColor("#2fb7a7"),
        backgroundColor: Colors.white,
        textStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius ?? BorderRadius.circular(50),
        ),
      ),
    );
  }
}
