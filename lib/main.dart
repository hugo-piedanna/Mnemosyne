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
      title: 'Mnémosyne',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen.navigate(
        backgroundColor: Colors.white,
        name: 'splash-screen.riv',
        next: (context) => const index(),
        until: () => Future.delayed(const Duration(seconds: 6)),
        loopAnimation: 'Animation 1',
      ),
    );
  }
}
