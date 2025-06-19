import 'package:flutter/material.dart';
import 'package:myapp/widgets/main_scaffold.dart';
import 'package:myapp/widgets/modalSheet.dart';
import 'package:myapp/widgets/textField.dart';
import 'package:myapp/widgets/boton.dart';
import 'package:myapp/widgets/tarjeta.dart';
import 'package:myapp/mi_bar_manager.dart';
import 'package:myapp/data/tragos.dart'; // Aquí la lista de tragos

class PIngScreen extends StatefulWidget {
  const PIngScreen({super.key});

  @override
  State<PIngScreen> createState() => _PIngScreenState();
}

class _PIngScreenState extends State<PIngScreen> {
  final TextEditingController _controller = TextEditingController();
  List<String> _ingredientesSeleccionados = [];
  String _busqueda = '';

  @override
  void initState() {
    super.initState();
    // Cargo los ingredientes seleccionados del singleton (todos los que hay)
    _ingredientesSeleccionados = MiBarManager()
        .obtenerSeleccionados()
        .values
        .expand((s) => s)
        .toSet()
        .toList();
  }

  String normalizar(String texto) {
    return texto
        .toLowerCase()
        .replaceAll(RegExp(r'[áàä]'), 'a')
        .replaceAll(RegExp(r'[éèë]'), 'e')
        .replaceAll(RegExp(r'[íìï]'), 'i')
        .replaceAll(RegExp(r'[óòö]'), 'o')
        .replaceAll(RegExp(r'[úùü]'), 'u')
        .trim();
  }

  void _buscar() {
    setState(() {
      _busqueda = _controller.text.trim();
      // _controller.clear(); // opcional si querés limpiar el input luego de buscar
    });
  }

  void _quitarIngrediente(String ingrediente) {
    setState(() {
      _ingredientesSeleccionados.remove(ingrediente);
      // También removemos del singleton para que quede sincronizado
      final seleccionados = MiBarManager().obtenerSeleccionados();
      seleccionados.forEach((categoria, items) {
        items.remove(ingrediente);
      });
      if (_busqueda == ingrediente) _busqueda = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    final busquedaNormalizada = normalizar(_busqueda);

    final ingredientesFiltrados = _busqueda.isEmpty
        ? _ingredientesSeleccionados
        : _ingredientesSeleccionados
            .where((ing) => normalizar(ing).contains(busquedaNormalizada))
            .toList();

    final tragosPosibles = tragos.where((trago) {
      final ingredientesTrago = trago['ingredientes']
          .toString()
          .split('\n')
          .map((i) => normalizar(i))
          .toList();

      return _ingredientesSeleccionados.every((ingSel) {
        final ingNorm = normalizar(ingSel);
        return ingredientesTrago.any((ingTrago) => ingTrago.contains(ingNorm));
      });
    }).toList();

    final tragosFaltantes = tragos.where((trago) {
      final ingredientesTrago = trago['ingredientes']
          .toString()
          .split('\n')
          .map((i) => normalizar(i))
          .toList();

      final tieneAlguno = _ingredientesSeleccionados.any((ingSel) {
        final ingNorm = normalizar(ingSel);
        return ingredientesTrago.any((ingTrago) => ingTrago.contains(ingNorm));
      });

      final leFaltan = _ingredientesSeleccionados.any((ingSel) {
        final ingNorm = normalizar(ingSel);
        return !ingredientesTrago.any((ingTrago) => ingTrago.contains(ingNorm));
      });

      return tieneAlguno && leFaltan;
    }).toList();

    return MainScaffold(
      selectedIndex: 0,
      appBar: AppBar(
        title: const Text("Buscar por ingrediente"),
      ),
      backgroundColor: const Color(0xFF1A1A1A),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            BarraBusqueda(
              controller: _controller,
              onBuscar: _buscar,
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 50,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: ingredientesFiltrados.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final ing = ingredientesFiltrados[index];
                  return Boton(
                    texto: ing,
                    onPressed: () => _quitarIngrediente(ing),
                    style: const TextStyle(fontSize: 14),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    borderRadius: 20,
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: [
                  Text(
                    'Posibles resultados:',
                    style: TextStyle(
                        color: Colors.yellow.shade400,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                  const SizedBox(height: 12),
                  if (tragosPosibles.isEmpty)
                    Text(
                      'No se encontraron tragos con esos ingredientes',
                      style: TextStyle(color: Colors.grey.shade400),
                    )
                  else
                    ...tragosPosibles.map((trago) => Tarjeta(
                          nombre: trago['nombre'] as String,
                          descripcion: trago['descripcion'] as String,
                          onTap: () {
                            // navegación o acción
                          },
                        )),
                  const SizedBox(height: 32),
                  Text(
                    'Lo que te falta:',
                    style: TextStyle(
                        color: Colors.yellow.shade400,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                  const SizedBox(height: 12),
                  if (tragosFaltantes.isEmpty)
                    Text(
                      'No hay tragos que puedas preparar con los ingredientes seleccionados',
                      style: TextStyle(color: Colors.grey.shade400),
                    )
                  else
                    ...tragosFaltantes.map((trago) {
                      final ingredientesTrago = trago['ingredientes']
                          .toString()
                          .split('\n')
                          .map((i) => i.trim())
                          .toList();

                      final faltantes = ingredientesTrago
                          .where((i) =>
                              !_ingredientesSeleccionados.any((sel) =>
                                  normalizar(sel) ==
                                  normalizar(i))) // comparación sin tildes ni case
                          .toList();

                      return Tarjeta(
                          nombre: trago['nombre'] as String,
                          descripcion: trago['descripcion'] as String,
                          onTap: () => mostrarDetalleTrago(context, trago),
                      );
                    }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
