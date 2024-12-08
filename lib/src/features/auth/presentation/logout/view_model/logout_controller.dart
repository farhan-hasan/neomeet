import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neomeet/src/features/auth/presentation/logout/view_model/logout_generic.dart';

final logoutProvider = StateNotifierProvider<LogoutController, LogoutGeneric>(
    (ref) => LogoutController(ref));

class LogoutController extends StateNotifier<LogoutGeneric> {
  LogoutController(this.ref) : super(LogoutGeneric());
  Ref ref;

  Future<bool> logout() async {
    return true;
  }
}
