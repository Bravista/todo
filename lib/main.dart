import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  Future<void> _loadItems() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      toDoListe = prefs.getStringList('items') ?? [];
    });
  }

  Future<void> _addItem() async {
    if (_controller.text.isEmpty) return;
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      toDoListe.add(_controller.text);
      prefs.setStringList('items', toDoListe);
      _controller.clear();
    });
  }

  Future<void> _removeItem(int index) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      toDoListe.removeAt(index);
      prefs.setStringList('items', toDoListe);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: const Text("To do Liste"),
      ),
      body: Form(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const SizedBox(
                height: 100,
              ),
              TextFormField(
                controller: _controller,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: validateText,
                decoration: const InputDecoration(
                  labelText: 'Gib einen Text ein',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 33,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black87,
                  backgroundColor: Colors.grey.shade400,
                ),
                onPressed: _addItem,
                child: const Text('Hinzufügen'),
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
          ),
        ),
      ),
    ));
  }
}

String? validateText(String? input) {
  if (input == null || input.isEmpty) {
    return 'Bitte Text eingeben';
  }
  return null;
}
