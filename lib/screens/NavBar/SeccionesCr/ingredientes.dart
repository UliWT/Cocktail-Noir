import 'package:flutter/material.dart';
import 'package:myapp/widgets/boton.dart';

class Ingredientes extends StatefulWidget {
  final List<Map<String, dynamic>> ingredientes;
  final List<String> unidades;
  final List<TextEditingController> ingredienteControllers;
  final VoidCallback onAgregar;
  final void Function(int) onEliminar;
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
  State<Ingredientes> createState() => _IngredientesState();
}

class _IngredientesState extends State<Ingredientes> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: widget.ingredientes.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: widget.ingredienteControllers[index],
                        style: const TextStyle(color: Colors.white),
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
                        onChanged: (value) {
                          widget.ingredientes[index]['nombre'] = value;
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    DropdownButton<String>(
                      value: widget.ingredientes[index]['unidad'],
                      dropdownColor: const Color(0xFF1A1A1A),
                      style: const TextStyle(color: Color(0xFFFFD829)),
                      underline: Container(),
                      iconEnabledColor: const Color(0xFFFFD829),
                      items: widget.unidades.map((unidad) {
                        return DropdownMenuItem<String>(
                          value: unidad,
                          child: Text(unidad),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          widget.ingredientes[index]['unidad'] = value!;
                        });
                      },
                    ),
                    const SizedBox(width: 5),
                    IconButton(
                      onPressed: () => widget.onEliminar(index),
                      icon: const Icon(Icons.remove_circle, color: Colors.redAccent),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 10),
        Boton(
          texto: 'Agregar ingrediente',
          onPressed: widget.onAgregar,
          padding: const EdgeInsets.symmetric(vertical: 14),
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
                onPressed: widget.onVolver,
                padding: const EdgeInsets.symmetric(vertical: 16),
                borderRadius: 12,
                style: const TextStyle(fontSize: 15),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Boton(
                texto: 'Preparación →',
                onPressed: widget.onContinuar,
                padding: const EdgeInsets.symmetric(vertical: 16),
                borderRadius: 12,
                style: const TextStyle(fontSize: 15),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
