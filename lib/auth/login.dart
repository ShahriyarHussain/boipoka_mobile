import 'dart:developer';
// import 'dart:html';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var _storage = FlutterSecureStorage();
  var _username = "";
  var _password = "";

  final nameController = TextEditingController();
  final passwordController = TextEditingController();

  void getUserDetails() {}

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
            margin: const EdgeInsets.all(15),
            child: TextField(
              controller: nameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Enter Username",
                labelText: "Username",
              ),
            )),
        Container(
            margin: const EdgeInsets.all(15),
            child: TextField(
              obscureText: true,
              controller: passwordController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Passoword",
                  labelText: "Password"),
            )),
        ElevatedButton(
          onPressed: () {
            setState(() {
              _username = nameController.text;
              _password = passwordController.text;
            });
          },
          child: const Text("Login"),
        ),
        Container(
          margin: const EdgeInsets.only(top: 20),
          child: Text(_username + " " + _password),
        )
      ],
    );
  }
}
