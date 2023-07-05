import 'package:posrant/core.dart';
import 'package:flutter/material.dart';
import 'package:posrant/module/auth/view/start_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:posrant/debug.dart';

void main() async {
  await initialize();
  runMainApp();
}

runMainApp() async {
  return runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Get.mainTheme,
      builder: (context, value, child) {
        return MaterialApp(
          title: 'posrant',
          navigatorKey: Get.navigatorKey,
          debugShowCheckedModeBanner: false,
          theme: getDefaultTheme(),
          home: FirebaseAuth.instance.currentUser != null
              ? MainNavigationView()
              : const StartView(),
        );
      },
    );
  }
}
