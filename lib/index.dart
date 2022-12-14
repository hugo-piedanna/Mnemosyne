// ignore_for_file: camel_case_types, no_logic_in_create_state, use_build_context_synchronously

import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mnemosyne/addPassword.dart';
import 'package:mnemosyne/models/password.dart';
import 'package:mnemosyne/services/databaseServices.dart';
import 'package:transition/transition.dart';

class index extends StatefulWidget {
  const index({super.key, required this.list});

  final Future<List<password>?> list;

  @override
  State<index> createState() => _index(list);
}

class _index extends State<index> {
  Future<List<password>?>? _future;

  _index(Future<List<password>?> list) {
    _future = list;
  }
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
                    future: _future,
                    builder:
                        (context, AsyncSnapshot<List<password>?> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                            child: CircularProgressIndicator(
                          color: Color(0xff83c5be),
                        ));
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
                            onLongPress: (() async {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: const Text(
                                        'Are you sure you want to delete this password?',
                                        style:
                                            TextStyle(color: Color(0xff006d77)),
                                      ),
                                      actions: [
                                        ElevatedButton(
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      const Color(0xff83c5be))),
                                          onPressed: () {
                                            setState(() async {
                                              await DatabaseHelper.deletePass(
                                                  snapshot.data![i]);
                                              Navigator.push(
                                                context,
                                                Transition(
                                                    child: index(
                                                        list: DatabaseHelper
                                                            .allPassword()),
                                                    transitionEffect:
                                                        TransitionEffect.FADE),
                                              );
                                            });
                                          },
                                          child: const Text('Yes'),
                                        ),
                                        ElevatedButton(
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      Colors.red)),
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: const Text('No'),
                                        ),
                                      ],
                                    );
                                  });
                            }),
                            onTap: (() => {
                                  FlutterClipboard.copy(snapshot.data![i].pass)
                                      .then((value) => print('copied')),
                                  Fluttertoast.showToast(
                                      msg: "Copied !",
                                      toastLength: Toast.LENGTH_LONG)
                                }),
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
