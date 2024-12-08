import 'package:bot_toast/bot_toast.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neomeet/src/core/network/responses/failure_response.dart';
import 'package:neomeet/src/core/utils/logger/logger.dart';
import 'package:neomeet/src/features/auth/data/data_source/remote/auth_remote_data_source.dart';
import 'package:neomeet/src/features/auth/data/model/signup_request_model.dart';
import 'package:neomeet/src/features/auth/data/model/signup_response_model.dart';
import 'package:neomeet/src/features/auth/domain/dto/signup_dto.dart';

import 'signup_generic.dart';

final signUpProvider = StateNotifierProvider<SignupController, SignupGeneric>(
  (ref) => SignupController(ref),
);

class SignupController extends StateNotifier<SignupGeneric> {
  SignupController(this.ref) : super(SignupGeneric());
  Ref ref;
  AuthRemoteDataSource authRemoteDataSource = AuthRemoteDataSource();

  //SignupUseCase signupUseCase = sl.get<SignupUseCase>();

  Future<bool> signUp({required SignupDto signupDto}) async {
    state = state.update(isLoading: true);
    bool isSuccess = false;
    Map<String, dynamic> body = SignupRequestModel(
            name: signupDto.name,
            email: signupDto.email,
            passwordHash: signupDto.password,
            timeZone: signupDto.timeZone,
            organizationName: signupDto.organizationName)
        .toJson();
    Either<Failure, SignupResponseModel> response = await authRemoteDataSource
        .signup(url: "http://10.0.2.2:3000/api/users", data: body);
    debug(response.runtimeType);
    response.fold((left) {
      debug(left.message);
      BotToast.showText(text: left.message);
    }, (right) {
      BotToast.showText(text: right.message ?? "");
      isSuccess = true;
    });
    state = state.update(isLoading: false);
    return isSuccess;
  }
}
