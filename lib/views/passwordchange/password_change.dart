import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:otomobil/data/src/colors.dart';
import 'package:otomobil/data/src/images.dart';
import 'package:otomobil/data/src/strings.dart';

class PasswordchangePage extends StatefulWidget {
  @override
  State<PasswordchangePage> createState() => _PasswordchangePageState();
}

class _PasswordchangePageState extends State<PasswordchangePage> {
  late String email;
  final auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    email = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              loginAppBarText,
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
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildSpace(),
              _buildImages(),
              _buildMaxSpace(),
              _buildGmailText(),
              _buildSpace(),
              emailTextField(),
              _buildMaxSpace(),
              signUpButton(),
            ],
          ),
        ),
      ),
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
      style: TextStyle(color: black),
    );
  }

  Center signUpButton() {
    return Center(
      child: TextButton(
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            _formKey.currentState!.save();
            try {
              await auth.sendPasswordResetEmail(email: email);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Şifre sıfırlama e-postası gönderildi'),
                ),
              );
              Navigator.of(context).pop();
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Şifre sıfırlama e-postası gönderilemedi: $e'),
                ),
              );
            }
          }
        },
        child: const Text(Gmailbutton),
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

  Widget _buildImages() {
    return Image.asset(
      Logo,
      height: 300,
      width: 300,
    );
  }

  Widget _buildSpace() {
    return const SizedBox(
      height: 20,
    );
  }

  Widget _buildMaxSpace() {
    return const SizedBox(
      height: 40,
    );
  }

  Widget _buildGmailText() {
    return Text(
      Gmaillogin,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: Checkbox.width,
      ),
    );
  }
}
