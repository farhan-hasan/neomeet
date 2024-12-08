// import 'package:dartz/dartz.dart';
// import 'package:neomeet/src/core/config/dio/dio_client.dart';
// import 'package:neomeet/src/core/network/responses/failure_response.dart';
// import 'package:neomeet/src/core/network/responses/success_response.dart';
// import 'package:neomeet/src/features/auth/data/data_source/remote/auth_remote_data_source.dart';
// import 'package:neomeet/src/features/auth/data/model/signup_request_model.dart';
// import 'package:neomeet/src/features/auth/data/model/signup_response_model.dart';
// import 'package:neomeet/src/features/auth/domain/dto/signup_dto.dart';
// import 'package:neomeet/src/features/auth/domain/repository/auth_repository.dart';
//
// class AuthRepositoryImpl extends AuthRepository {
//   final AuthRemoteDataSource _authRemoteDataSource =
//       AuthRemoteDataSource(DioClient().dio);
//
//   @override
//   Future<Either<Failure, Success>> changePassword({required String password}) {
//     // TODO: implement changePassword
//     throw UnimplementedError();
//   }
//
//   @override
//   Future<Either<Failure, Success>> forgotPassword({required String email}) {
//     // TODO: implement forgotPassword
//     throw UnimplementedError();
//   }
//
//   @override
//   Future<Either<Failure, Success>> login(
//       {required String email, required String password}) {
//     // TODO: implement login
//     throw UnimplementedError();
//   }
//
//   @override
//   Future<Either<Failure, Success>> logout() {
//     // TODO: implement logout
//     throw UnimplementedError();
//   }
//
//   @override
//   Future<Either<Failure, Success>> signUp(
//       {required SignupDto signupDto}) async {
//     Failure failure = Failure(message: "");
//     Success success = Success(message: "");
//     Map<String, dynamic> body = SignupRequestModel(
//             name: signupDto.name,
//             email: signupDto.email,
//             passwordHash: signupDto.password,
//             timeZone: signupDto.timeZone,
//             organizationName: signupDto.organizationName)
//         .toJson();
//     Object result =
//         await _authRemoteDataSource.postRequest(url: '', data: body);
//     if (result is SignupResponseModel) {
//       success.message = result.message ?? "";
//       return Right(success);
//     } else {
//       failure.message = "Something went wrong";
//       return Left(failure);
//     }
//   }
//
//   @override
//   Future<Either<Failure, Success>> updateEmail({required String email}) {
//     // TODO: implement updateEmail
//     throw UnimplementedError();
//   }
// }
