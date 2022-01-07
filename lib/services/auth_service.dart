import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:boipoka_mobile/vars.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AuthService {
  final urlPrefix = Vars().getBaseUrl();

  final _storage = const FlutterSecureStorage();

  Future<bool> checkLogin() async {
    // _storage.delete(key: "first_name");
    // _storage.delete(key: "last_name");
    // _storage.delete(key: "email");
    Map<String, String> data = await _storage.readAll();

    if (data.isEmpty) {
      return false;
    } else if (data.containsKey("token")) {
      var token = data["token"];
      var url = Uri.parse(urlPrefix + 'users/current_user');

      var response = await http.get(url, headers: {
        HttpHeaders.authorizationHeader: 'JWT $token',
        HttpHeaders.contentTypeHeader: 'application/json',
      });

      if (response.statusCode == 200) {
        // log("decodedResponse");
        var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes));
        decodedResponse.forEach((key, value) {
          if (key == "id" || key == "token" || key == "username") {
            _storage.write(key: key, value: value.toString());
          }
        });

        // Map<String, String> data = await _storage.readAll();
        // data.forEach((key, value) {
        //   log("$key: $value");
        // });

        return true;
      } else {
        log(response.statusCode.toString() + " " + response.body);
        return false;
      }
    } else {
      return false;
    }
  }

  FlutterSecureStorage getStorageVar() {
    return _storage;
  }
}
