import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neomeet/src/core/database/local/shared_preference/shared_preference_keys.dart';
import 'package:neomeet/src/core/database/local/shared_preference/shared_preference_manager.dart';
import 'package:neomeet/src/core/router/router.dart';
import 'package:neomeet/src/core/utils/extension/context_extension.dart';
import 'package:neomeet/src/core/utils/logger/logger.dart';
import 'package:neomeet/src/features/auth/presentation/auth_screen/view_model/auth_controller.dart';
import 'package:neomeet/src/features/auth/presentation/login/view/login_screen.dart';
import 'package:neomeet/src/features/home/presentation/view/home_screen.dart';
import 'package:neomeet/src/shared/dependency_injection/dependency_injection.dart';

class AuthScreen extends ConsumerStatefulWidget {
  const AuthScreen({super.key});

  static const route = '/auth_screen';

  static setRoute() => '/auth_screen';

  @override
  ConsumerState<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthScreen> {
  SharedPreferenceManager sharedPreferenceManager =
      sl.get<SharedPreferenceManager>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: context.width,
        color: Colors.white38,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Flexible(
                  flex: 9,
                  child: Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/gifs/splash_gif.gif"),
                      Text(
                        "NeoMeet",
                        style: TextStyle(fontSize: 50),
                      )
                    ],
                  ))),
              Flexible(
                flex: 1,
                child: SizedBox(
                  width: context.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                          onPressed: () async {
                            bool isLoggedIn = false;
                            String token = sharedPreferenceManager.getValue(
                                key: SharedPreferenceKeys.JWT_TOKEN);
                            isLoggedIn = await ref
                                .read(authProvider.notifier)
                                .isLoggedIn(token: token);
                            debug("isLoggedIn: $isLoggedIn");
                            if (isLoggedIn) {
                              ref.read(goRouterProvider).go(HomeScreen.route);
                            } else {
                              ref.read(goRouterProvider).go(LoginScreen.route);
                            }
                          },
                          child: const Text("Enter as host")),
                      ElevatedButton(
                          onPressed: () {
                            ref.read(goRouterProvider).go(HomeScreen.route);
                          },
                          child: const Text("Enter as guest")),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
