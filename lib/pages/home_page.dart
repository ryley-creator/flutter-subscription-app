import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home")),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          ListTile(leading: Icon(Icons.star), title: Text("Premium Feature #1")),
          ListTile(leading: Icon(Icons.star), title: Text("Premium Feature #2")),
          ListTile(leading: Icon(Icons.star), title: Text("Premium Feature #3")),
        ],
      ),
    );
  }
}
