class SignupResponseModel {
  String? message;
  int? userId;

  SignupResponseModel({
    this.message,
    this.userId,
  });

  // Converts a SignupResponseModel instance to a Map (JSON) format.
  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'userId': userId,
    };
  }

  // Creates a SignupResponseModel instance from a Map (JSON) format.
  factory SignupResponseModel.fromJson(Map<String, dynamic> json) {
    return SignupResponseModel(
      message: json['message'],
      userId: json['userId'],
    );
  }
}
