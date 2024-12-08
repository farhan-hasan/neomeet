import 'package:bot_toast/bot_toast.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neomeet/src/features/auth/presentation/forget_password/view_model/forgot_password_generic.dart';

final forgotPasswordProvider =
    StateNotifierProvider<ForgotPasswordController, ForgotPasswordGeneric>(
  (ref) => ForgotPasswordController(ref),
);

class ForgotPasswordController extends StateNotifier<ForgotPasswordGeneric> {
  ForgotPasswordController(this.ref) : super(ForgotPasswordGeneric());
  Ref ref;


  void sendPasswordResetEmail({required String email}) async {
    return;
  }
}
