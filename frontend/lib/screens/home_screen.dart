import 'package:flutter/material.dart';
import '../services/api_service.dart';
import 'main_window.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final api = ApiService();

  final List<Map<String, dynamic>> moods = [
    {"label": "Müde", "icon": Icons.bed, "color": Colors.blueGrey},
    {"label": "Überreizt", "icon": Icons.flash_on, "color": Colors.redAccent},
    {"label": "Erschöpft", "icon": Icons.hourglass_empty, "color": Colors.grey},
    {"label": "Unruhig", "icon": Icons.run_circle, "color": Colors.orange},
    {"label": "Energetisch", "icon": Icons.bolt, "color": Colors.yellow},
    {"label": "Motiviert", "icon": Icons.trending_up, "color": Colors.green},
    {"label": "Überfordert", "icon": Icons.warning, "color": Colors.deepOrange},
    {"label": "Abgelenkt", "icon": Icons.visibility_off, "color": Colors.purple},
    {"label": "Im Hyperfokus", "icon": Icons.center_focus_strong, "color": Colors.indigo},
    {"label": "Fröhlich", "icon": Icons.sentiment_satisfied, "color": Colors.lightGreen},
    {"label": "Gestresst", "icon": Icons.sentiment_dissatisfied, "color": Colors.red},
    {"label": "Unsicher", "icon": Icons.help_outline, "color": Colors.blue},
  ];

  String selectedMood = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Beauty Mochi")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: moods.map((mood) {
                final isSelected = selectedMood == mood["label"];

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedMood = mood["label"];
                    });
                  },
                  child: AnimatedScale(
                    scale: isSelected ? 1.08 : 1.0,
                    duration: const Duration(milliseconds: 180),
                    curve: Curves.easeOut,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.easeOut,
                      width: 120,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: isSelected ? mood["color"] : Colors.grey[200],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected ? Colors.black : Colors.grey,
                          width: isSelected ? 2 : 1,
                        ),
                        boxShadow: isSelected
                            ? [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.25),
                                  blurRadius: 12,
                                  offset: const Offset(0, 4),
                                )
                              ]
                            : [],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            mood["icon"],
                            size: 32,
                            color: isSelected ? Colors.white : Colors.black,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            mood["label"],
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: isSelected ? Colors.white : Colors.black,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () async {
                if (selectedMood.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Bitte eine Stimmung auswählen")),
                  );
                  return;
                }

                await api.sendUserData(
                  "Chris Freundin",
                  selectedMood,
                  1,
                );

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MainWindow(),
                  ),
                );
              },
              child: const Text("Stimmung senden"),
            ),
          ],
        ),
      ),
    );
  }
}
