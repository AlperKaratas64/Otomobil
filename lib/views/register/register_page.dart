import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otomobil/data/src/images.dart';
import 'package:otomobil/data/src/strings.dart';
import '../../data/src/colors.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPage();
}

class _RegisterPage extends State<RegisterPage> {
  late String email, password;
  final formKey = GlobalKey<FormState>();
  final firebaseAuth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Text(
              loginAppBarText,
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
        backgroundColor: teal,
      ),
      body: _buildBody(),
      backgroundColor: teal,
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildSpace(),
              _buildImages(),
              _buildMaxSpace(),
              _buildEmailNameText(),
              emailTextField(),
              _buildSpace(),
              _buildPasswordText(),
              passwordTextField(),
              _buildMaxSpace(),
              //_buildButton(),
              signUpButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImages() {
    return Image.asset(
      Logo,
      height: 200,
      width: 200,
    );
  }

  Widget _buildSpace() {
    return const SizedBox(
      height: 20,
    );
  }

  Widget _buildMaxSpace() {
    return const SizedBox(
      height: 30,
    );
  }

  TextFormField emailTextField() {
    return TextFormField(
        validator: (Value) {
          if (Value!.isEmpty) {
            return Empty;
          } else {}
        },
        onSaved: (Value) {
          email = Value!;
        },
        style: TextStyle(color: mainColor),
        decoration: const InputDecoration(
            //hintText: userNameText,
            ));
  }

  TextFormField passwordTextField() {
    return TextFormField(
        obscureText: true,
        validator: (Value) {
          if (Value!.isEmpty) {
            return Empty;
          } else {}
        },
        onSaved: (Value) {
          password = Value!;
        },
        style: TextStyle(color: mainColor),
        decoration: const InputDecoration(
            //hintText: userNameText,
            ));
  }

  Widget _buildEmailNameText() {
    return Text(
      userNameText,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: Checkbox.width,
      ),
    );
  }

  Widget _buildPasswordText() {
    return Text(
      passwordText,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: Checkbox.width,
      ),
    );
  }

  Center signUpButton() {
    return Center(
      child: TextButton(
        onPressed: () async {
          if (formKey.currentState!.validate()) {
            formKey.currentState!.save();
            try {
              var userResult =
                  await firebaseAuth.createUserWithEmailAndPassword(
                      email: email, password: password);
              formKey.currentState!.reset();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(Verify),
                ),
              );
              Navigator.pushReplacementNamed(context, "/LoginPage");
            } catch (e) {
              print(e.toString());
            }
          } else {}
        },
        child: const Text(LoginButton),
        style: ElevatedButton.styleFrom(),
      ),
    );
  }
}
