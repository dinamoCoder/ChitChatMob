class SingUpResponse {
  final String? email;
  final String? userName;
  final bool? success;
  final String? message;
  const SingUpResponse(
      {this.email, this.userName, this.success, this.message});
}
