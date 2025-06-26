import 'package:flutter/material.dart';
import 'package:myapp/widgets/main_scaffold.dart';
import 'package:myapp/widgets/boton.dart';
import 'package:myapp/screens/NavBar/SeccionesCr/informacion.dart';
import 'package:myapp/screens/NavBar/SeccionesCr/ingredientes.dart';
import 'package:myapp/screens/NavBar/SeccionesCr/preparacion.dart';
import 'package:myapp/screens/NavBar/SeccionesCr/v_previa.dart';

class CrearScreen extends StatefulWidget {
  const CrearScreen({Key? key}) : super(key: key);

  @override
  State<CrearScreen> createState() => _CrearScreenState();
}

class _CrearScreenState extends State<CrearScreen> {
  int _seccionActiva = 0;

  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _descripcionController = TextEditingController();
  final TextEditingController _decoracionController = TextEditingController();

  final List<String> saborOpciones = [
    'Dulce', 'Seco', 'Herbaceo', 'Amargo', 'Cremoso', 'Ácido', 'Frutal',
    'Tropical', 'Salado', 'Clásico', 'Ahumado', 'Sedoso', 'Picante', 'Innovador',
    'Refrescante'
  ];
  final Set<String> saboresSeleccionados = {};

  final List<Map<String, dynamic>> ingredientes = [
    {'nombre': '', 'unidad': 'ml'}
  ];
  final List<String> unidades = ['ml', 'oz', 'cucharadas', 'pizcas', 'gotas'];
  final List<TextEditingController> _ingredienteControllers = [
    TextEditingController()
  ];

  final List<TextEditingController> _pasosPreparacion = [
    TextEditingController()
  ];

  void _agregarIngrediente() {
    setState(() {
      ingredientes.add({'nombre': '', 'unidad': 'ml'});
      _ingredienteControllers.add(TextEditingController());
    });
  }

  void _eliminarIngrediente(int index) {
    setState(() {
      ingredientes.removeAt(index);
      _ingredienteControllers[index].dispose();
      _ingredienteControllers.removeAt(index);
    });
  }

  void _toggleSabor(String sabor) {
    setState(() {
      if (saboresSeleccionados.contains(sabor)) {
        saboresSeleccionados.remove(sabor);
      } else {
        saboresSeleccionados.add(sabor);
      }
    });
  }

  void _agregarPaso() {
    setState(() {
      _pasosPreparacion.add(TextEditingController());
    });
  }

  void _eliminarPaso(int index) {
    setState(() {
      _pasosPreparacion[index].dispose();
      _pasosPreparacion.removeAt(index);
    });
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _descripcionController.dispose();
    _decoracionController.dispose();
    for (var c in _ingredienteControllers) {
      c.dispose();
    }
    for (var p in _pasosPreparacion) {
      p.dispose();
    }
    super.dispose();
  }

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
        return Informacion(
          nombreController: _nombreController,
          descripcionController: _descripcionController,
          saborOpciones: saborOpciones,
          saboresSeleccionados: saboresSeleccionados,
          onToggleSabor: _toggleSabor,
          onContinuar: () => setState(() => _seccionActiva = 1),
        );
      case 1:
        return Ingredientes(
          ingredientes: ingredientes,
          unidades: unidades,
          ingredienteControllers: _ingredienteControllers,
          onAgregar: _agregarIngrediente,
          onEliminar: _eliminarIngrediente,
          onVolver: () => setState(() => _seccionActiva = 0),
          onContinuar: () => setState(() => _seccionActiva = 2),
        );
      case 2:
        return Preparacion(
          pasos: _pasosPreparacion,
          decoracionController: _decoracionController,
          onAgregarPaso: _agregarPaso,
          onEliminarPaso: _eliminarPaso,
          onVolver: () => setState(() => _seccionActiva = 1),
          onContinuar: () => setState(() => _seccionActiva = 3),
        );
        case 3:
          return VPrevia(
            nombre: _nombreController.text,
            descripcion: _descripcionController.text,
            sabores: saboresSeleccionados.toList(),
            ingredientes: ingredientes,
            pasos: _pasosPreparacion.map((c) => c.text).toList(),
            decoracion: _decoracionController.text,
            onVolver: () => setState(() => _seccionActiva = 2),
          );

      default:
        return const SizedBox.shrink();
    }
  }
}
