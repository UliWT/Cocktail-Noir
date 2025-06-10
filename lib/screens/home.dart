// home.dart
import 'package:flutter/material.dart';
import 'Explorar/explorar.dart';
import 'Preparar/preparar_ya.dart';
import 'package:myapp/widgets/boton.dart';
import 'package:myapp/widgets/main_scaffold.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      selectedIndex: 0,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Cocktail Noir',
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: Color(0xFFFFCD29),
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Tu app de coctelería personal',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 16),
          const Divider(
            color: Color(0xFFD4AF37),
            thickness: 2,
            indent: 10,
            endIndent: 10,
          ),
          const SizedBox(height: 50),

          Boton(
            texto: 'Preparar ya',
            padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 24),
            borderRadius: 10,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PrepararYaScreen()),
              );
            },
          ),
          const SizedBox(height: 20),
          Boton(
            texto: 'Explorar',
            padding: const EdgeInsets.symmetric(horizontal: 69, vertical: 24),
            borderRadius: 10,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ExplorarScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}
