import 'package:flutter/material.dart';

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({super.key});

  static const route = '/schedule_screen';

  static setRoute() => '/schedule_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Icon(Icons.schedule),
      ),
    );
  }
}
