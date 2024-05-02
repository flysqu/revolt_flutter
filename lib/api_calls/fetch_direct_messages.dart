import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>?> fetchUser(String token) async {
  var headers = {
    'x-session-token': token
  };
  var request = http.Request('GET', Uri.parse('https://api.revolt.chat/users/dms'));
  
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
