class SingUpRequest {
  final String? logo;
  final String? email;
  final String? userName;
  final String? password;
  final String? number;
  const SingUpRequest(
      {this.logo, this.email, this.userName, this.password, this.number});
  Map<String, dynamic> toJson() {
    return {
      'Logo': logo,
      'Email': email,
      'UserName': userName,
      'Password': password,
      'Number': number
    };
  }
}
