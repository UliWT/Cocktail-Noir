import 'package:flutter/material.dart';
import 'package:myapp/widgets/boton.dart';
import 'package:myapp/screens/Explorar/busca_t.dart';
import 'package:myapp/screens/Explorar/p_ing.dart';
import 'package:myapp/screens/Explorar/sorprendeme.dart';
import 'package:myapp/screens/Explorar/novedades.dart';
import 'package:myapp/widgets/main_scaffold.dart';

class ExplorarScreen extends StatelessWidget {
  const ExplorarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      selectedIndex: 0, // o el índice que uses para esta pantalla
      appBar: AppBar(
        title: const Text('Explorar'),
        backgroundColor: const Color(0xFF1A1A1A),
      ),
      backgroundColor: const Color(0xFF1A1A1A),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Boton(
                  texto: 'Buscar trago',
                  emoji: '❓',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const BuscarTScreen()),
                    );
                  },
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 50),
                  borderRadius: 12,
                  style: const TextStyle(fontSize: 24),
                ),
                Boton(
                  texto: 'Por ingrediente',
                  emoji: '🥃',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const PIngScreen()),
                    );
                  },
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 50),
                  borderRadius: 12,
                  style: const TextStyle(fontSize: 24),
                ),
              ],
            ),

            const SizedBox(height: 24),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Boton(
                  texto: 'Sorprendeme',
                  emoji: '✨',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const SorprendemeScreen()),
                    );
                  },
                  padding: const EdgeInsets.symmetric(horizontal: 29, vertical: 50),
                  borderRadius: 12,
                  style: const TextStyle(fontSize: 24),
                ),
                Boton(
                  texto: 'Novedades',
                  emoji: '🔔',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const NovedadesScreen()),
                    );
                  },
                  padding: const EdgeInsets.symmetric(horizontal: 38, vertical: 50),
                  borderRadius: 12,
                  style: const TextStyle(fontSize: 24),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
