import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../widgets/mochi_character.dart';

class MainWindow extends StatefulWidget {
  const MainWindow({super.key});

  @override
  State<MainWindow> createState() => _MainWindowState();
}

class _MainWindowState extends State<MainWindow> {
  Map<String, dynamic> userData = {};
  Map<String, dynamic> reaction = {};

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    final api = ApiService();

    // Daten vom Backend laden
    userData = await api.getUserData();
    reaction = await api.getReaction(userData["mood"]);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Beauty Mochi – Main")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            // 👉 Mochi-Figur abhängig von der Stimmung
            MochiCharacter(
              mood: userData["mood"] ?? "",
              size: 200,
            ),

            const SizedBox(height: 20),

            // Stimmung anzeigen
            Text(
              "Stimmung: ${userData["mood"] ?? ""}",
              style: const TextStyle(fontSize: 22),
            ),

            const SizedBox(height: 20),

            // Mochi-Reaktion anzeigen
            Text(
              reaction["text"] ?? "",
              style: const TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
