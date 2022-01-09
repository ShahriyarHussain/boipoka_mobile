import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:boipoka_mobile/Listings/add_books.dart';
import 'package:boipoka_mobile/vars.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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

  // static List<dynamic> authorList = [];
  static List<dynamic> bookList = [];

  String? authorDropDown;
  String? bookDropDown;
  String content = "";
  bool addBooks = false;

  @override
  void initState() {
    // final auth = AuthService();
    // auth.checkLogin();
    getAuthorsAndBooks();
    addBooks = false;
    super.initState();
  }

  Future<bool> getAuthorsAndBooks() async {
    try {
      final token = await _storage.read(key: 'token');

      Uri booksUrl = Uri.parse(urlPrefix + 'api/books/');

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

      // Uri authorUrl = Uri.parse(urlPrefix + 'api/authors/');
      // final authorResponse = await http.get(authorUrl, headers: {
      //   HttpHeaders.authorizationHeader: 'JWT $token',
      //   HttpHeaders.contentTypeHeader: 'application/json',
      // });

      // var decodedAuthorResponse =
      //     jsonDecode(utf8.decode(authorResponse.bodyBytes));
      // decodedAuthorResponse.forEach((author) {
      //   setState(() {
      //     authorList.add(author['name'].toString());
      //   });
      // });

      if (booksResponse.statusCode == 200) {
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
    return addBooks
        ? const AddBooks()
        : Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  margin: const EdgeInsets.all(10),
                  color: Colors.transparent,
                  child: DropdownButton(
                    hint: const Text("Book"),
                    value: bookDropDown,
                    items:
                        bookList.map<DropdownMenuItem<String>>((dynamic value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        bookDropDown = value!;
                        // log(bookList
                        //     .indexWhere((element) => element == value)
                        //     .toString());
                      });
                    },
                  )),
              Row(
                children: [
                  Container(
                      margin: const EdgeInsets.only(left: 10, right: 0),
                      child: const Text("Don't see your book here ?")),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        addBooks = !addBooks;
                      });
                    },
                    child: const Text("Add A Book"),
                    style: TextButton.styleFrom(
                      primary: Colors.indigo[900],
                    ),
                  ),
                ],
              ),
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
                  onPressed: () {},
                  child: const Text("Share!"),
                ),
              )
            ],
          );
  }
}
