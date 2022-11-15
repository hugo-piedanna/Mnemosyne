import 'package:flutter/material.dart';
import 'package:mnemosyne/addPassword.dart';
import 'package:mnemosyne/main.dart';
import 'package:transition/transition.dart';

class index extends StatefulWidget {
  const index({Key? key}) : super(key: key);

  @override
  State<index> createState() => _index();
}

class _index extends State<index> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const Text(
                "Your passwords",
                style: TextStyle(
                    fontSize: 30, height: 3, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: (() => Navigator.push(
                      context,
                      Transition(
                          child: const addpass(),
                          transitionEffect: TransitionEffect.FADE),
                    )),
                child: Container(
                  width: 350,
                  height: 70,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(15)),
                  child: const Center(
                    child: Text(
                      "+",
                      style: TextStyle(
                          color: Color(0xfffaf3dd),
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
