
import 'package:get_it/get_it.dart';
import 'package:neomeet/src/core/database/local/sembast/sembast_db_config.dart';
import 'package:neomeet/src/core/database/local/shared_preference/shared_preference_manager.dart';
import 'package:neomeet/src/features/auth/data/repository/auth_repository_impl.dart';
import 'package:neomeet/src/features/auth/domain/usecases/change_password_usecase.dart';
import 'package:neomeet/src/features/auth/domain/usecases/forgot_password_usecase.dart';
import 'package:neomeet/src/features/auth/domain/usecases/login_usecase.dart';
import 'package:neomeet/src/features/auth/domain/usecases/logout_usecase.dart';
import 'package:neomeet/src/features/auth/domain/usecases/signup_usecase.dart';

import '../../features/auth/domain/usecases/change_email_usecase.dart';

final sl = GetIt.I;

Future<void> setupService() async {
  sl.registerSingletonAsync<SharedPreferenceManager>(() async {
    final SharedPreferenceManager sharedPreferenceManager =
        SharedPreferenceManager();
    await sharedPreferenceManager.init();
    return sharedPreferenceManager;
  });
  sl.registerSingletonAsync<SembastDbConfig>(() async {
    final sembastDbConfig = SembastDbConfig();
    await sembastDbConfig.init();
    return sembastDbConfig;
  });
  sl.registerSingleton<AuthRepositoryImpl>(AuthRepositoryImpl());
  sl.registerSingleton<ChangePasswordUseCase>(ChangePasswordUseCase());
  sl.registerSingleton<ForgotPasswordUseCase>(ForgotPasswordUseCase());
  sl.registerSingleton<LoginUseCase>(LoginUseCase());
  sl.registerSingleton<LogoutUseCase>(LogoutUseCase());
  sl.registerSingleton<SignupUseCase>(SignupUseCase());
  sl.registerSingleton<ChangeEmailUseCase>(ChangeEmailUseCase());

  await sl.allReady();
}
