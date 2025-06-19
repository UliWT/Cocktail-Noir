import 'package:flutter/material.dart';
import 'package:myapp/widgets/boton.dart';

class Preparacion extends StatefulWidget {
  final VoidCallback onVolver;
  final VoidCallback onContinuar;

  const Preparacion({
    super.key,
    required this.onVolver,
    required this.onContinuar,
  });

  @override
  State<Preparacion> createState() => _PreparacionState();
}

class _PreparacionState extends State<Preparacion> {
  final List<TextEditingController> _pasosControllers = [];
  final TextEditingController _decoracionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _pasosControllers.add(TextEditingController());
  }

  @override
  void dispose() {
    for (var c in _pasosControllers) {
      c.dispose();
    }
    _decoracionController.dispose();
    super.dispose();
  }

  void _agregarPaso() {
    setState(() {
      _pasosControllers.add(TextEditingController());
    });
  }

  void _eliminarPaso(int index) {
    setState(() {
      _pasosControllers[index].dispose();
      _pasosControllers.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: _pasosControllers.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _pasosControllers[index],
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          labelText: 'Paso ${index + 1}',
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
                    IconButton(
                      onPressed: () => _eliminarPaso(index),
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
          texto: 'Agregar paso',
          onPressed: _agregarPaso,
          padding: const EdgeInsets.symmetric(vertical: 14),
          borderRadius: 12,
          style: const TextStyle(fontSize: 15),
        ),
        const SizedBox(height: 20),
        TextField(
          controller: _decoracionController,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            labelText: 'Decoración',
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
                texto: 'Vista previa →',
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
