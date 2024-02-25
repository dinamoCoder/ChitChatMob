import 'dart:convert';
import 'package:http/http.dart' as http;

const String _baseAddress =
    "https://67d3-124-253-12-133.ngrok-free.app"; //https://b4e7-124-253-13-190.ngrok-free.app

class HttpClientRequest {
  // create the custom post request and it will be used by every method.
  Future<http.Response> post(Map<String, dynamic> data, String path) {
    return http.post(Uri.parse(_baseAddress + path),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(data));
  }

  Future<http.Response> get(String path, Map<String, String> queryParams,
      Map<String, String> headers) async {
    final response = await http.get(
      Uri.parse(_baseAddress + path).replace(queryParameters: queryParams),
      headers: headers,
    );
    return response;
  }
}
