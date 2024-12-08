class SignupDto {
  String name;
  String email;
  String password;
  String timeZone;
  String? organizationName;

  SignupDto(
      {required this.email,
      required this.password,
      required this.name,
      required this.timeZone,
      this.organizationName = ""});
}
