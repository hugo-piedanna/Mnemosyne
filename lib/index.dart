import 'package:flutter/material.dart';
import 'package:mnemosyne/addPassword.dart';
import 'package:mnemosyne/main.dart';
import 'package:mnemosyne/models/password.dart';
import 'package:mnemosyne/services/databaseServices.dart';
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
              ),
              const SizedBox(height: 10),
              Expanded(
                child: FutureBuilder(
                    future: DatabaseHelper.allPassword(),
                    builder:
                        (context, AsyncSnapshot<List<password>?> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text(snapshot.error.toString()),
                        );
                      } else if (snapshot.hasData) {
                        return ListView.separated(
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return const SizedBox(
                                height: 10,
                              );
                            },
                            padding: const EdgeInsets.all(25),
                            shrinkWrap: true,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, i) => GestureDetector(
                                  onTap: (() => {}),
                                  child: Container(
                                    height: 70,
                                    decoration: BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Center(
                                      child: Text(
                                        snapshot.data![i].name,
                                        style: const TextStyle(
                                            color: Color(0xfffaf3dd),
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ));
                      }
                      return const Center(
                        child: Text("Any password"),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
