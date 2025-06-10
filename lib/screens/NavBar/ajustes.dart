import 'package:flutter/material.dart';
import 'package:myapp/widgets/main_scaffold.dart';

class AjustesScreen extends StatelessWidget {
  const AjustesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      selectedIndex: 0,
      body: Center(
        child: Text('Ajustes', style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
