import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neomeet/src/core/router/router.dart';
import 'package:neomeet/src/core/utils/extension/context_extension.dart';
import 'package:neomeet/src/features/auth/presentation/login/view/login_screen.dart';

class AuthScreen extends ConsumerStatefulWidget {
  const AuthScreen({super.key});

  static const route = '/auth_screen';

  static setRoute() => '/auth_screen';

  @override
  ConsumerState<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthScreen> {
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
              Flexible(flex: 9,child: Center(child: const Icon(Icons.schedule, size: 100,))),
              Flexible(
                flex: 1,
                child: SizedBox(
                  width: context.width,
                  child: ElevatedButton(onPressed: () {
                    ref.read(goRouterProvider).go(LoginScreen.route);
                  }, child: const Text("Lets Go")),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
