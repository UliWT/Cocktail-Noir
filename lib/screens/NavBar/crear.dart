import 'package:flutter/material.dart';
import 'package:myapp/widgets/main_scaffold.dart';
import 'package:myapp/widgets/boton.dart';

class CrearScreen extends StatefulWidget {
  const CrearScreen({Key? key}) : super(key: key);

  @override
  State<CrearScreen> createState() => _CrearScreenState();
}

class _CrearScreenState extends State<CrearScreen> {
  int _seccionActiva = 0;
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _descripcionController = TextEditingController();
  final List<String> saborOpciones = [
    'Dulce', 'Seco', 'Herbaceo', 'Amargo', 'Cremoso', 'Ácido', 'Frutal',
    'Tropical', 'Salado', 'Clásico', 'Ahumado', 'Sedoso', 'Picante', 'Innovador',
    'Refrescante'
  ];

  final Set<String> saboresSeleccionados = {};

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      selectedIndex: 2,
      backgroundColor: const Color(0xFF1A1A1A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1A1A),
        title: const Text('Crear', style: TextStyle(color: Color(0xFFFFD829))),
        iconTheme: const IconThemeData(color: Color(0xFFFFD829)),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            SizedBox(
              height: 100,
              child: GridView.count(
                crossAxisCount: 4,
                childAspectRatio: 2.6,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  Boton(
                    texto: 'Información',
                    style: const TextStyle(fontSize: 13),
                    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                    borderRadius: 5,
                    seleccionado: _seccionActiva == 0,
                    onPressed: () => setState(() => _seccionActiva = 0),
                  ),
                  Boton(
                    texto: 'Ingredientes',
                    style: const TextStyle(fontSize: 13),
                    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                    borderRadius: 5,
                    seleccionado: _seccionActiva == 1,
                    onPressed: () => setState(() => _seccionActiva = 1),
                  ),
                  Boton(
                    texto: 'Preparación',
                    style: const TextStyle(fontSize: 13),
                    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                    borderRadius: 5,
                    seleccionado: _seccionActiva == 2,
                    onPressed: () => setState(() => _seccionActiva = 2),
                  ),
                  Boton(
                    texto: 'Vista previa',
                    style: const TextStyle(fontSize: 13),
                    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                    borderRadius: 5,
                    seleccionado: _seccionActiva == 3,
                    onPressed: () => setState(() => _seccionActiva = 3),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(child: _construirSeccion()),
          ],
        ),
      ),
    );
  }

  Widget _construirSeccion() {
    switch (_seccionActiva) {
      case 0:
        return _seccionInformacion();
      case 1:
        return const Center(
          child: Text('Ingredientes - en construcción', style: TextStyle(color: Colors.white)),
        );
      case 2:
        return const Center(
          child: Text('Preparación - en construcción', style: TextStyle(color: Colors.white)),
        );
      case 3:
        return const Center(
          child: Text('Vista previa - en construcción', style: TextStyle(color: Colors.white)),
        );
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _seccionInformacion() {
    return ListView(
      children: [
        TextField(
          controller: _nombreController,
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
          controller: _descripcionController,
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
          style: TextStyle(color: Color(0xFFFFD829), fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: saborOpciones.map((sabor) {
            final bool seleccionado = saboresSeleccionados.contains(sabor);
            return Boton(
              texto: sabor,
              seleccionado: seleccionado,
              onPressed: () {
                setState(() {
                  if (seleccionado) {
                    saboresSeleccionados.remove(sabor);
                  } else {
                    saboresSeleccionados.add(sabor);
                  }
                });
              },
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              borderRadius: 10,
              style: const TextStyle(fontSize: 14),
            );
          }).toList(),
        ),
        const SizedBox(height: 30),
        Boton(
          texto: 'Continuar a ingredientes',
          onPressed: () => setState(() => _seccionActiva = 1),
          padding: const EdgeInsets.symmetric(vertical: 18),
          borderRadius: 5,
          style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
