import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static const route = '/home_screen';

  static setRoute() => '/home_screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Center(child: Icon(Icons.home),),
    );
  }
}
