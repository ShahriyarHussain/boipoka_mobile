import 'package:boipoka_mobile/auth/register.dart';
import 'package:boipoka_mobile/main.dart';
import 'package:flutter/material.dart';
import 'login_page.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/register': (context) => const Register(),
      },
      home: Scaffold(
          extendBody: true,
          appBar: AppBar(
            backgroundColor: Colors.indigo[900],
            title: const Text('Boipoka'),
            centerTitle: true,
          ),
          body: const LoginPage()),
    );
  }
}
