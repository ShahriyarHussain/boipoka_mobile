import 'package:boipoka_mobile/Routes/post_list_route.dart';
import 'package:boipoka_mobile/navbar.dart';
import 'package:flutter/material.dart';
import 'community/post_list.dart';
import 'auth/login.dart';
import 'auth/register.dart';

void main() {
  runApp(const AppMain());
}

class AppMain extends StatelessWidget {
  const AppMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Root widget',
      initialRoute: '/',
      routes: {
        '/postList': (context) => const PostListRoute(),
      },
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text('Boipoka'),
          centerTitle: true,
        ),
        bottomNavigationBar: Navbar(),
        body: const Center(
          child: Login(),
        ),
      ),
    );
  }
}
