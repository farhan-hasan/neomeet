

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neomeet/src/features/auth/domain/usecases/signup_usecase.dart';
import 'package:neomeet/src/shared/dependency_injection/dependency_injection.dart';

import 'signup_generic.dart';

final signUpProvider = StateNotifierProvider<SignupController, SignupGeneric>(
  (ref) => SignupController(ref),
);

class SignupController extends StateNotifier<SignupGeneric> {
  SignupController(this.ref) : super(SignupGeneric());
  Ref ref;

  SignupUseCase signupUseCase = sl.get<SignupUseCase>();

  Future<bool> signUp(
      {required String email, required String password}) async {
    return true;
  }
}
