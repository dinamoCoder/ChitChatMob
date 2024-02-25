class SingUpRequest {
  final String? logo;
  final String? githubUserName;
  final String? githubPassword;
  final String? number;
  const SingUpRequest(
      {this.logo, this.githubUserName, this.githubPassword, this.number});
  Map<String, dynamic> toJson() {
    return {
      'Logo': logo,
      'UserName': githubUserName,
      'Password': githubPassword,
      'Number': number
    };
  }
}
