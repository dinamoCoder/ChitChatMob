import 'dart:convert';
import 'package:chit_chat_mob/Models/Request/Login_Request.dart';
import 'package:chit_chat_mob/Models/Request/signup_reuqest.dart';
import 'package:chit_chat_mob/Models/Response/Login_Response.dart';
import 'package:chit_chat_mob/Models/Response/signup_response.dart';
import 'package:chit_chat_mob/Services/custom_http_request.dart';

class LoginRegisterService {
  final HttpClientRequest<LoginRequest, LoginResponse> httpClientRequest;
  LoginRegisterService(this.httpClientRequest);

  Future<LoginResponse> loginRequest(LoginRequest loginRequest) async {
    // then we will convert the response that we get
    var loginResponse =
        await httpClientRequest.post(loginRequest.toJson(), "api/login");
    return fromjson(jsonDecode(loginResponse.body));
  }

  Future<SingUpResponse> singUpRequest(SingUpRequest signUpRequest) async {
    // then we will convert the response that we get
    var signUpResponse =
        await httpClientRequest.post(signUpRequest.toJson(), "register");
    return fromsignUpjson(jsonDecode(signUpResponse.body));
  }

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
