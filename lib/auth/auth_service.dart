import 'dart:convert';
import 'package:http/http.dart';
import 'user.dart';

class AuthService {
  final urlPrefix = 'http://10.0.2.2:8000';

  // Future<List<User>> sendRegistration(User user) async {
  //   Response resp = await get(Uri.parse(urlPrefix+'/users/'));

  //   if (resp.statusCode == 200) {
  //     List<dynamic> body = jsonEncode(user);
  //   }
  // }
}
