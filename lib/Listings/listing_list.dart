import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:boipoka_mobile/Listings/add_listing.dart';
import 'package:boipoka_mobile/Listings/listing.dart';
import 'package:boipoka_mobile/Listings/listing_card.dart';

import 'package:boipoka_mobile/services/auth_service.dart';
import 'package:boipoka_mobile/vars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class ListingList extends StatefulWidget {
  const ListingList({Key? key}) : super(key: key);

  @override
  _ListingListState createState() => _ListingListState();
}

class _ListingListState extends State<ListingList> {
  final urlPrefix = Vars().getBaseUrl();
  final _storage = const FlutterSecureStorage();
  bool isLoggedIn = true;
  List<ListingCard> allListings = [];
  bool createListing = false;

  @override
  void initState() {
    var auth = AuthService();
    auth.checkLogin().then((value) => {
          setState(() {
            isLoggedIn = value;
          })
        });
    if (isLoggedIn) {
      getRequest();
    }
    createListing = false;
    super.initState();
  }

  var text = "";

  Future<void> getRequest() async {
    try {
      final token = await _storage.read(key: "token");
      final url = Uri.parse('$urlPrefix/api/listings/');

      var response = await http.get(url, headers: {
        HttpHeaders.authorizationHeader: 'JWT $token',
        HttpHeaders.contentTypeHeader: 'application/json',
      });

      var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes));
      List<ListingCard> temp = [];
      decodedResponse.forEach((listing) {
        temp.add(ListingCard(Listing.fromJson(listing)));
      });
      setState(() {
        allListings = temp;
      });
    } catch (e) {
      log('exception: $e');
      text = '$e';
    }
  }

  String getText() {
    return text;
  }

  @override
  Widget build(BuildContext context) {
    return !isLoggedIn
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("You are not logged in!"),
              TextButton(
                  onPressed: () {
                    Navigator.popAndPushNamed(context, '/login');
                  },
                  child: const Text("Login"))
            ],
          )
        : RefreshIndicator(
            backgroundColor: Colors.indigo[900],
            color: Colors.yellow[700],
            triggerMode: RefreshIndicatorTriggerMode.onEdge,
            onRefresh: () async {
              getRequest();
            },
            child: Scaffold(
                floatingActionButton: Container(
                    margin: const EdgeInsets.only(bottom: 50),
                    child: FloatingActionButton(
                      elevation: 5,
                      focusColor: Colors.yellow[900],
                      isExtended: true,
                      backgroundColor: Colors.yellow[700],
                      onPressed: () {
                        setState(() {
                          createListing = !createListing;
                        });
                      },
                      child: createListing
                          ? const Icon(Icons.arrow_back)
                          : const Icon(Icons.add_business),
                    )),
                body: createListing
                    ? const AddListing()
                    : SingleChildScrollView(
                        child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: allListings,
                      ))));
  }
}
