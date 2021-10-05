import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ipet/app/screens/home/home.dart';
import 'package:ipet/app/screens/login/login.dart';
import 'package:ipet/app/util/database.dart';
import 'package:ipet/app/util/messages.dart';

class Authentication {
  static Future<void> signIn(
      {required BuildContext context,
      required String email,
      required String password}) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential.user != null) {
        await Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => Home(),
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Message.showError(context, 'Conta não cadastrada');
      } else if (e.code == 'wrong-password') {
        Message.showError(context, 'A senha está incorreta');
      }
    }
  }

  static Future<User?> signUp(
      {required BuildContext context,
      required String name,
      required String email,
      required String password,
      required String phone,
      String? photo}) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        await userCredential.user!.updateDisplayName(name);
        saveUser(
          name: name,
          email: email,
          phone: phone,
          photo: photo,
        );
        Message.showMessage(context, 'Cadastro realizado');
        return userCredential.user;
      }
    } catch (e) {
      Message.showError(context, 'Erro ao cadastrar');
    }
  }

  static Future<void> signOut({required BuildContext context}) async {
    try {
      await FirebaseAuth.instance.signOut();
      await Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => Login(),
        ),
      );
    } catch (e) {
      Message.showError(context, 'Erro ao sair');
    }
  }
}
