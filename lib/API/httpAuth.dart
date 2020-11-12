import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class HttpAuth {
  static const signInURL =
      'https://boredom-server.herokuapp.com/authentication/login';

  Future<String> signIn(String username, String password) async {
    Map userMap = {'name': username, 'password': password};

    String body = convert.json.encode(userMap);

    try {
      http.Response response = await http.post(signInURL,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: body);

      Map<String, dynamic> jsonResponse = convert.jsonDecode(response.body);
      String test = jsonResponse['accessToken'];

      if (test == null) return "result error";

      return test;
    } on FormatException {
      return null;
    } catch (e) {
      throw Exception(e);
    }
  }
}
