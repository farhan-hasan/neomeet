import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neomeet/src/core/global/global_variables.dart';
import 'package:neomeet/src/core/router/router.dart';
import 'package:neomeet/src/core/utils/extension/context_extension.dart';
import 'package:neomeet/src/core/utils/validators/validators.dart';
import 'package:neomeet/src/features/auth/domain/dto/signup_dto.dart';
import 'package:neomeet/src/features/auth/presentation/login/view/login_screen.dart';
import 'package:neomeet/src/features/auth/presentation/signup/view_model/signup_controller.dart';
import 'package:neomeet/src/shared/widgets/custom_form_field.dart';

class SignupScreen extends ConsumerStatefulWidget {
  SignupScreen({super.key});

  static const route = '/signup';

  static setRoute() => '/signup';

  @override
  ConsumerState<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController roleController = TextEditingController();
  final TextEditingController timeZoneController = TextEditingController();
  final TextEditingController organizationController = TextEditingController();
  final List<String> timezones = [
    "UTC",
    "Asia/Dhaka",
    "Europe/London",
    "America/New_York",
    "Asia/Tokyo",
  ];
  final List<String> roles = ["Host", "Guest"];
  ValueNotifier<String> selectedRole = ValueNotifier<String>("Host");
  ValueNotifier<String> selectedTimezone = ValueNotifier<String>("UTC");

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final signupController = ref.watch(signUpProvider);
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: context.height,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Image.asset("assets/gifs/splash_gif.gif"),
                  )),
              Expanded(
                  flex: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "Sign Up",
                            style: TextStyle(fontSize: 36),
                          ),
                          CustomFormField(
                              controller: emailController,
                              labelText: "Your Email",
                              validator: Validators.emailValidator),
                          CustomFormField(
                              controller: nameController,
                              labelText: "Full Name",
                              validator: Validators.validator),
                          CustomFormField(
                              controller: passwordController,
                              labelText: "Password",
                              validator: Validators.passwordValidator),
                          CustomFormField(
                              controller: confirmPasswordController,
                              labelText: "Confirm password",
                              validator: Validators.passwordValidator),
                          // ValueListenableBuilder(
                          //     valueListenable: selectedRole,
                          //     builder: (context, value, child) {
                          //       return DropdownButton<String>(
                          //         dropdownColor: Colors.white,
                          //         isExpanded: true,
                          //         value: selectedRole.value,
                          //         // Always matches one of the items
                          //         items: roles.map((role) {
                          //           return DropdownMenuItem(
                          //             value: role,
                          //             child: Text(role),
                          //           );
                          //         }).toList(),
                          //         onChanged: (value) {
                          //           selectedRole.value = value ?? "";
                          //         },
                          //       );
                          //     }),
                          ValueListenableBuilder(
                              valueListenable: selectedTimezone,
                              builder: (context, value, child) {
                                return Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black),
                                    // Border style
                                    borderRadius: BorderRadius.circular(
                                        4), // Border radius
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 1),
                                    child: DropdownButton<String>(
                                      underline: SizedBox.shrink(),
                                      dropdownColor: Colors.white,
                                      isExpanded: true,
                                      value: selectedTimezone.value,
                                      // Always matches one of the items
                                      items: timezones.map((timezone) {
                                        return DropdownMenuItem(
                                          value: timezone,
                                          child: Text(timezone),
                                        );
                                      }).toList(),
                                      onChanged: (value) {
                                        selectedTimezone.value = value ?? "";
                                      },
                                    ),
                                  ),
                                );
                              }),
                          CustomFormField(
                            controller: organizationController,
                            labelText: "Organization Name (Optional)",
                            validator: (String? value) {
                              return null;
                            },
                          ),
                          Container(
                            width: context.width,
                            child: ElevatedButton(
                                onPressed: () async {
                                  bool passwordMatched =
                                      passwordController.text.trim() ==
                                          confirmPasswordController.text.trim();
                                  if (formKey.currentState!.validate() &&
                                      passwordMatched) {
                                    SignupDto body = SignupDto(
                                        email: emailController.text.trim(),
                                        password:
                                            passwordController.text.trim(),
                                        name: nameController.text.trim(),
                                        timeZone: selectedTimezone.value.trim(),
                                        organizationName:
                                            organizationController.text.trim());

                                    bool result = await ref
                                        .read(signUpProvider.notifier)
                                        .signUp(signupDto: body);
                                    if (result) {
                                      ref
                                          .read(goRouterProvider)
                                          .go(LoginScreen.route);
                                    }
                                  } else {
                                    if (!passwordMatched) {
                                      BotToast.showText(
                                          text: "Passwords doesn't match");
                                    } else {
                                      BotToast.showText(text: "Invalid inputs");
                                    }
                                  }
                                },
                                child: signupController.isLoading
                                    ? const CircularProgressIndicator(
                                        color: Colors.white,
                                      )
                                    : const Text("Sign up")),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            child: RichText(
                              text: TextSpan(
                                text: "Already have an account? ",
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
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        // Handle tap here
                                        ref
                                            .read(goRouterProvider)
                                            .go(LoginScreen.route);
                                      },
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
