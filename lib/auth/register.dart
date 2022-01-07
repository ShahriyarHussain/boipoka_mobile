import 'package:boipoka_mobile/auth/login.dart';
import 'package:boipoka_mobile/auth/register_page.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {'/login': (context) => const Login()},
      home: Scaffold(
          extendBody: true,
          appBar: AppBar(
            backgroundColor: Colors.indigo[900],
            title: const Text('Boipoka'),
            centerTitle: true,
          ),
          body: const RegisterPage()),
    );
  }
}
