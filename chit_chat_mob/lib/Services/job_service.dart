import 'dart:convert';

import 'package:chit_chat_mob/Models/Response/Job_Post.dart';
import 'package:chit_chat_mob/Models/Response/Login_Response.dart';
import 'package:chit_chat_mob/Services/custom_http_request.dart';
import 'package:chit_chat_mob/Services/login_register_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class JobService {
  HttpClientRequest? _httpClientRequest;

  JobService() {
    _httpClientRequest = HttpClientRequest();
  }

  Future<dynamic> scrapJob(String jobUrl) async {
    // we will first get the token from the secured preference...
    SharedPreferences prefs = await SharedPreferences.getInstance();
    LoginResponse? data = LoginRegisterService.fromjson(jsonDecode(
        prefs.getString(LoginRegisterService.isLoogedInData) ?? "{}"));
    // then we will set the header
    final headers = {
      'Authorization': 'Bearer ${data.token}',
    };

    final queryParams = {
      'jobUrl': jobUrl,
    };
    var jobDataResponse =
        await _httpClientRequest?.get("/api/scrapjob", queryParams, headers);
    if (jobDataResponse?.statusCode == 400) {
      var data = JobModel.fromJson(jsonDecode(jobDataResponse?.body ?? "{}"));
      return data;
    }
    return JobModel.fromJson(jsonDecode(jobDataResponse?.body ?? "{}"));
  }
}
