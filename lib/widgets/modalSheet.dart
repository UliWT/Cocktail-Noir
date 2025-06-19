import 'package:flutter/material.dart';
import 'tarjeta.dart';

void mostrarDetalleTrago(BuildContext context, Map<String, dynamic> trago) {
  showModalBottomSheet(
    context: context,
    backgroundColor: const Color(0xFF1A1A1A),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    isScrollControlled: true, // para que el contenido pueda ser alto y scrolleable
    builder: (context) => DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.7, // tamaño inicial en pantalla (70%)
      minChildSize: 0.4,
      maxChildSize: 0.95,
      builder: (context, scrollController) {
        return SingleChildScrollView(
          controller: scrollController,
          padding: const EdgeInsets.all(16),
          child: Tarjeta(
            nombre: trago['nombre'],
            descripcion: trago['descripcion'],
            ingredientes: trago['ingredientes'],
            preparacion: trago['preparacion'],
            decoracion: trago['decoracion'],
            tags: List<String>.from(trago['tags'] ?? []),
            width: double.infinity,
            padding: const EdgeInsets.all(20),
          ),
        );
      },
    ),
  );
}
