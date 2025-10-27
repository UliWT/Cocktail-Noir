import 'package:flutter/material.dart';
import 'package:myapp/widgets/boton.dart';

class Ingredientes extends StatelessWidget {
  final List<Map<String, dynamic>> ingredientes;
  final List<String> unidades;
  final List<TextEditingController> ingredienteControllers;
  final VoidCallback onAgregar;
  final Function(int) onEliminar;
  final VoidCallback onVolver;
  final VoidCallback onContinuar;

  const Ingredientes({
    super.key,
    required this.ingredientes,
    required this.unidades,
    required this.ingredienteControllers,
    required this.onAgregar,
    required this.onEliminar,
    required this.onVolver,
    required this.onContinuar,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: ingredientes.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: ingredienteControllers[index],
                        style: const TextStyle(color: Colors.white),
                        onChanged: (value) => ingredientes[index]['nombre'] = value,
                        decoration: InputDecoration(
                          labelText: 'Ingrediente',
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
                    ),
                    const SizedBox(width: 10),
                    DropdownButton<String>(
                      value: ingredientes[index]['unidad'],
                      dropdownColor: const Color(0xFF1A1A1A),
                      style: const TextStyle(color: Color(0xFFFFD829)),
                      underline: Container(),
                      iconEnabledColor: const Color(0xFFFFD829),
                      items: unidades.map((unidad) => DropdownMenuItem(
                        value: unidad,
                        child: Text(unidad),
                      )).toList(),
                      onChanged: (value) => ingredientes[index]['unidad'] = value,
                    ),
                    IconButton(
                      icon: const Icon(Icons.remove_circle, color: Colors.redAccent),
                      onPressed: () => onEliminar(index),
                    )
                  ],
                ),
              );
            },
          ),
        ),
        Boton(
          texto: 'Agregar ingrediente',
          onPressed: onAgregar,
          padding: const EdgeInsets.symmetric(horizontal:20 , vertical: 14),
          borderRadius: 12,
          style: const TextStyle(fontSize: 15),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Boton(
                texto: '← Volver',
                onPressed: onVolver,
                padding: const EdgeInsets.symmetric(vertical: 20),
                borderRadius: 5,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Boton(
                texto: 'Preparación →',
                onPressed: onContinuar,
                padding: const EdgeInsets.symmetric(vertical: 20),
                borderRadius: 5,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        )
      ],
    );
  }
}