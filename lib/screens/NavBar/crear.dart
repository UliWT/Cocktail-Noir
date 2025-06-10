import 'package:flutter/material.dart';

class CrearScreen extends StatelessWidget {
  const CrearScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Pantalla de Crear',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
