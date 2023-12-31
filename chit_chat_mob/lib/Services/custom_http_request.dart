import 'dart:convert';
import 'package:http/http.dart' as http;

const String _baseAddress =
    "https://70c7-124-253-223-111.ngrok-free.app/";

class HttpClientRequest<T, V> {
  // create the custom post request and it will be used by every method.
  Future<http.Response> post(Map<String,dynamic> data, String path) {
    return http.post(Uri.parse(_baseAddress + path),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(data));
  }
}
