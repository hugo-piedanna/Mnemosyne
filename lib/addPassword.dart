import 'package:flutter/material.dart';
import 'package:mnemosyne/main.dart';
import 'package:transition/transition.dart';

import 'index.dart';

class addpass extends StatefulWidget {
  const addpass({Key? key}) : super(key: key);

  @override
  State<addpass> createState() => _addpass();
}

class _addpass extends State<addpass> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const Text(
                "New password",
                style: TextStyle(
                    fontSize: 30, height: 3, fontWeight: FontWeight.bold),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RaisedButton(
                    color: Colors.red,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    onPressed: (() => Navigator.push(
                          context,
                          Transition(
                              child: const index(),
                              transitionEffect: TransitionEffect.FADE),
                        )),
                    child: const Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Text(
                        'Cancel',
                        style: TextStyle(fontSize: 23, color: Colors.white),
                      ),
                    ),
                  ),
                  RaisedButton(
                    color: Colors.blueAccent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    onPressed: (() => {}),
                    child: const Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Text(
                        'Add password',
                        style: TextStyle(fontSize: 23, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
