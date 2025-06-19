import 'package:flutter/material.dart';

class VPrevia extends StatelessWidget {
  final String nombre;
  final String descripcion;
  final List<String> sabores;
  final List<Map<String, dynamic>> ingredientes;

  const VPrevia({
    super.key,
    required this.nombre,
    required this.descripcion,
    required this.sabores,
    required this.ingredientes,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          nombre,
          style: const TextStyle(
            color: Color(0xFFFFD829),
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          descripcion,
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
        const SizedBox(height: 20),
        const Text(
          'Sabores:',
          style: TextStyle(color: Color(0xFFFFD829), fontWeight: FontWeight.bold),
        ),
        Wrap(
          spacing: 8,
          children: sabores.map((sabor) {
            return Chip(
              label: Text(sabor),
              backgroundColor: const Color(0xFFFFD829).withOpacity(0.3),
              labelStyle: const TextStyle(color: Colors.black),
            );
          }).toList(),
        ),
        const SizedBox(height: 20),
        const Text(
          'Ingredientes:',
          style: TextStyle(color: Color(0xFFFFD829), fontWeight: FontWeight.bold),
        ),
        ...ingredientes.map((ing) {
          return Text(
            '${ing['nombre']} - ${ing['unidad']}',
            style: const TextStyle(color: Colors.white),
          );
        }).toList(),
        const SizedBox(height: 20),
        // Podrías agregar aquí la preparación y decoración cuando las tengas
      ],
    );
  }
}
