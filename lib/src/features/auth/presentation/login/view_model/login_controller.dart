import 'package:bot_toast/bot_toast.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neomeet/src/core/database/local/shared_preference/shared_preference_keys.dart';
import 'package:neomeet/src/core/database/local/shared_preference/shared_preference_manager.dart';
import 'package:neomeet/src/core/network/responses/failure_response.dart';
import 'package:neomeet/src/core/utils/logger/logger.dart';
import 'package:neomeet/src/features/auth/data/data_source/remote/auth_remote_data_source.dart';
import 'package:neomeet/src/features/auth/data/model/login_request_model.dart';
import 'package:neomeet/src/features/auth/data/model/login_response_model.dart';
import 'package:neomeet/src/features/auth/domain/dto/login_dto.dart';
import 'package:neomeet/src/features/auth/presentation/login/view_model/login_generic.dart';
import 'package:neomeet/src/features/profile/data/model/user_model.dart';
import 'package:neomeet/src/features/profile/presentation/view_model/profile_controller.dart';
import 'package:neomeet/src/shared/dependency_injection/dependency_injection.dart';

final loginProvider = StateNotifierProvider<LoginController, LoginGeneric>(
    (ref) => LoginController(ref));

class LoginController extends StateNotifier<LoginGeneric> {
  LoginController(this.ref) : super(LoginGeneric());
  Ref ref;

  final AuthRemoteDataSource authRemoteDataSource = AuthRemoteDataSource();
  final SharedPreferenceManager sharedPreferenceManager = sl.get();

  Future<bool> login({required LoginDto loginDto}) async {
    state = state.update(isLoading: true);
    bool isSuccess = false;
    Map<String, dynamic> body = LoginRequestModel(
      email: loginDto.email,
      password: loginDto.password,
    ).toJson();
    Either<Failure, LoginResponseModel> response = await authRemoteDataSource
        .login(url: "http://10.0.2.2:3000/api/login", data: body);
    debug(response.runtimeType);
    response.fold((left) {
      debug(left.message);
      BotToast.showText(text: left.message);
    }, (right) {
      UserModel userModel = right.user ?? UserModel();
      sharedPreferenceManager.insertValue<String>(
          key: SharedPreferenceKeys.JWT_TOKEN, data: right.token ?? "");
      ref.read(profileProvider.notifier).saveUserData(userModel: userModel);
      BotToast.showText(text: right.message ?? "");
      isSuccess = true;
    });
    state = state.update(isLoading: false);
    return isSuccess;
  }
}
