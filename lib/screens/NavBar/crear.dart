import 'package:flutter/material.dart';
import 'package:myapp/widgets/main_scaffold.dart';

class CrearScreen extends StatelessWidget {
  const CrearScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      selectedIndex: 2,
      appBar: AppBar(),
      backgroundColor: Color(0xFF1A1A1A),
      body: Center(
        child: Text(
          'Pantalla de Crear',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}


