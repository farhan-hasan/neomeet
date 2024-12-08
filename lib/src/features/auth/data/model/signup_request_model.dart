class SignupRequestModel {
  String? name;
  String? email;
  String? passwordHash;

  //String? role;
  String? timeZone;
  String? organizationName;

  SignupRequestModel({
    this.name,
    this.email,
    this.passwordHash,
    // this.role,
    this.timeZone,
    this.organizationName,
  });

  // Converts a SignupRequestModel instance to a Map (JSON) format.
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password_hash': passwordHash,
      // 'role': role,
      'timezone': timeZone,
      'organization_name': organizationName,
    };
  }

  // Creates a SignupRequestModel instance from a Map (JSON) format.
  factory SignupRequestModel.fromJson(Map<String, dynamic> json) {
    return SignupRequestModel(
      name: json['name'],
      email: json['email'],
      passwordHash: json['password_hash'],
      // role: json['role'],
      timeZone: json['timezone'],
      organizationName: json['organization_name'],
    );
  }
}
