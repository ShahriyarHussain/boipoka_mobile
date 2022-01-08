import 'dart:developer';
import 'dart:io';

import 'package:boipoka_mobile/vars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AddPost extends StatefulWidget {
  const AddPost({Key? key}) : super(key: key);

  @override
  _AddPostState createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  static const _storage = FlutterSecureStorage();
  final contentController = TextEditingController();
  final urlPrefix = Vars().getBaseUrl();
  static List<String> dropdownList = [
    'Is Having A Sale',
    'Is Performing A Giveaway',
    'Shared A Post!',
    'Has Shared A Book Review!',
    'Is Reading A New Book!'
  ];

  String dropdownValue = dropdownList[2];
  String content = "";

  Future<bool> createPost(String postType, String content) async {
    try {
      final userId = await _storage.read(key: "id");
      Uri url = Uri.parse(urlPrefix + 'api/posts/');
      final token = await _storage.read(key: 'token');

      final response = await http.post(url, headers: {
        HttpHeaders.authorizationHeader: 'JWT $token',
      }, body: {
        'content': content,
        'post_type': postType,
        'author': userId,
      });
      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log("Exception: $e");
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            margin: const EdgeInsets.all(10),
            color: Colors.transparent,
            child: DropdownButton(
              value: dropdownValue,
              items: dropdownList.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  dropdownValue = newValue!;
                });
              },
            )),
        Container(
            margin: const EdgeInsets.all(10),
            child: TextField(
              maxLines: 10,
              controller: contentController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  labelText: "Share Something!"),
            )),
        Padding(
          padding: const EdgeInsets.all(5),
          child: TextButton(
            style: TextButton.styleFrom(
                primary: Colors.white,
                backgroundColor: Colors.indigo[900]!,
                elevation: 0,
                side: const BorderSide(width: 0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20))),
            onPressed: () {
              if (contentController.text.isNotEmpty) {
                content = contentController.text;
                bool created = false;
                createPost(dropdownValue, content)
                    .then((value) => created = value);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    action: SnackBarAction(
                      label: "Go Back",
                      onPressed: () {
                        Navigator.popAndPushNamed(context, '/');
                      },
                    ),
                    content: created
                        ? const Text('Failed To Post!')
                        : const Text('Posted !')));
              }
            },
            child: const Text("Share!"),
          ),
        )
      ],
    );
  }
}
