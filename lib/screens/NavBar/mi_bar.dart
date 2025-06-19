import 'package:flutter/material.dart';
import 'package:myapp/widgets/main_scaffold.dart';

class MiBarScreen extends StatelessWidget {
  const MiBarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      selectedIndex: 3,
      appBar: AppBar(),
      backgroundColor: Color(0xFF1A1A1A),
      body: Center(
        child: Text(
          'Pantalla de Mi bar',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
