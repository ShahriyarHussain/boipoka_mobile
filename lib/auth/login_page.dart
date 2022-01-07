import 'dart:convert';
import 'dart:developer';
import 'package:boipoka_mobile/main.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:boipoka_mobile/services/auth_service.dart';
import '../vars.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  final urlPrefix = Vars().getBaseUrl();

  var loggedIn = true;
  var _storage = const FlutterSecureStorage();
  var _username = "";
  var _password = "";

  @override
  void initState() {
    final auth = AuthService();

    auth.checkLogin().then((value) => {
          setState(() {
            loggedIn = value;
            _storage = auth.getStorageVar();
          })
        });
    super.initState();
  }

  void getUserDetails() {}

  Future<void> sendLogin(String username, String password) async {
    var jsonUser = jsonEncode({'username': username, 'password': password});
    log(jsonUser);
    var resp = await http.post(Uri.parse(urlPrefix + 'token-auth/'),
        body: jsonUser, headers: {'Content-Type': 'application/json'});

    if (resp.statusCode == 200) {
      var response = jsonDecode(utf8.decode(resp.bodyBytes));
      final token = response['token'];

      final userMap = response['user'];

      await _storage.write(key: 'token', value: token);
      await _storage.write(key: 'username', value: userMap['username']);
      await _storage.write(key: 'id', value: userMap['id'].toString());

      setState(() {
        loggedIn = true;
      });
    } else {
      setState(() {
        loggedIn = false;
      });
      ;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.all(10),
            height: 60,
            width: 60,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/logo.png'),
                    fit: BoxFit.cover)),
          ),
          Text(loggedIn ? "You are already logged in" : "Please Log in"),
          Container(
              margin: const EdgeInsets.all(10),
              color: Colors.transparent,
              child: TextField(
                controller: nameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  hintText: "Enter Username",
                  labelText: "Username",
                ),
              )),
          Container(
              margin: const EdgeInsets.all(10),
              child: TextField(
                obscureText: true,
                controller: passwordController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    hintText: "Passoword",
                    labelText: "Password"),
              )),
          TextButton(
            style: TextButton.styleFrom(
                primary: Colors.white,
                backgroundColor: Colors.indigo[900]!,
                elevation: 0,
                side: const BorderSide(width: 0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20))),
            onPressed: () {
              if (nameController.text.isNotEmpty &&
                  passwordController.text.isNotEmpty) {
                sendLogin(nameController.text, passwordController.text);
                if (loggedIn) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Main()));
                }
              }
            },
            child: const Text("Login"),
          ),
          Container(
            margin: const EdgeInsets.only(top: 15),
            child: const Text("Don't have an account ?"),
          ),
          TextButton(
            style: TextButton.styleFrom(
              primary: Colors.yellow[800],
            ),
            onPressed: () {
              Navigator.pushNamed(
                context,
                '/register',
              );
            },
            child: const Text("Register"),
          ),
        ],
      ),
    );
  }
}
