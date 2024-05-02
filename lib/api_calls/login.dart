import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>?> login(String password, String email) async {
  
  var headers = {
    'Content-Type': 'application/json'
  };
  var request = http.Request('POST', Uri.parse('https://api.revolt.chat/auth/session/login'));
  request.body = json.encode({
    "friendly_name": "RevoltFlow",
    "password": "G%v\$2JJWeiQb\$G",
    "email": email
  });
  request.headers.addAll(headers);
  
  http.StreamedResponse response = await request.send();
  
  if (response.statusCode == 200) {
    // Parse JSON from the response body
    String responseBody = await response.stream.bytesToString();
    return json.decode(responseBody);
  }
  else {
    // If an error occurred, return null
    return null;
  }
}