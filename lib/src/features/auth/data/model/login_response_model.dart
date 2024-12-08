import 'package:neomeet/src/features/profile/data/model/user_model.dart';

class LoginResponseModel {
  String? message;
  String? token;
  UserModel? user;

  LoginResponseModel({
    this.message,
    this.token,
    this.user,
  });

  // Converts a LoginResponseModel instance to a Map (JSON) format.
  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'token': token,
      'user': user?.toJson(),
    };
  }

  // Creates a LoginResponseModel instance from a Map (JSON) format.
  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      message: json['message'],
      token: json['token'],
      user: json['user'] != null ? UserModel.fromJson(json['user']) : null,
    );
  }
}

// class User {
//   int? userId;
//   String? name;
//   String? email;
//   String? timezone;
//   String? organizationName;
//
//   User({
//     this.userId,
//     this.name,
//     this.email,
//     this.timezone,
//     this.organizationName,
//   });
//
//   // Converts a User instance to a Map (JSON) format.
//   Map<String, dynamic> toJson() {
//     return {
//       'userId': userId,
//       'name': name,
//       'email': email,
//       'timezone': timezone,
//       'organizationName': organizationName,
//     };
//   }
//
//   // Creates a User instance from a Map (JSON) format.
//   factory User.fromJson(Map<String, dynamic> json) {
//     return User(
//       userId: json['userId'],
//       name: json['name'],
//       email: json['email'],
//       timezone: json['timezone'],
//       organizationName: json['organizationName'],
//     );
//   }
// }
