import 'package:flutter/material.dart';

class Homepage extends StatelessWidget {
  // final bool isLoggedIn;
  const Homepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("This is the home page !! If you are not logged in"),
        TextButton(
            onPressed: () {
              Navigator.popAndPushNamed(context, '/login');
            },
            child: const Text("Click Here"))
      ],
    );
  }
}
