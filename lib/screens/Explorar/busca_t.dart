import 'package:flutter/material.dart';
import 'package:myapp/widgets/main_scaffold.dart';
import 'package:myapp/widgets/boton.dart';
import 'package:myapp/data/tragos.dart';
import 'package:myapp/widgets/modalSheet.dart';

typedef Tag = String;

class BuscarTScreen extends StatefulWidget {
  const BuscarTScreen({super.key});

  @override
  State<BuscarTScreen> createState() => _BuscarTScreenState();
}

class _BuscarTScreenState extends State<BuscarTScreen> {
  String? _alcohol;
  String? _intensidad;
  final Set<Tag> _sabores = {};

  final List<Tag> saborOpciones = [
    'Dulce', 'Seco', 'Herbaceo', 'Amargo', 'Cremoso', 'Ácido', 'Frutal',
    'Tropical', 'Salado', 'Clásico', 'Ahumado', 'Sedoso', 'Picante', 'Innovador',
    'Refrescante'
  ];

  void _toggleSabor(String tag) {
    setState(() {
      if (_sabores.contains(tag)) {
        _sabores.remove(tag);
      } else {
        _sabores.add(tag);
      }
    });
  }

  void _buscarTragoIdeal() {
    final tagsElegidos = {
      if (_alcohol != null) _alcohol!,
      if (_intensidad != null) _intensidad!,
      ..._sabores,
    };

    final tragosCoincidentes = tragos.where((trago) {
      final tagsTrago = List<String>.from(trago['tags'] ?? []);
      final coincidencias = tagsTrago.where((tag) => tagsElegidos.contains(tag)).length;
      return coincidencias >= 2;
    }).toList();

    if (tragosCoincidentes.isNotEmpty) {
      tragosCoincidentes.shuffle();
      final tragoElegido = tragosCoincidentes.first;

      mostrarDetalleTrago(
        context,
        tragoElegido,
        onFavoritoChanged: () => setState(() {}),
      );
    } else {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          backgroundColor: const Color(0xFF1A1A1A),
          title: const Text("Sin resultados", style: TextStyle(color: Colors.white)),
          content: const Text("No se encontró ningún trago con al menos 2 coincidencias.", style: TextStyle(color: Colors.white70)),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Aceptar", style: TextStyle(color: Color(0xFFFFCD29))),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      selectedIndex: 0,
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1A1A),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFFFFCD29)),
          onPressed: () => Navigator.pop(context),
        ),
        elevation: 0,
        title: const Text(''),
      ),
      backgroundColor: const Color(0xFF1A1A1A),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // Alcohol
          const Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                'Con alcohol o sin alcohol?',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFFFCD29),
                ),
              ),
            ),
          ),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            alignment: WrapAlignment.center,
            children: ['Con Alcohol', 'Sin Alcohol'].map((opcion) {
              return Boton(
                texto: opcion,
                seleccionado: _alcohol == opcion,
                onPressed: () => setState(() => _alcohol = opcion),
                style: const TextStyle(fontSize: 14),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                borderRadius: 20,
              );
            }).toList(),
          ),

          // Intensidad
          const Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Text(
                'Con qué intensidad?',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFFFCD29),
                ),
              ),
            ),
          ),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            alignment: WrapAlignment.center,
            children: ['Suave', 'Moderado', 'Fuerte'].map((opcion) {
              return Boton(
                texto: opcion,
                seleccionado: _intensidad == opcion,
                onPressed: () => setState(() => _intensidad = opcion),
                style: const TextStyle(fontSize: 14),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                borderRadius: 20,
              );
            }).toList(),
          ),

          // Sabores
          const Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Text(
                'Qué sabor buscás?',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFFFCD29),
                ),
              ),
            ),
          ),
          Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 500),
              child: GridView.count(
                crossAxisCount: 3,
                shrinkWrap: true,
                crossAxisSpacing: 10,
                mainAxisSpacing: 6,
                childAspectRatio: 2.6,
                physics: const NeverScrollableScrollPhysics(),
                children: saborOpciones.map((sabor) {
                  return Boton(
                    texto: sabor,
                    seleccionado: _sabores.contains(sabor),
                    onPressed: () => _toggleSabor(sabor),
                    style: const TextStyle(fontSize: 13),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    borderRadius: 20,
                  );
                }).toList(),
              ),
            ),
          ),

          const SizedBox(height: 30),

          Center(
            child: Boton(
              texto: "Buscar mi trago ideal",
              onPressed: _buscarTragoIdeal,
              seleccionado: false,
              padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 20),
              borderRadius: 15,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
