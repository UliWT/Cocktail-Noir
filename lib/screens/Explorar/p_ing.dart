import 'package:flutter/material.dart';
import 'package:myapp/widgets/main_scaffold.dart';

class PIngScreen extends StatelessWidget {
  const PIngScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      selectedIndex: 0,
      appBar: AppBar(),
      backgroundColor: Color(0xFF1A1A1A),
      body: const Center(
        child: Text(
          'Pantalla Busqueda Por Ingrediente',
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
      ),
    );
  }
}

