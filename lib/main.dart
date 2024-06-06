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
  TextEditingController controller = TextEditingController();
  List<String> toDoListe = ["Einkaufen"];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Center(
              child: Column(
            children: [
              TextField(
                controller: controller,
              ),
              FilledButton(
                onPressed: () {
                  setState(() {
                    toDoListe.add(controller.text);
                    controller.clear();
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
