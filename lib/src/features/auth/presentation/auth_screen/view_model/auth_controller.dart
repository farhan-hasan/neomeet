import 'package:bot_toast/bot_toast.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neomeet/src/core/database/local/shared_preference/shared_preference_manager.dart';
import 'package:neomeet/src/core/network/responses/failure_response.dart';
import 'package:neomeet/src/core/utils/logger/logger.dart';
import 'package:neomeet/src/features/auth/data/data_source/remote/auth_remote_data_source.dart';
import 'package:neomeet/src/features/auth/data/model/is_logged_in_response_model.dart';
import 'package:neomeet/src/features/profile/data/model/user_model.dart';
import 'package:neomeet/src/features/profile/presentation/view_model/profile_controller.dart';
import 'package:neomeet/src/shared/dependency_injection/dependency_injection.dart';

import 'auth_generic.dart';

final authProvider = StateNotifierProvider<AuthController, AuthGeneric>(
    (ref) => AuthController(ref));

class AuthController extends StateNotifier<AuthGeneric> {
  AuthController(this.ref) : super(AuthGeneric());
  Ref ref;

  final AuthRemoteDataSource authRemoteDataSource = AuthRemoteDataSource();
  final SharedPreferenceManager sharedPreferenceManager = sl.get();

  Future<bool> isLoggedIn({required String token}) async {
    state = state.update(isLoading: true);
    bool isSuccess = false;
    Either<Failure, IsLoggedInResponseModel> response =
        await authRemoteDataSource.isLoggedIn(
            url: "http://10.0.2.2:3000/protected");
    debug(response.runtimeType);
    response.fold((left) {
      debug(left.message);
      BotToast.showText(text: left.message);
    }, (right) async {
      int? userId = right.user?.userId ?? -1;
      debug(userId);
      Either<Failure, UserModel> response = await authRemoteDataSource
          .getUserById(url: "http://10.0.2.2:3000/api/users/$userId");
      response.fold((left) {
        debug(left.message);
      }, (right) {
        ref.read(profileProvider.notifier).saveUserData(userModel: right);
      });
      BotToast.showText(text: right.message ?? "");
      isSuccess = true;
    });
    state = state.update(isLoading: false);
    return isSuccess;
  }
}
