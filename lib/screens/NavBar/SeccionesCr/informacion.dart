import 'package:flutter/material.dart';
import 'package:myapp/widgets/boton.dart';

class Informacion extends StatefulWidget {
  final TextEditingController nombreController;
  final TextEditingController descripcionController;
  final List<String> saborOpciones;
  final Set<String> saboresSeleccionados;
  final void Function(String) onToggleSabor;
  final VoidCallback onContinuar;

  const Informacion({
    super.key,
    required this.nombreController,
    required this.descripcionController,
    required this.saborOpciones,
    required this.saboresSeleccionados,
    required this.onToggleSabor,
    required this.onContinuar,
  });

  @override
  State<Informacion> createState() => _InformacionState();
}

class _InformacionState extends State<Informacion> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        TextField(
          controller: widget.nombreController,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            labelText: 'Nombre del trago',
            labelStyle: const TextStyle(color: Color(0xFFFFD829)),
            fillColor: const Color(0xFF303030),
            filled: true,
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Color(0xFFFFD829)),
              borderRadius: BorderRadius.circular(8),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Color(0xFFFFD829), width: 2),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: widget.descripcionController,
          style: const TextStyle(color: Colors.white),
          maxLines: 3,
          decoration: InputDecoration(
            labelText: 'Descripción',
            labelStyle: const TextStyle(color: Color(0xFFFFD829)),
            fillColor: const Color(0xFF303030),
            filled: true,
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Color(0xFFFFD829)),
              borderRadius: BorderRadius.circular(8),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Color(0xFFFFD829), width: 2),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          'Seleccioná los sabores:',
          style: TextStyle(
            color: Color(0xFFFFD829),
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: widget.saborOpciones.map((sabor) {
            final seleccionado = widget.saboresSeleccionados.contains(sabor);
            return Boton(
              texto: sabor,
              seleccionado: seleccionado,
              onPressed: () => widget.onToggleSabor(sabor),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              borderRadius: 10,
              style: const TextStyle(fontSize: 14),
            );
          }).toList(),
        ),
        const SizedBox(height: 30),
        Boton(
          texto: 'Continuar a ingredientes',
          onPressed: widget.onContinuar,
          padding: const EdgeInsets.symmetric(vertical: 18),
          borderRadius: 5,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
