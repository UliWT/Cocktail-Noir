import 'package:flutter/material.dart';
import 'package:myapp/widgets/boton.dart';
import 'package:myapp/widgets/tarjeta.dart';  

class VPrevia extends StatelessWidget {
  final String nombre;
  final String descripcion;
  final List<String> sabores;
  final List<Map<String, dynamic>> ingredientes;
  final List<String> pasos;
  final String decoracion;
  final VoidCallback onVolver;

  const VPrevia({
    super.key,
    required this.nombre,
    required this.descripcion,
    required this.sabores,
    required this.ingredientes,
    required this.pasos,
    required this.decoracion,
    required this.onVolver,
  });

  @override
  Widget build(BuildContext context) {
    final ingredientesStr = ingredientes
        .map((e) => '${e['nombre'] ?? ''} (${e['unidad'] ?? ''})')
        .join('\n');
    final preparacionStr = pasos.asMap().entries.map((entry) {
      final idx = entry.key + 1;
      final paso = entry.value;
      return '$idx. $paso';
    }).join('\n');

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Tarjeta(
              nombre: nombre,
              descripcion: descripcion,
              ingredientes: ingredientesStr,
              preparacion: preparacionStr,
              decoracion: decoracion,
              tags: sabores,
              width: double.infinity,
              padding: const EdgeInsets.all(20),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
          child:Boton(
          texto: 'Crear Trago',
          onPressed: (){},
          padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 20),
          borderRadius: 5,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        ),
      ],
    );
  }
}
