// import 'package:dio/dio.dart';
// import 'package:neomeet/src/features/auth/data/model/signup_request_model.dart';
// import 'package:neomeet/src/features/auth/data/model/signup_response_model.dart';
// import 'package:retrofit/retrofit.dart';
//
// part 'auth_remote_data_source.g.dart'; // Generated file
//
// @RestApi(baseUrl: "http://localhost:3000/api")
// abstract class AuthRemoteDataSource {
//   factory AuthRemoteDataSource(Dio dio, {String baseUrl}) =
//       _AuthRemoteDataSource;
//
//   /// Signup endpoint
//   @POST("/users")
//   Future<SignupResponseModel> signup(
//     @Body() SignupRequestModel signupRequest,
//     // Request body
//   );
//
//   /// Login endpoint with basic authentication
//   @POST("/login")
//   Future<void> login(
//     @Header("Authorization") String authorization,
//     // For Basic Auth header
//     @Body() Map<String, dynamic> loginRequest, // Request body
//   );
//
//   /// Logout endpoint
//   @POST("/logout")
//   Future<void> logout(
//     @Header("Authorization") String token,
//     // Bearer Token for auth
//   );
// }

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:neomeet/src/core/database/local/shared_preference/shared_preference_keys.dart';
import 'package:neomeet/src/core/database/local/shared_preference/shared_preference_manager.dart';
import 'package:neomeet/src/core/network/responses/failure_response.dart';
import 'package:neomeet/src/core/network/responses/success_response.dart';
import 'package:neomeet/src/core/utils/logger/logger.dart';
import 'package:neomeet/src/features/auth/data/model/get_user_by_id_response_model.dart';
import 'package:neomeet/src/features/auth/data/model/is_logged_in_response_model.dart';
import 'package:neomeet/src/features/auth/data/model/login_response_model.dart';
import 'package:neomeet/src/features/auth/data/model/signup_response_model.dart';
import 'package:neomeet/src/features/profile/data/model/user_model.dart';
import 'package:neomeet/src/shared/dependency_injection/dependency_injection.dart';

class AuthRemoteDataSource {
  final dio = Dio();
  Map<String, String> commonHeader = {
    "Content-type": "application/json",
    "Accept": "application/json"
  };

  Future<Either<Failure, SignupResponseModel>> signup(
      {required String url, required Map<String, dynamic> data}) async {
    Failure failure = Failure(message: "");
    Success success = Success(message: "");
    try {
      Response response = await dio.post(url,
          data: data,
          options: Options(
            headers: commonHeader,
            contentType: "application/json",
          ));
      final statusCode = response.statusCode ?? -1;
      if (statusCode >= 200 && statusCode < 300) {
        debug(response.data);

        final signupResponseModel = SignupResponseModel.fromJson(response.data);
        return Right(signupResponseModel);
      } else {
        failure = Failure(message: response.data);
        return Left(failure);
      }
    } catch (e) {
      failure = Failure(message: e.toString());
      return Left(failure);
    }
  }

  Future<Either<Failure, LoginResponseModel>> login(
      {required String url, required Map<String, dynamic> data}) async {
    Failure failure = Failure(message: "");
    Success success = Success(message: "");
    try {
      Response response = await dio.post(url,
          data: data,
          options: Options(
            headers: commonHeader,
            contentType: "application/json",
          ));
      final statusCode = response.statusCode ?? -1;
      if (statusCode >= 200 && statusCode < 300) {
        debug(response.data);

        final loginResponseModel = LoginResponseModel.fromJson(response.data);
        return Right(loginResponseModel);
      } else {
        failure = Failure(message: response.data);
        return Left(failure);
      }
    } catch (e) {
      failure = Failure(message: e.toString());
      return Left(failure);
    }
  }

  Future<Either<Failure, IsLoggedInResponseModel>> isLoggedIn(
      {required String url}) async {
    Failure failure = Failure(message: "");
    Success success = Success(message: "");
    SharedPreferenceManager sharedPreferenceManager =
        sl.get<SharedPreferenceManager>();
    String token =
        sharedPreferenceManager.getValue(key: SharedPreferenceKeys.JWT_TOKEN);
    if (token == "") {
      failure.message = "User not logged in";
      return Left(failure);
    }
    try {
      Response response = await dio.get(url,
          // data: data,
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
              'Accept': 'application/json',
            },
            contentType: "application/json",
          ));
      final statusCode = response.statusCode ?? -1;
      if (statusCode >= 200 && statusCode < 300) {
        debug(response.data.toString());
        IsLoggedInResponseModel isLoggedInResponseModel =
            IsLoggedInResponseModel.fromJson(response.data);
        success.message = isLoggedInResponseModel.message ?? "";
        return Right(isLoggedInResponseModel);
      } else {
        failure = Failure(message: response.data);
        return Left(failure);
      }
    } catch (e) {
      failure = Failure(message: e.toString());
      return Left(failure);
    }
  }

  Future<Either<Failure, UserModel>> getUserById({required String url}) async {
    Failure failure = Failure(message: "");
    Success success = Success(message: "");
    try {
      Response response = await dio.get(url,
          options: Options(
            headers: commonHeader,
            contentType: "application/json",
          ));
      final statusCode = response.statusCode ?? -1;
      if (statusCode >= 200 && statusCode < 300) {
        debug(response.data);

        GetUserByIdResponseModel getUserByIdResponseModel =
            GetUserByIdResponseModel.fromJson(response.data);
        UserModel userModel = UserModel()
          ..name = getUserByIdResponseModel.name
          ..email = getUserByIdResponseModel.email
          ..timezone = getUserByIdResponseModel.timezone
          ..userId = getUserByIdResponseModel.userId
          ..organizationName = getUserByIdResponseModel.organizationName;
        return Right(userModel);
      } else {
        failure = Failure(message: response.data);
        return Left(failure);
      }
    } catch (e) {
      failure = Failure(message: e.toString());
      return Left(failure);
    }
  }
}
