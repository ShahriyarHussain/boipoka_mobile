import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:boipoka_mobile/Listings/listing.dart';
import 'package:boipoka_mobile/Listings/listing_card.dart';
import 'package:boipoka_mobile/community/post_card.dart';
import 'package:boipoka_mobile/services/auth_service.dart';
import 'package:boipoka_mobile/vars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:boipoka_mobile/community/post.dart';

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
      // log(decodedResponse.toString());
      decodedResponse.forEach((listings) {
        // Map<String, dynamic> oneListing = listings;
        // oneListing.forEach((key, value) {
        //   log("$key : $value");
        // });
        // Listing newListing = Listing.fromJson(listings);
        setState(() {
          allListings.add(ListingCard(Listing.fromJson(listings)));
        });
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
        : SingleChildScrollView(
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: allListings,
          ));
  }
}
