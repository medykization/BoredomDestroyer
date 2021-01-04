import 'package:flutter_project/models/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class HttpAuth {
  static const signInURL =
      'https://boredom-server.herokuapp.com/authentication/login';
  static const refreshTokenURL =
      'https://boredom-server.herokuapp.com/authentication/refresh';
  static const signUpURL =
      'https://boredom-server.herokuapp.com/authentication/registration';

  Future<User> signIn(String username, String password) async {
    Map userMap = {'name': username, 'password': password};
    String body = convert.json.encode(userMap);

    try {
      http.Response response = await http.post(signInURL,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: body);

      print(response.statusCode);

      Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);
      User result = new User(
          name: username,
          accessToken: jsonResponse['accessToken'],
          refreshToken: jsonResponse['refreshToken']);

      return result;
    } on FormatException {
      return null;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<User> signUp(String username, String email, String password) async {
    Map userMap = {'name': username, 'email': email, 'password': password};
    String body = convert.json.encode(userMap);

    try {
      http.Response response = await http.post(signUpURL,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: body);

      Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);
      User result = new User(
          name: username,
          accessToken: jsonResponse['accessToken'],
          refreshToken: jsonResponse['refreshToken']);

      return result;
    } on FormatException {
      return null;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<String> refreshToken(User user) async {
    Map userMap = {'token': user.refreshToken};
    String body = convert.json.encode(userMap);

    try {
      http.Response response = await http.post(refreshTokenURL,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: body);

      Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);
      String result = jsonResponse['accessToken'];

      return result;
    } on FormatException {
      return null;
    } catch (e) {
      throw Exception(e);
    }
  }
}
