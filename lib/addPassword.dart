import 'package:flutter/material.dart';
import 'package:mnemosyne/main.dart';
import 'package:rive/rive.dart';
import 'package:transition/transition.dart';

import 'index.dart';

class addpass extends StatefulWidget {
  const addpass({Key? key}) : super(key: key);

  @override
  State<addpass> createState() => _addpass();
}

class _addpass extends State<addpass> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController passwordController = new TextEditingController();
  final TextEditingController passwordRepeatController =
      new TextEditingController();
  final TextEditingController nameController = new TextEditingController();

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
              Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 25),
                      namePassword(),
                      const SizedBox(height: 15),
                      passwordField(passwordRepeatController.text, "Password",
                          passwordController),
                      const SizedBox(height: 15),
                      passwordField(passwordController.text, "Repeat password",
                          passwordRepeatController),
                      const SizedBox(height: 15)
                    ],
                  ),
                ),
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
                    onPressed: (() => {
                          if (_formKey.currentState!.validate())
                            {print("It's match")}
                          else
                            {print("Not match")}
                        }),
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

  Widget namePassword() {
    return TextFormField(
      autofocus: false,
      controller: nameController,
      keyboardType: TextInputType.name,
      validator: (value) {
        if (value!.isEmpty) {
          return ("You should enter a password name");
        }
        return null;
      },
      onSaved: (value) {
        nameController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.person),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Name",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  Widget passwordField(
      String val, String title, TextEditingController passwordController) {
    return TextFormField(
      autofocus: false,
      controller: passwordController,
      obscureText: true,
      validator: (value) {
        if (val != value) {
          return ("Passwords don't match");
        }
        if (value!.isEmpty) {
          return ("You should to enter a password");
        }
      },
      onSaved: (value) {
        passwordController.text = value!;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.lock),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: title,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
