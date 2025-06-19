import 'package:flutter/material.dart';
import 'package:myapp/widgets/tarjeta.dart';

void mostrarDetalleTrago(BuildContext context, Map<String, dynamic> trago) {
  showModalBottomSheet(
    context: context,
    backgroundColor: const Color(0xFF1A1A1A),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    isScrollControlled: true,
    builder: (context) => DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.7,
      minChildSize: 0.4,
      maxChildSize: 0.95,
      builder: (context, scrollController) {
        return SingleChildScrollView(
          controller: scrollController,
          padding: const EdgeInsets.all(16),
          child: Tarjeta.desdeMapa(
            trago,
            width: double.infinity,
            padding: const EdgeInsets.all(20),
          ),
        );
      },
    ),
  );
}
