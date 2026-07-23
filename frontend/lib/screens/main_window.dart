import 'package:flutter/material.dart';
import '../services/api_service.dart';

class MainWindow extends StatefulWidget {
  const MainWindow({super.key});

  @override
  State<MainWindow> createState() => _MainWindowState();
}

class _MainWindowState extends State<MainWindow> {
  Map<String, dynamic> userData = {};

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    userData = await ApiService().getUserData();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Beauty Mochi – Main")),
      body: Center(
        child: Text(
          "Stimmung: ${userData["mood"]}",
          style: const TextStyle(fontSize: 22),
        ),
      ),
    );
  }
}
