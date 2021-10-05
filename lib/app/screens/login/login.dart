import 'package:flutter/material.dart';
import 'package:ipet/app/screens/singin/singin.dart';
import 'package:ipet/app/util/hexcolor.dart';
import 'package:ipet/app/util/authentication.dart';
import 'package:ipet/app/widgets/custom_button.dart';
import 'package:ipet/app/widgets/custom_textfield.dart';
import 'package:ipet/app/widgets/custon_textbutton.dart';

class Login extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var loginValidator = ValueNotifier<bool>(false);
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
              height: 450,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: Text(
                      "IPet",
                      style: TextStyle(
                        fontFamily: "Grobold",
                        fontSize: 70,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  CustomTextField(
                    controller: emailController,
                    icon: Image.asset("assets/icons/mail.png"),
                    title: "Email",
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                    controller: passwordController,
                    isObscureText: true,
                    icon: Image.asset("assets/icons/lock.png"),
                    title: "Senha",
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        "Esqueceu sua senha?",
                      ),
                      style: TextButton.styleFrom(
                        primary: Colors.white,
                        textStyle: TextStyle(
                          fontSize: 16,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            100,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ValueListenableBuilder(
                      valueListenable: loginValidator,
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
                                    title: "ENTRAR",
                                    onPressed: () async {
                                      loginValidator.value = true;
                                      await Authentication.signIn(
                                        context: context,
                                        email: emailController.text,
                                        password: passwordController.text,
                                      );
                                      loginValidator.value = false;
                                    },
                                  ),
                          ),
                        );
                      }),
                  SizedBox(
                    height: 20,
                  ),
                  CustomTextButton(
                    onPressed: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => Singin(),
                        ),
                      );
                    },
                    title: "CADASTRAR-SE",
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
