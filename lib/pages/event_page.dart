import 'package:flutter/material.dart';

class EventPage extends StatelessWidget {
  const EventPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Planning du salon"),
      ),
      body: const Center(
        child: Text("Prochainement disponible"),
      ),
    );
  }
}