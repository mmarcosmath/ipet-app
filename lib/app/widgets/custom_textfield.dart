import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ipet/app/util/hexcolor.dart';

class CustomTextField extends StatelessWidget {
  final String title;
  final bool error;
  final bool autofocus;
  final bool isObscureText;
  final int maxLines;
  final TextEditingController? controller;
  final void Function()? onEditingComplete;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final Widget? icon;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final TextCapitalization textCapitalization;
  final TextInputAction? textInputAction;
  final Color? backgroundColor;
  CustomTextField({
    Key? key,
    required this.title,
    this.error = false,
    this.autofocus = false,
    this.isObscureText = false,
    this.maxLines = 1,
    this.controller,
    this.backgroundColor = Colors.white,
    this.onEditingComplete,
    this.onChanged,
    this.validator,
    this.suffixIcon,
    this.icon,
    this.keyboardType = TextInputType.name,
    this.inputFormatters,
    this.textInputAction = TextInputAction.next,
    this.textCapitalization = TextCapitalization.none,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
        color: backgroundColor,
      ),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      child: TextField(
        textInputAction: textInputAction,
        textCapitalization: textCapitalization,
        autofocus: autofocus,
        controller: controller,
        inputFormatters: inputFormatters,
        keyboardType: keyboardType,
        maxLines: maxLines,
        onChanged: onChanged,
        onEditingComplete: onEditingComplete,
        obscureText: isObscureText,
        onSubmitted: null,
        style: TextStyle(
          fontSize: 18,
        ),
        cursorColor: HexColor("#2fb7a7"),
        decoration: InputDecoration(
          hintText: title,
          prefixIcon: Container(
              width: 40,
              padding: EdgeInsets.all(10),
              alignment: Alignment.topCenter,
              child: icon),
          prefixIconConstraints: BoxConstraints(
            maxHeight: maxLines * 40,
            maxWidth: 50,
          ),
          suffixIcon: suffixIcon,
          suffixIconConstraints: BoxConstraints(
            maxWidth: 40,
          ),
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
        ),
      ),
    );
  }
}
