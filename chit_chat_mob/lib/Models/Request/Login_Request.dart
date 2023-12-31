// ignore: file_names
class LoginRequest {
  // ignore: non_constant_identifier_names
  final String userName;
  // ignore: non_constant_identifier_names
  final String password;
  LoginRequest(this.userName, this.password);

  Map<String, dynamic> toJson() {
    return {
      'UserName': userName,
      'Password': password,
    };
  }
}
