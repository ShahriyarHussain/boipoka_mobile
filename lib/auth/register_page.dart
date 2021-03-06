import 'dart:async';
import 'package:boipoka_mobile/vars.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _fnameController = TextEditingController();
  final _lnameController = TextEditingController();
  final _unameController = TextEditingController();
  final _password1Controller = TextEditingController();
  final _password2Controller = TextEditingController();

  final urlPrefix = Vars().getBaseUrl();

  // var _fname = "";
  // var _lname = "";
  // var _uname = "";
  // var _password1 = "";
  // var _password2 = "";

  final _errorMessages = [
    "",
    "",
    "",
    "",
    "",
    "",
  ];

  lengthChecker(String text, int field) {
    if (text.length < 3 || text.length > 20) {
      setState(() {
        _errorMessages[field] = "Must be within 3 to 20 characters";
      });
    } else {
      setState(() {
        _errorMessages[field] = "";
      });
    }
  }

  Future<bool> sendRegistration(String firstName, String lastName,
      String userName, String password) async {
    // var jsonUser = jsonEncode(user);
    // log(jsonUser);
    var jsonUser = jsonEncode({
      "user": {
        "first_name": firstName,
        "last_name": lastName,
        "username": userName,
        "password": password,
      }
    });
    log(Uri.parse(urlPrefix + 'users/users/create').toString());

    try {
      final resp = await http.post(Uri.parse(urlPrefix + 'users/users/create'),
          body: jsonUser, headers: {'content-type': 'application/json'});
      if (resp.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log("Exception in register: $e");
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
              margin: const EdgeInsets.all(10),
              child: TextField(
                controller: _fnameController,
                onChanged: lengthChecker(_fnameController.text, 0),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Enter First Name",
                  labelText: "First Name",
                ),
              )),
          Text(
            _errorMessages[0],
            style:
                const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
          ),
          Container(
              margin: const EdgeInsets.all(10),
              child: TextField(
                controller: _lnameController,
                onChanged: lengthChecker(_lnameController.text, 1),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Enter Last Name",
                  labelText: "Last Name",
                ),
              )),
          Text(
            _errorMessages[1],
            style:
                const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
          ),
          Container(
              margin: const EdgeInsets.all(10),
              child: TextField(
                controller: _unameController,
                onChanged: lengthChecker(_unameController.text, 2),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Enter Username",
                  labelText: "Username",
                ),
              )),
          Text(
            _errorMessages[2],
            style:
                const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
          ),
          Container(
              margin: const EdgeInsets.all(10),
              child: TextField(
                obscureText: true,
                controller: _password1Controller,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Enter a password",
                  labelText: "Password",
                ),
              )),
          Container(
              margin: const EdgeInsets.all(10),
              child: TextField(
                obscureText: true,
                controller: _password2Controller,
                onChanged: (String password) {
                  if (_password1Controller.text == password) {
                    setState(() {
                      _errorMessages[4] = "";
                    });
                  } else {
                    setState(() {
                      _errorMessages[4] = "Passwords don't match";
                    });
                  }
                },
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Same as previous field",
                    labelText: "Password Again"),
              )),
          Text(
            _errorMessages[4],
            style:
                const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
          ),
          TextButton(
            style: TextButton.styleFrom(
                primary: Colors.white,
                backgroundColor: Colors.indigo[900]!,
                elevation: 0,
                side: const BorderSide(width: 0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20))),
            onPressed: () async {
              if (_fnameController.text.isNotEmpty &&
                  _lnameController.text.isNotEmpty &&
                  _unameController.text.isNotEmpty &&
                  _password1Controller.text.isNotEmpty &&
                  _password2Controller.text.isNotEmpty) {
                bool success = false;
                await sendRegistration(
                        _fnameController.text,
                        _fnameController.text,
                        _unameController.text,
                        _password1Controller.text)
                    .then((value) => success = value);
                if (success) {
                  Navigator.popAndPushNamed(context, '/login');
                }
              } else {
                setState(() {
                  _errorMessages[4] = "Please fill up all fields";
                });
              }
            },
            child: const Text("Register"),
          ),
          Container(
            margin: const EdgeInsets.only(top: 20),
            child: const Text("Already have an account ?"),
          ),
          TextButton(
            style: TextButton.styleFrom(
              primary: Colors.yellow[800],
            ),
            onPressed: () {
              // Navigator.popAndPushNamed(context, '/login');
              Navigator.popAndPushNamed(context, '/login');
            },
            child: const Text("Login"),
          ),
        ],
      ),
    );
  }
}
