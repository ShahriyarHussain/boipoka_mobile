// import 'dart:html';

import 'dart:developer';

import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _fnameController = TextEditingController();
  final _lnameController = TextEditingController();
  final _unameController = TextEditingController();
  final _password1Controller = TextEditingController();
  final _password2Controller = TextEditingController();

  var _fname = "";
  var _lname = "";
  var _uname = "";
  var _password1 = "";
  var _password2 = "";

  final _errorMessages = [
    "",
    "",
    "",
    "",
    "",
  ];

  lengthChecker(String text, int field) {
    if (text.length < 4 || text.length > 20) {
      setState(() {
        _errorMessages[field] =
            "Must be greater than 3 and less than 20 characters";
      });
    } else {
      setState(() {
        _errorMessages[field] = "";
      });
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
          ElevatedButton(
            onPressed: () {
              setState(() {
                _uname = _unameController.text;
                _fname = _fnameController.text;
                _lname = _lnameController.text;
                _password1 = _password1Controller.text;
                _password2 = _password2Controller.text;
              });
            },
            child: const Text("Register"),
          ),
          Container(
              margin: const EdgeInsets.only(top: 20),
              child: Text(
                _fname +
                    " " +
                    _lname +
                    "\n" +
                    _uname +
                    "\n" +
                    _password1 +
                    " " +
                    _password2 +
                    "\n",
              ))
        ],
      ),
    );
  }
}
