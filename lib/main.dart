// ignore_for_file: unused_element

import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final TextEditingController _controller = TextEditingController();
  List<String> toDoListe = ["Einkaufen"];
  void _toDoListe() {
    if (_controller.text.isEmpty) {
      return;
    }
    setState(() {
      toDoListe.add(_controller.text);
      _controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Center(
              child: Column(
            children: [
              TextField(
                controller: _controller,
              ),
              FilledButton(
                onPressed: () {
                  setState(() {
                    toDoListe.add(_controller.text);
                    _controller.clear();
                  });
                },
                child: const Text("Hinzufügen"),
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: toDoListe.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(toDoListe[index]),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            setState(() {
                              toDoListe.remove(toDoListe[index]);
                            });
                          },
                        ),
                      );
                    }),
              )
            ],
          )),
        ),
      ),
    );
  }
}
