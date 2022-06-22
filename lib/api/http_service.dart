import 'dart:convert';
import 'dart:io';

import '../model/logged_in_user.dart';

Future<LoggedInUser> login(String username, String password) async {
  //Make HTTP call to authenticate user and get token

  //emulating actual http call by delaying response for 2 secs
  await Future.delayed(Duration(seconds: 2)); // sleep(Duration(seconds: 3));
  const response = '{"token": "dummy token", "refreshToken": "refresh-token", "email": "saurav@jumbo.com", "role": "user"}';
  return LoggedInUser.fromJson(jsonDecode(response));
}