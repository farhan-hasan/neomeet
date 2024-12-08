import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  static const route = '/profile_screen';

  static setRoute() => '/profile_screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Center(child: Icon(Icons.person),),
    );
  }
}
