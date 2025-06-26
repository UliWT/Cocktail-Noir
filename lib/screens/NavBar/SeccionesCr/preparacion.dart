import 'package:flutter/material.dart';
import 'package:myapp/widgets/boton.dart';

class Preparacion extends StatelessWidget {
  final List<TextEditingController> pasos;
  final TextEditingController decoracionController;
  final VoidCallback onAgregarPaso;
  final Function(int) onEliminarPaso;
  final VoidCallback onVolver;
  final VoidCallback onContinuar;

  const Preparacion({
    super.key,
    required this.pasos,
    required this.decoracionController,
    required this.onAgregarPaso,
    required this.onEliminarPaso,
    required this.onVolver,
    required this.onContinuar,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView(
            children: [
              const Text('Pasos de preparación:', style: TextStyle(color: Color(0xFFFFD829))),
              const SizedBox(height: 10),
              ...List.generate(pasos.length, (i) => Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: pasos[i],
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'Paso ${i + 1}',
                        hintStyle: const TextStyle(color: Color(0xFFFFD829)),
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
                  IconButton(
                    onPressed: () => onEliminarPaso(i),
                    icon: const Icon(Icons.remove_circle, color: Colors.redAccent),
                  )
                ],
              )),
              const SizedBox(height: 16),
              Boton(
                texto: 'Agregar paso',
                onPressed: onAgregarPaso,
                padding: const EdgeInsets.all(12),
                borderRadius: 8,
                style: const TextStyle(fontSize: 15),
              ),
              const SizedBox(height: 30),
              const Text('Decoración final:', style: TextStyle(color: Color(0xFFFFD829))),
              const SizedBox(height: 10),
              TextField(
                controller: decoracionController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
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
            ],
          ),
        ),
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
                texto: 'Vista previa →',
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
