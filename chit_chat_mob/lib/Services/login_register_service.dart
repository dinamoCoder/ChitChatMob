import 'dart:convert';
import 'package:chit_chat_mob/Models/Request/Login_Request.dart';
import 'package:chit_chat_mob/Models/Request/signup_reuqest.dart';
import 'package:chit_chat_mob/Models/Response/Login_Response.dart';
import 'package:chit_chat_mob/Models/Response/signup_response.dart';
import 'package:chit_chat_mob/Services/custom_http_request.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginRegisterService {
  final HttpClientRequest<LoginRequest, LoginResponse> httpClientRequest;
  LoginRegisterService(this.httpClientRequest);

// the user name will be displyed in next phase.
  // static const String _isLoggedInUserInformationKey =
  //     'isLoggedInUserInformation';
  static const String _isLoggedInKey = 'isLoggedInUser';
// this is a asychronous function because we will use the Future keyword
  Future<LoginResponse> loginRequest(LoginRequest loginRequest) async {
    // then we will convert the response that we get
    var loginResponse =
        await httpClientRequest.post(loginRequest.toJson(), "/api/login");
    if (loginResponse.statusCode == 200) {
      // then we will login the user
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_isLoggedInKey, true);
      // await prefs.setString(
      //     _isLoggedInUserInformationKey, jsonEncode(loginResponse.body));
    }
    return fromjson(jsonDecode(loginResponse.body));
  }

  Future<SingUpResponse> singUpRequest(SingUpRequest signUpRequest) async {
    // then we will convert the response that we get
    var signUpResponse =
        await httpClientRequest.post(signUpRequest.toJson(), "/register");
    return fromsignUpjson(jsonDecode(signUpResponse.body));
  }

// Check if the user is already logged in
  static Future<bool> isLoggedIn() async {
    //Loads and parses the [SharedPreferences] for this app from disk.
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isLoggedInKey) ?? false;
  }

// Log out the user from the app.
  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isLoggedInKey, false);
  }

  // here we will get the user name from the secured pereference....
  // static Future<String> getUserName() async {
  //   //Loads and parses the [SharedPreferences] for this app from disk.
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   return prefs.getString(_isLoggedInUserInformationKey) ?? "";
  // }

  LoginResponse fromjson(Map<String, dynamic> json) {
    return LoginResponse(
        refreshToken: json['RefreshToken'],
        token: json['Token'],
        errorMessage: json['ErrorMessage']);
  }

  SingUpResponse fromsignUpjson(Map<String, dynamic> json) {
    return SingUpResponse(
        email: json['email'],
        userName: json['userName'],
        success: json['success'],
        message: json['message']);
  }
}
