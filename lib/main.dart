import 'package:flutter/material.dart';
import 'package:mnemosyne/index.dart';
import 'package:rive_splash_screen/rive_splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData().copyWith(
        // change the focus border color of the TextField
        colorScheme:
            ThemeData().colorScheme.copyWith(primary: const Color(0xff006d77)),
      ),
      home: SplashScreen.navigate(
        backgroundColor: Colors.white,
        name: 'animations/splash-screen.riv',
        next: (context) => const index(),
        until: () => Future.delayed(const Duration(seconds: 3)),
        loopAnimation: 'Animation 1',
      ),
    );
  }
}
