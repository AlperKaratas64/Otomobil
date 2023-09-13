import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:otomobil/data/src/colors.dart';
import 'package:otomobil/data/src/images.dart';
import 'package:otomobil/data/src/strings.dart';
import 'package:otomobil/views/home/home_Page.dart';
import 'package:otomobil/views/register/register_page.dart';

class LoginPage extends StatefulWidget {
  static const String routeName = '/views/login/login_Page';
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
              _buildUserNameText(),
              emailTextField(),
              _buildSpace(),
              _buildPasswordText(),
              passwordTextField(),
              _buildSpace(),
              _buildPasswordverifyText(),
              _buildSpace(),
              signUpButton(),
              _buildSpace(),
              _buildRegisterText(),
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

  Center signUpButton() {
    return Center(
      child: TextButton(
        onPressed: () async {
          if (formKey.currentState!.validate()) {
            formKey.currentState!.save();
            try {
              final userResult = await firebaseAuth.signInWithEmailAndPassword(
                  email: email, password: password);
              formKey.currentState!.reset();
              Navigator.pushReplacementNamed(context, "/homePage");
              print(userResult.user!.email);
            } catch (e) {
              print(e.toString());
            }
          } else {}
        },
        child: const Text(LoginButton),
        style: ElevatedButton.styleFrom(
            primary: black,
            foregroundColor: white,
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            padding: EdgeInsets.all(30)),
      ),
    );
  }

  Widget _buildUsernameTextField() {
    return const Material(
      elevation: 10,
      color: white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          topLeft: Radius.circular(10),
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(40, 0, 8, 0),
        child: TextField(
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }

  Widget _buildUserNameText() {
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

  Widget _buildPasswordTextField() {
    return const Material(
      elevation: 10,
      color: white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          topLeft: Radius.circular(10),
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(40, 0, 8, 0),
        child: TextField(
          obscureText: true,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }

  Widget _buildButton() {
    const double size = 70;
    return SizedBox(
      height: size,
      child: ElevatedButton(
        onPressed: () async {
          if (formKey.currentState!.validate()) {
            formKey.currentState!.save();
            try {
              //var userResult =
              //await firebaseAuth.createUserWithEmailAndPassword(
              //  email: email, password: password);
              // print(userResult.user!.uid);
            } catch (e) {
              print(e.toString());
            }
          } else {}
        },
        child: const Text(LoginButton),
        style: ElevatedButton.styleFrom(
          primary: mainColor,
        ),
      ),
    );
  }

  Widget _buildRegisterText() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(children: [
        const TextSpan(
          text: registerQuestionText,
          style: TextStyle(
            color: black,
          ),
        ),
        TextSpan(
            text: registerButtonText,
            style: const TextStyle(color: black, fontStyle: FontStyle.italic),
            recognizer: TapGestureRecognizer()
              ..onTap = () => Navigator.pushNamed(context, "/RegisterPage")),
      ]),
    );
  }

  Widget _buildPasswordverifyText() {
    return RichText(
      textAlign: TextAlign.end,
      text: TextSpan(children: [
        const TextSpan(
          style: TextStyle(
            color: black,
          ),
        ),
        TextSpan(
            text: PasswordVerifyText,
            style: const TextStyle(color: black, fontStyle: FontStyle.italic),
            recognizer: TapGestureRecognizer()
              ..onTap =
                  () => Navigator.pushNamed(context, "/passwordchangePage")),
      ]),
    );
  }
}
