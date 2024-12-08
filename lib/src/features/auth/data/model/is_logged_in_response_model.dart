import 'package:neomeet/src/features/profile/data/model/user_model.dart';

class IsLoggedInResponseModel {
  String? message;
  UserModel? user;

  IsLoggedInResponseModel({
    this.message,
    this.user,
  });

  // Converts an IsLoggedInResponseModel instance to a Map (JSON) format.
  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'user': user?.toJson(),
    };
  }

  // Creates an IsLoggedInResponseModel instance from a Map (JSON) format.
  factory IsLoggedInResponseModel.fromJson(Map<String, dynamic> json) {
    return IsLoggedInResponseModel(
      message: json['message'],
      user: json['user'] != null ? UserModel.fromJson(json['user']) : null,
    );
  }
}
