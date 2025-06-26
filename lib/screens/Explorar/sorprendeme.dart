import 'dart:math';
import 'package:myapp/favoritos_manager.dart';
import 'package:flutter/material.dart';
import 'package:myapp/widgets/main_scaffold.dart';
import 'package:myapp/widgets/tarjeta.dart';
import 'package:myapp/widgets/boton.dart';
import 'package:myapp/data/tragos.dart';

class SorprendemeScreen extends StatefulWidget {
  const SorprendemeScreen({super.key});

  @override
  State<SorprendemeScreen> createState() => _SorprendemeScreenState();
}

class _SorprendemeScreenState extends State<SorprendemeScreen> {
  late Map<String, dynamic> tragoActual;
  final _random = Random();

  @override
  void initState() {
    super.initState();
    tragoActual = tragos[_random.nextInt(tragos.length)];
  }

  void _refrescarTrago() {
    setState(() {
      Map<String, dynamic> nuevoTrago;
      do {
        nuevoTrago = tragos[_random.nextInt(tragos.length)];
      } while (nuevoTrago == tragoActual);
      tragoActual = nuevoTrago;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      selectedIndex: 0,
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1A1A),
        elevation: 0,
        title: const Text('Sorprendeme'),
      ),
      backgroundColor: const Color(0xFF1A1A1A),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Tarjeta(
              nombre: tragoActual['nombre'],
              descripcion: tragoActual['descripcion'],
              ingredientes: tragoActual['ingredientes'],
              preparacion: tragoActual['preparacion'],
              decoracion: tragoActual['decoracion'],
              tags: List<String>.from(tragoActual['tags']),
              width: double.infinity,
              trago: tragoActual,
              onToggleFavorito: () {
                setState(() {
                  FavoritosManager().toggleFavorito(tragoActual);
                });
              },
            ),
            const SizedBox(height: 24),
            Boton(
              texto: '¡Otra Sorpresa!',
              onPressed: _refrescarTrago,
              padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 14),
              borderRadius: 8,
              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
