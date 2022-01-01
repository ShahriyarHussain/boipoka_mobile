import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'user.dart';

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
  final urlPrefix = 'http://10.0.2.2:8000/';

  void getUserDetails() {}

  Future<void> sendLogin(String username, String password) async {
    var jsonUser = jsonEncode({'username': username, 'password': password});
    log(jsonUser);
    var resp = await http.post(Uri.parse(urlPrefix + 'token-auth/'),
        body: jsonUser, headers: {'Content-Type': 'application/json'});
    var decodeResponse = jsonDecode(utf8.decode(resp.bodyBytes)) as Map;
    await _storage.write(key: 'token', value: decodeResponse['token']);
    await _storage.write(key: 'username', value: decodeResponse['username']);
    await _storage.write(key: 'id', value: decodeResponse['id']);
    // log('${resp.statusCode}' + "\n" + "\n" + decodeResponse.toString());
    Map<String, String> data = await _storage.readAll();
    data.forEach((key, value) {
      log(key + " : " + value + "\n");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
            margin: const EdgeInsets.all(15),
            color: Colors.red,
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
            sendLogin(nameController.text, passwordController.text);
          },
          child: const Text("Hello"),
        ),
        Container(
          margin: const EdgeInsets.only(top: 20),
          child: Text(_username + " " + _password),
        )
      ],
    );
  }
}
