import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neomeet/src/features/auth/presentation/login/view_model/login_generic.dart';

final loginProvider = StateNotifierProvider<LoginController, LoginGeneric>(
    (ref) => LoginController(ref));

class LoginController extends StateNotifier<LoginGeneric> {
  LoginController(this.ref) : super(LoginGeneric());
  Ref ref;

  Future<bool> login({required String email, required String password}) async {
    state = state.update(isLoading: true);




    state = state.update(isLoading: false);
    return true;
  }
}
