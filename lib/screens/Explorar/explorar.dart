import 'package:flutter/material.dart';

class ExplorarScreen extends StatelessWidget {
  const ExplorarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Color(0xFF1A1A1A),
      body: const Center(
        child: Text(
          'Pantalla Explorar',
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
      ),
    );
  }
}
