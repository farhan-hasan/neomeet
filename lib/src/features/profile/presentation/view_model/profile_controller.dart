import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neomeet/src/features/auth/data/data_source/remote/auth_remote_data_source.dart';
import 'package:neomeet/src/features/profile/data/model/user_model.dart';
import 'package:neomeet/src/features/profile/presentation/view_model/profile_generic.dart';

final profileProvider =
    StateNotifierProvider<ProfileController, ProfileGeneric>(
        (ref) => ProfileController(ref));

class ProfileController extends StateNotifier<ProfileGeneric> {
  ProfileController(this.ref) : super(ProfileGeneric());
  Ref ref;

  final AuthRemoteDataSource authRemoteDataSource = AuthRemoteDataSource();

  saveUserData({required UserModel userModel}) {
    state = state.update(userModel: userModel);
  }

// Future<bool> login({required LoginDto loginDto}) async {
//   state = state.update(isLoading: true);
//   bool isSuccess = false;
//   Map<String, dynamic> body = LoginRequestModel(
//     email: loginDto.email,
//     password: loginDto.password,
//   ).toJson();
//   Either<Failure, LoginResponseModel> response = await authRemoteDataSource
//       .login(url: "http://10.0.2.2:3000/api/users", data: body);
//   debug(response.runtimeType);
//   response.fold((left) {
//     debug(left.message);
//     BotToast.showText(text: left.message);
//   }, (right) {
//     BotToast.showText(text: right.message ?? "");
//     isSuccess = true;
//   });
//   state = state.update(isLoading: false);
//   return isSuccess;
// }
}
