import 'package:flutter/material.dart';

void main() {
  runApp(const Commetn());
}

class Commetn extends StatelessWidget {
  const Commetn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text('hello'),
          centerTitle: true,
        ),
        body: Center(
          child: Text('Zillani'),
        ),
      ),
    );
  }
}
