import 'package:flutter/material.dart';
import 'package:myapp/widgets/main_scaffold.dart';

class PrepararYaScreen extends StatelessWidget {
  const PrepararYaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      selectedIndex: -1, // 👈 este valor dice "no estoy en una pestaña del menú"
      appBar: AppBar(),
      backgroundColor: const Color(0xFF1A1A1A),
      body: const Center(
        child: Text(
          'Pantalla Preparar Ya',
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
      ),
    );
  }
}
