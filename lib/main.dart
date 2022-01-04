import 'package:boipoka_mobile/Routes/post_list_route.dart';
import 'package:boipoka_mobile/auth/register.dart';
import 'package:flutter/material.dart';
import 'auth/login.dart';
import 'auth/register.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

void main() {
  runApp(const Main());
}

class Main extends StatefulWidget {
  const Main({Key? key}) : super(key: key);

  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  int _index = 0;

  final items = const <Widget>[
    Icon(
      Icons.home,
      size: 30,
    ),
    Icon(Icons.group, size: 30),
    Icon(Icons.attach_money, size: 30),
    Icon(Icons.bookmark, size: 30),
    Icon(Icons.account_circle, size: 30),
  ];

  final _screens = const <Widget>[
    Login(),
    Register(),
  ];

  @override
  Widget build(BuildContext context) {
    // int _index = 1;
    return MaterialApp(
      title: 'Root widget',
      initialRoute: '/',
      routes: {
        '/postList': (context) => const PostListRoute(),
      },
      home: Scaffold(
        extendBody: true,
        appBar: AppBar(
          backgroundColor: Colors.indigo[900],
          title: const Text('Boipoka'),
          centerTitle: true,
        ),
        bottomNavigationBar: Theme(
            data: Theme.of(context)
                .copyWith(iconTheme: const IconThemeData(color: Colors.white)),
            child: CurvedNavigationBar(
                color: Colors.indigo[900]!,
                buttonBackgroundColor: Colors.yellow[800],
                backgroundColor: Colors.transparent,
                animationCurve: Curves.easeInOut,
                animationDuration: const Duration(milliseconds: 400),
                items: items,
                index: _index,
                height: 50,
                onTap: (index) => setState(() => _index = index))),
        body: _screens[_index],
      ),
    );
  }
}
