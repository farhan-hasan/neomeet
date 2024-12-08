class UserModel {
  int? userId;
  String? name;
  String? email;
  String? timezone;
  String? organizationName;

  UserModel({
    this.userId,
    this.name,
    this.email,
    this.timezone,
    this.organizationName,
  });

  // Converts a User instance to a Map (JSON) format.
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'name': name,
      'email': email,
      'timezone': timezone,
      'organizationName': organizationName,
    };
  }

  // Creates a User instance from a Map (JSON) format.
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['userId'],
      name: json['name'],
      email: json['email'],
      timezone: json['timezone'],
      organizationName: json['organizationName'],
    );
  }
}
