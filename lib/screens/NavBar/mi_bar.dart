import 'package:flutter/material.dart';

class MiBarScreen extends StatelessWidget {
  const MiBarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Pantalla de Mi bar',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
