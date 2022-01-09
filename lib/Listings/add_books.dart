import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class AddBooks extends StatefulWidget {
  const AddBooks({Key? key}) : super(key: key);

  @override
  _AddBooksState createState() => _AddBooksState();
}

class _AddBooksState extends State<AddBooks> {
  final isbnController = TextEditingController();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final priceController = TextEditingController();
  final pagesController = TextEditingController();
  final editionController = TextEditingController();

  Future<Map<String, dynamic>?> getBookDetails(isbn) async {
    Uri url =
        Uri.parse("https://www.googleapis.com/books/v1/volumes?q=isbn:" + isbn);
    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        final decodedResponse = jsonDecode(utf8.decode(response.bodyBytes));

        Map<String, dynamic> books = decodedResponse['items'][0]['volumeInfo'];

        return books;
      } else {
        log(response.statusCode.toString());
        return null;
      }
    } catch (e) {
      log("error: $e");
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 20, bottom: 10),
            child: const Text(
                "If you have 10 digit ISBN add 978 at the beginning"),
          ),
          Container(
              margin: const EdgeInsets.all(5),
              child: TextField(
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                keyboardType: TextInputType.number,
                controller: isbnController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    hintText: "e.g. 97828394393",
                    labelText: "13 Digit ISBN"),
              )),
          TextButton(
              onPressed: () async {
                if (isbnController.text.isNotEmpty) {
                  Map<String, dynamic>? bookDetails = {};
                  await getBookDetails(isbnController.text).then((value) => {
                        if (value != null)
                          {bookDetails.addAll(value)}
                        else
                          {titleController.text = "Not Found!"}
                      });
                  log(bookDetails.toString());
                  try {
                    titleController.text = bookDetails['title'].toString();
                    descriptionController.text =
                        bookDetails['description'].toString();
                    pagesController.text = bookDetails['pageCount'].toString();
                    editionController.text =
                        bookDetails['publishedDate'].toString();
                  } catch (e) {
                    log("Btn exception: $e");
                  }
                }
              },
              child: const Text("Search Book"),
              style: TextButton.styleFrom(
                  primary: Colors.white,
                  backgroundColor: Colors.indigo[900]!,
                  elevation: 0,
                  side: const BorderSide(width: 0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)))),
          Container(
              margin: const EdgeInsets.only(
                  top: 10, left: 10, right: 10, bottom: 0),
              child: TextField(
                keyboardType: TextInputType.text,
                controller: titleController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    hintText: "e.g. Dune",
                    labelText: "Title"),
              )),
          Container(
              margin: const EdgeInsets.only(
                  top: 10, left: 10, right: 10, bottom: 10),
              child: TextField(
                keyboardType: TextInputType.text,
                controller: descriptionController,
                maxLines: 10,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    hintText: "e.g. An Exciting Book",
                    labelText: "Description"),
              )),
          Container(
              margin: const EdgeInsets.only(
                  top: 10, left: 10, right: 10, bottom: 10),
              child: TextField(
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                keyboardType: TextInputType.number,
                controller: priceController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    hintText: "e.g. 530",
                    labelText: "Price(BDT)"),
              )),
          Container(
              margin: const EdgeInsets.only(
                  top: 10, left: 10, right: 10, bottom: 10),
              child: TextField(
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                keyboardType: TextInputType.number,
                controller: pagesController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    hintText: "e.g. 135",
                    labelText: "Pages"),
              )),
          Container(
              margin: const EdgeInsets.only(
                  top: 10, left: 10, right: 10, bottom: 10),
              child: TextField(
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                keyboardType: TextInputType.number,
                controller: editionController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    hintText: "e.g. 2005",
                    labelText: "Publish Year"),
              )),
          Container(
            margin: const EdgeInsets.only(bottom: 80, top: 10),
            child: TextButton(
                onPressed: () {},
                child: const Text("Add Book"),
                style: TextButton.styleFrom(
                    primary: Colors.indigo[900],
                    backgroundColor: Colors.amber[600]!,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)))),
          ),
        ],
      ),
    );
  }
}
