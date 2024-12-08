import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neomeet/src/core/database/local/shared_preference/shared_preference_manager.dart';
import 'package:neomeet/src/core/global/global_variables.dart';
import 'package:neomeet/src/core/router/router.dart';
import 'package:neomeet/src/core/utils/extension/context_extension.dart';
import 'package:neomeet/src/core/utils/validators/validators.dart';
import 'package:neomeet/src/features/auth/domain/dto/login_dto.dart';
import 'package:neomeet/src/features/auth/presentation/login/view_model/login_controller.dart';
import 'package:neomeet/src/features/auth/presentation/signup/view/signup_screen.dart';
import 'package:neomeet/src/features/home/presentation/view/home_screen.dart';
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
            children: [
              Expanded(
                  child: Center(
                child: Image.asset("assets/gifs/splash_gif.gif"),
              )),
              Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            "Login",
                            style: TextStyle(fontSize: 36),
                          ),
                          CustomFormField(
                            controller: emailController,
                            labelText: "Your Email",
                            validator: Validators.emailValidator,
                          ),
                          SizedBox(
                            height: 10,
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
                          Spacer(),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Container(
                                    width: context.width,
                                    child: ElevatedButton(
                                        onPressed: () async {
                                          if (formKey.currentState!
                                              .validate()) {
                                            LoginDto body = LoginDto(
                                                email:
                                                    emailController.text.trim(),
                                                password: passwordController
                                                    .text
                                                    .trim());
                                            bool result = await ref
                                                .read(loginProvider.notifier)
                                                .login(loginDto: body);
                                            if (result) {
                                              ref
                                                  .read(goRouterProvider)
                                                  .go(HomeScreen.route);
                                            }
                                          } else {
                                            BotToast.showText(
                                                text: "Invalid input");
                                          }
                                        },
                                        child: const Text("Login")),
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(vertical: 10),
                                    child: RichText(
                                      text: TextSpan(
                                        text: "Don't have an account? ",
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 16,
                                            fontFamily: appFont),
                                        // Normal style
                                        children: [
                                          TextSpan(
                                            text: 'Signup',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontFamily:
                                                    appFont // Bold style
                                                ),
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                                // Handle tap here
                                                ref
                                                    .read(goRouterProvider)
                                                    .go(SignupScreen.route);
                                              },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
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
