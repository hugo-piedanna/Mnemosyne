import 'package:flutter/material.dart';
import 'package:mnemosyne/addPassword.dart';
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
    return SafeArea(
        child: Scaffold(
      backgroundColor: const Color(0xffedf6f9),
      floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: FloatingActionButton(
              onPressed: (() => Navigator.push(
                    context,
                    Transition(
                        child: const addpass(),
                        transitionEffect: TransitionEffect.FADE),
                  )),
              backgroundColor: const Color(0xff006d77),
              child: const Icon(Icons.add))),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndDocked,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const Text(
                "Your passwords",
                style: TextStyle(
                    fontSize: 30,
                    height: 3,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff006d77)),
              ),
              const SizedBox(
                height: 5,
              ),
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
                          separatorBuilder: (BuildContext context, int index) {
                            return const SizedBox(
                              height: 10,
                            );
                          },
                          padding: const EdgeInsets.only(
                              right: 50, left: 50, top: 20, bottom: 10),
                          shrinkWrap: true,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, i) => GestureDetector(
                            onTap: (() => {}),
                            child: Container(
                              height: 70,
                              decoration: BoxDecoration(
                                  color: const Color(0xff83c5be),
                                  borderRadius: BorderRadius.circular(15)),
                              child: Center(
                                child: Text(
                                  snapshot.data![i].name,
                                  style: const TextStyle(
                                      color: Color(0xffedf6f9),
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        );
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
    ));
  }
}
