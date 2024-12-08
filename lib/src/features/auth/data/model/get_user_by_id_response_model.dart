class GetUserByIdResponseModel {
  int? userId;
  String? name;
  String? email;
  String? passwordHash;
  String? timezone;
  String? organizationName;
  String? createdAt;

  GetUserByIdResponseModel({
    this.userId,
    this.name,
    this.email,
    this.passwordHash,
    this.timezone,
    this.organizationName,
    this.createdAt,
  });

  // Converts a GetUserByIdModel instance to a Map (JSON) format.
  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'name': name,
      'email': email,
      'password_hash': passwordHash,
      'timezone': timezone,
      'organization_name': organizationName,
      'created_at': createdAt,
    };
  }

  // Creates a GetUserByIdModel instance from a Map (JSON) format.
  factory GetUserByIdResponseModel.fromJson(Map<String, dynamic> json) {
    return GetUserByIdResponseModel(
      userId: json['user_id'],
      name: json['name'],
      email: json['email'],
      passwordHash: json['password_hash'],
      timezone: json['timezone'],
      organizationName: json['organization_name'],
      createdAt: json['created_at'],
    );
  }
}
