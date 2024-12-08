
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neomeet/src/core/app/app.dart';
import 'package:neomeet/src/core/global/global_variables.dart';
import 'package:neomeet/src/shared/dependency_injection/dependency_injection.dart';

void main() {

  WidgetsFlutterBinding.ensureInitialized();

  setupService();
  runApp(UncontrolledProviderScope(container: container,child: const App()));
}

