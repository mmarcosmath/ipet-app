import 'dart:typed_data';

import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ipet/app/util/authentication.dart';
import 'package:ipet/app/util/hexcolor.dart';
import 'package:ipet/app/util/utils.dart';
import 'package:ipet/app/widgets/custom_button.dart';
import 'package:ipet/app/widgets/custom_textfield.dart';
import 'package:ipet/app/widgets/custon_textbutton.dart';

class Singin extends StatelessWidget {
  Singin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final nameController = TextEditingController();
    final phoneController = TextEditingController();
    ValueNotifier<Uint8List?> image = ValueNotifier(null);
    var singinValidator = ValueNotifier<bool>(false);
    return Scaffold(
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
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  GestureDetector(
                    onTap: () async {
                      image.value = await selectImage();
                    },
                    child: ValueListenableBuilder(
                        valueListenable: image,
                        builder: (context, Uint8List? imageValue, _) {
                          return Container(
                            margin: EdgeInsets.only(bottom: 15),
                            alignment: Alignment.center,
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
                            child: imageValue != null
                                ? Image.memory(
                                    imageValue,
                                    fit: BoxFit.cover,
                                  )
                                : Image.asset(
                                    "assets/icons/camera.png",
                                    width: 100,
                                  ),
                          );
                        }),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  CustomTextField(
                    controller: nameController,
                    backgroundColor: Colors.white,
                    icon: Image.asset("assets/icons/user.png"),
                    title: "Nome",
                    keyboardType: TextInputType.name,
                    textCapitalization: TextCapitalization.sentences,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                    controller: phoneController,
                    backgroundColor: Colors.white,
                    icon: Image.asset("assets/icons/phone1.png"),
                    title: "Telefone",
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      TelefoneInputFormatter(),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                    controller: emailController,
                    backgroundColor: Colors.white,
                    icon: Image.asset("assets/icons/mail.png"),
                    title: "Email",
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                    controller: passwordController,
                    isObscureText: true,
                    backgroundColor: Colors.white,
                    icon: Image.asset("assets/icons/lock.png"),
                    title: "Senha",
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  ValueListenableBuilder(
                      valueListenable: singinValidator,
                      builder: (context, bool isLoading, _) {
                        return Center(
                          child: AnimatedContainer(
                            height: 50,
                            width: isLoading
                                ? 50
                                : MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(50)),
                            duration: Duration(milliseconds: 300),
                            child: isLoading
                                ? Center(
                                    child: Padding(
                                      padding: EdgeInsets.all(10.0),
                                      child: CircularProgressIndicator(
                                        color: HexColor("#2fb7a7"),
                                      ),
                                    ),
                                  )
                                : CustomButton(
                                    title: "CADASTRAR",
                                    onPressed: () async {
                                      singinValidator.value = true;
                                      var user = await Authentication.signUp(
                                        context: context,
                                        email: emailController.text,
                                        name: nameController.text,
                                        password: passwordController.text,
                                        phone: phoneController.text,
                                        photo: image.value != null
                                            ? String.fromCharCodes(image.value!)
                                            : null,
                                      );
                                      singinValidator.value = false;

                                      if (user != null) Navigator.pop(context);
                                    },
                                  ),
                          ),
                        );
                      }),
                  SizedBox(
                    height: 20,
                  ),
                  CustomTextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    title: "VOLTAR",
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
