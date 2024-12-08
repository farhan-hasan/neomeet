class LoginRequestModel {
  String? email;
  String? password;

  LoginRequestModel({
    this.email,
    this.password,
  });

  // Converts a LoginRequestBody instance to a Map (JSON) format.
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }

  // Creates a LoginRequestBody instance from a Map (JSON) format.
  factory LoginRequestModel.fromJson(Map<String, dynamic> json) {
    return LoginRequestModel(
      email: json['email'],
      password: json['password'],
    );
  }
}
