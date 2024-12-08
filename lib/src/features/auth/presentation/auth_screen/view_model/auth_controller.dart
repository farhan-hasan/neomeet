import 'package:bot_toast/bot_toast.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'auth_generic.dart';

final authProvider = StateNotifierProvider<AuthController, AuthGeneric>(
    (ref) => AuthController(ref));

class AuthController extends StateNotifier<AuthGeneric> {
  AuthController(this.ref) : super(AuthGeneric());
  Ref ref;

  Future<bool> changeEmail({required String email}) async {
    return true;
  }
}
