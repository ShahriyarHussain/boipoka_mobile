import 'package:flutter/material.dart';
import 'community/post_list.dart';

void main() {
  runApp(const AppMain());
}

class AppMain extends StatelessWidget {
  const AppMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text('Boipoka'),
          centerTitle: true,
        ),
        body: const Center(
          child: PostList(),
        ),
      ),
    );
  }
}
