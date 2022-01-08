import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:boipoka_mobile/services/auth_service.dart';
import 'package:boipoka_mobile/vars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AddListing extends StatefulWidget {
  const AddListing({Key? key}) : super(key: key);

  @override
  _AddListingState createState() => _AddListingState();
}

class _AddListingState extends State<AddListing> {
  static const _storage = FlutterSecureStorage();
  final contentController = TextEditingController();
  final urlPrefix = Vars().getBaseUrl();

  static List<dynamic> authorList = [];
  static List<dynamic> bookList = [];

  List<DropdownMenuItem> authorList2 = [];
  Map<String, dynamic> bookList2 = {};

  String? authorDropDown;
  String? bookDropDown;
  String content = "";

  void initState() {
    // final auth = AuthService();
    // auth.checkLogin();
    getAuthorsAndBooks();
  }

  Future<bool> getAuthorsAndBooks() async {
    try {
      Uri authorUrl = Uri.parse(urlPrefix + 'api/authors/');
      Uri booksUrl = Uri.parse(urlPrefix + 'api/books/');
      final token = await _storage.read(key: 'token');

      final authorResponse = await http.get(authorUrl, headers: {
        HttpHeaders.authorizationHeader: 'JWT $token',
        HttpHeaders.contentTypeHeader: 'application/json',
      });

      var decodedAuthorResponse =
          jsonDecode(utf8.decode(authorResponse.bodyBytes));
      decodedAuthorResponse.forEach((author) {
        setState(() {
          authorList.add(author['name'].toString());
        });
      });

      final booksResponse = await http.get(booksUrl, headers: {
        HttpHeaders.authorizationHeader: 'JWT $token',
        HttpHeaders.contentTypeHeader: 'application/json',
      });

      var decodedBookResponse =
          jsonDecode(utf8.decode(booksResponse.bodyBytes));

      decodedBookResponse.forEach((book) {
        setState(() {
          bookList.add(book['title'].toString());
        });
      });

      if (authorResponse.statusCode == 200 && booksResponse.statusCode == 200) {
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
              value: bookDropDown,
              items: bookList.map<DropdownMenuItem<String>>((dynamic value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? value) {
                setState(() {
                  bookDropDown = value!;
                  //   bookDropDown = bookList
                  //       .indexWhere((element) => element == value)
                  //       .toString();
                  log(bookList
                      .indexWhere((element) => element == value)
                      .toString());
                });
              },
            )),
        Container(
            margin: const EdgeInsets.all(10),
            color: Colors.transparent,
            child: DropdownButton(
              value: authorDropDown,
              items: authorList.map<DropdownMenuItem<String>>((dynamic value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? value) {
                setState(() {
                  authorDropDown = value!;
                  // authorDropDown = authorList
                  //     .indexWhere((element) => element == value)
                  //     .toString();
                  log(authorList
                      .indexWhere((element) => element == value)
                      .toString());
                });
              },
            )),
        // Container(
        //     margin: const EdgeInsets.all(10),
        //     child: TextField(
        //       maxLines: 10,
        //       controller: contentController,
        //       decoration: InputDecoration(
        //           border: OutlineInputBorder(
        //             borderRadius: BorderRadius.circular(30),
        //           ),
        //           labelText: "Share Something!"),
        //     )),
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
              // if (contentController.text.isNotEmpty) {
              content = contentController.text;
              // bool created = false;
              // getAuthorsAndBooks();
              //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              //       action: SnackBarAction(
              //         label: "Go Back",
              //         onPressed: () {
              //           Navigator.popAndPushNamed(context, '/');
              //         },
              //       ),
              //       content: created
              //           ? const Text('Failed To Post!')
              //           : const Text('Posted !')));
              // }
            },
            child: const Text("Share!"),
          ),
        )
      ],
    );
  }
}
