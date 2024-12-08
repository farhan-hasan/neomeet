import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neomeet/src/core/database/local/shared_preference/shared_preference_manager.dart';
import 'package:neomeet/src/core/global/global_variables.dart';
import 'package:neomeet/src/core/utils/extension/context_extension.dart';
import 'package:neomeet/src/core/utils/validators/validators.dart';
import 'package:neomeet/src/features/auth/presentation/login/view_model/login_controller.dart';
import 'package:neomeet/src/shared/dependency_injection/dependency_injection.dart';
import 'package:neomeet/src/shared/widgets/custom_form_field.dart';

class LoginScreen extends ConsumerStatefulWidget {
  LoginScreen({super.key}) {}
  static const route = "/login";

  static setRoute() => "/login";

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final SharedPreferenceManager preferenceManager = sl.get();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final loginController = ref.watch(loginProvider);
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: context.height,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                  child: Container(
                color: Colors.blue,
              )),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: context.width,
                  child: Column(
                    children: [
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Login",
                          style: TextStyle(fontSize: 36),
                        ),
                      ),
                      CustomFormField(
                        controller: emailController,
                        labelText: "Your Email",
                        validator: Validators.emailValidator,
                      ),
                      CustomFormField(
                        controller: passwordController,
                        labelText: "Password",
                        // obscureText: true,
                        validator: Validators.passwordValidator,
                      ),
                      const Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "Forgot Password?",
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                          textAlign: TextAlign.end,
                        ),
                      ),
                      Container(
                        width: context.width,
                        child: ElevatedButton(
                            onPressed: () {}, child: const Text("Continue")),
                      ),
                      RichText(
                        text: TextSpan(
                          text: "Don't have an account? ",
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                              fontFamily: appFont),
                          // Normal style
                          children: [
                            TextSpan(
                              text: 'Login',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: appFont // Bold style
                                  ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
