
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:neomeet/src/features/auth/presentation/auth_screen/view/splash_screen.dart';
import 'package:neomeet/src/features/auth/presentation/forget_password/view/forgot_password_screen.dart';
import 'package:neomeet/src/features/auth/presentation/login/view/login_screen.dart';
import 'package:neomeet/src/features/auth/presentation/signup/view/signup_screen.dart';
import 'package:neomeet/src/features/profile/presentation/view/profile_screen.dart';
import 'package:neomeet/src/shared/view/bottom_nav_screen.dart';

import '../../features/home/presentation/view/home_screen.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();

final goRouterProvider = Provider(
  (ref) {
    return GoRouter(
      navigatorKey: rootNavigatorKey,
      initialLocation:AuthScreen.route,
      observers: [BotToastNavigatorObserver()],
      routes: [
        GoRoute(
          path: AuthScreen.route,
          builder: (context, state) {
            return const AuthScreen();
          },
        ),
        GoRoute(
          path: LoginScreen.route,
          builder: (context, state) {
            return LoginScreen();
          },
        ),
        GoRoute(
          path: SignupScreen.route,
          builder: (context, state) {
            return SignupScreen();
          },
        ),
        GoRoute(
          path: ForgotPasswordScreen.route,
          builder: (context, state) {
            return ForgotPasswordScreen();
          },
        ),
        StatefulShellRoute.indexedStack(
            branches: [
              StatefulShellBranch(
                  initialLocation: HomeScreen.setRoute(),
                  routes: [
                    GoRoute(
                        path: HomeScreen.route,
                        builder: (context, state) {
                          return HomeScreen();
                        }),
                  ]),
              StatefulShellBranch(
                  initialLocation: ProfileScreen.setRoute(),
                  routes: [
                    GoRoute(
                        path: ProfileScreen.route,
                        builder: (context, state) {
                          return ProfileScreen();
                        }),
                  ])
            ],
            builder: (context, state, navigationShell) {
              return BottomNavScreen(navigationShell: navigationShell);
            })
      ],
    );
  },
);
