import 'package:boipoka_mobile/main.dart';
import 'package:flutter/material.dart';

class AddPage extends StatefulWidget {
  const AddPage({Key? key}) : super(key: key);

  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  int postBg = 200;
  int listBg = 100;

  final addPages = const <Widget>[];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.all(10),
          child: TextButton(
              style: TextButton.styleFrom(
                  backgroundColor: Colors.amber[postBg * 100]),
              onPressed: () {
                setState(() {
                  listBg = 1;
                  postBg = 2;
                });
              },
              child: const Text("Add Post")),
        ),
        Container(
          margin: const EdgeInsets.all(10),
          child: TextButton(
              style: TextButton.styleFrom(
                  backgroundColor: Colors.amber[listBg * 200]),
              onPressed: () {
                setState(() {
                  listBg = 2;
                  postBg = 1;
                });
              },
              child: const Text("Add Listing")),
        )
      ],
    );
  }
}
