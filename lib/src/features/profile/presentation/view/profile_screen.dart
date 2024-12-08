import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neomeet/src/core/database/local/shared_preference/shared_preference_keys.dart';
import 'package:neomeet/src/core/database/local/shared_preference/shared_preference_manager.dart';
import 'package:neomeet/src/core/router/router.dart';
import 'package:neomeet/src/core/utils/extension/context_extension.dart';
import 'package:neomeet/src/features/auth/presentation/login/view/login_screen.dart';
import 'package:neomeet/src/features/profile/presentation/view_model/profile_controller.dart';
import 'package:neomeet/src/features/profile/presentation/view_model/profile_generic.dart';
import 'package:neomeet/src/shared/dependency_injection/dependency_injection.dart';
import 'package:neomeet/src/shared/widgets/shared_appbar.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  static const route = '/profile_screen';

  static setRoute() => '/profile_screen';

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  final SharedPreferenceManager sharedPreferenceManager = sl.get();

  @override
  Widget build(BuildContext context) {
    ProfileGeneric profileController = ref.watch(profileProvider);
    return Scaffold(
      appBar: SharedAppbar(
        title: Text("Profile"),
        trailingWidgets: [
          IconButton(
              onPressed: () {
                sharedPreferenceManager.insertValue(
                    key: SharedPreferenceKeys.JWT_TOKEN, data: "");
                ref.read(goRouterProvider).go(LoginScreen.route);
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: buildImageSection(context, profileController),
              ),
              const SizedBox(
                height: 40,
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildDisplayNameSection(context, profileController),
                  const SizedBox(
                    height: 20,
                  ),
                  buildEmailSection(context, profileController),
                  const SizedBox(
                    height: 20,
                  ),
                  buildTimeZoneSection(context, profileController),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTimeZoneSection(
      BuildContext context, ProfileGeneric profileController) {
    return SizedBox(
        height: context.height * 0.06,
        //color: Colors.amber,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Time Zone",
                  style: TextStyle(color: Colors.grey),
                ),
                Text(
                  profileController.userModel?.timezone ?? "",
                  style: Theme.of(context).textTheme.titleLarge,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ],
        ));
  }

  Widget buildEmailSection(
      BuildContext context, ProfileGeneric profileController) {
    return SizedBox(
        height: context.height * 0.06,
        //color: Colors.amber,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Email",
                  style: TextStyle(color: Colors.grey),
                ),
                Text(
                  profileController.userModel?.email ?? "",
                  style: Theme.of(context).textTheme.titleLarge,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ],
        ));
  }

  Widget buildDisplayNameSection(
      BuildContext context, ProfileGeneric profileController) {
    return SizedBox(
        height: context.height * 0.06,
        //color: Colors.amber,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Display name",
                  style: TextStyle(color: Colors.grey),
                ),
                Text(
                  profileController.userModel?.name ?? "",
                  style: Theme.of(context).textTheme.titleLarge,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ],
        ));
  }

  Widget buildImageSection(
      BuildContext context, ProfileGeneric profileController) {
    return const Column(
      children: [
        Align(
          alignment: Alignment.center,
          child: Icon(
            Icons.person,
            size: 100,
          ),
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
