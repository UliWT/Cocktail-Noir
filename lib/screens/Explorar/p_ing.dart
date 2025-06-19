import 'package:flutter/material.dart';
import 'package:myapp/widgets/main_scaffold.dart';
import 'package:myapp/widgets/textField.dart';
import 'package:myapp/widgets/boton.dart';
import 'package:myapp/widgets/tarjeta.dart';
import 'package:myapp/data/tragos.dart';
import 'package:myapp/widgets/modalSheet.dart';

class PIngScreen extends StatefulWidget {
  const PIngScreen({super.key});

  @override
  State<PIngScreen> createState() => _PIngScreenState();
}

class _PIngScreenState extends State<PIngScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<String> _ingredientesSeleccionados = [];

  String normalizar(String texto) {
    return texto
        .toLowerCase()
        .replaceAll(RegExp(r'[^\w\s]'), '')
        .replaceAll(RegExp(r'\d+'), '')
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim();
  }

  void _agregarIngrediente() {
    final texto = _controller.text.trim();
    if (texto.isNotEmpty && !_ingredientesSeleccionados.contains(texto.toLowerCase())) {
      setState(() {
        _ingredientesSeleccionados.add(texto);
        _controller.clear();
      });
    }
  }

  void _quitarIngrediente(String ingrediente) {
    setState(() {
      _ingredientesSeleccionados.remove(ingrediente);
    });
  }

  @override
  Widget build(BuildContext context) {
    final ingredientesUsuario = _ingredientesSeleccionados.map(normalizar).toSet();

    final List<Map<String, dynamic>> tragosPosibles = _ingredientesSeleccionados.isEmpty
        ? []
        : tragos.where((trago) {
            final ingredientesTrago = (trago['ingredientes'] as String)
                .split('\n')
                .map(normalizar)
                .toList();

            return _ingredientesSeleccionados.every((ing) {
              final ingNorm = normalizar(ing);
              return ingredientesTrago.any((i) => i.contains(ingNorm));
            });
          }).toList();

    final List<Map<String, dynamic>> tragosFaltantes = _ingredientesSeleccionados.isEmpty
        ? []
        : tragos.where((trago) {
            final ingredientesTrago = (trago['ingredientes'] as String)
                .split('\n')
                .map(normalizar)
                .toList();

            final tieneAlgunos = _ingredientesSeleccionados.any((ing) {
              final ingNorm = normalizar(ing);
              return ingredientesTrago.any((i) => i.contains(ingNorm));
            });

            final leFaltan = !_ingredientesSeleccionados.every((ing) {
              final ingNorm = normalizar(ing);
              return ingredientesTrago.any((i) => i.contains(ingNorm));
            });

            return tieneAlgunos && leFaltan;
          }).toList();

    return MainScaffold(
      selectedIndex: 0,
      appBar: AppBar(
        title: const Text('Buscar por Ingrediente'),
        backgroundColor: const Color(0xFF1A1A1A),
      ),
      backgroundColor: const Color(0xFF1A1A1A),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            BarraBusqueda(
              controller: _controller,
              onBuscar: _agregarIngrediente,
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 48,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: _ingredientesSeleccionados.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final ingrediente = _ingredientesSeleccionados[index];
                  return Boton(
                    texto: ingrediente,
                    onPressed: () => _quitarIngrediente(ingrediente),
                    style: const TextStyle(fontSize: 14),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    borderRadius: 20,
                  );
                },
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: ListView(
                children: [
                  if (_ingredientesSeleccionados.isNotEmpty) ...[
                    Text(
                      'Tragos posibles:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.yellow.shade400,
                      ),
                    ),
                    const SizedBox(height: 8),
                    if (tragosPosibles.isEmpty)
                      Text('No se encontraron tragos.', style: TextStyle(color: Colors.grey.shade400))
                    else
                      ...tragosPosibles.map((trago) => GestureDetector(
                            onTap: () => mostrarDetalleTrago(context, trago, onFavoritoChanged: () {  }),
                            child: Tarjeta(
                              nombre: trago['nombre'] as String,
                              descripcion: trago['descripcion'] as String?,
                              tags: const [],
                            ),
                          )),
                    const SizedBox(height: 24),
                    Text(
                      'Lo que te falta:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.yellow.shade400,
                      ),
                    ),
                    const SizedBox(height: 8),
                    if (tragosFaltantes.isEmpty)
                      Text('Nada por aquí todavía...', style: TextStyle(color: Colors.grey.shade400))
                    else
                      ...tragosFaltantes.map((trago) {
                        final ingredientesTrago = (trago['ingredientes'] as String)
                            .split('\n')
                            .map((i) => i.trim())
                            .toList();

                        final faltantes = ingredientesTrago.where((i) {
                          return !_ingredientesSeleccionados.any((sel) =>
                              normalizar(sel) == normalizar(i));
                        }).toList();

                        return GestureDetector(
                          onTap: () => mostrarDetalleTrago(context, trago, onFavoritoChanged: () {  }),
                          child: Tarjeta(
                            nombre: trago['nombre'] as String,
                            descripcion:
                                '${trago['descripcion'] ?? ''}\nFaltan: ${faltantes.join(', ')}',
                            tags: const [],
                          ),
                        );
                      })
                  ] else
                    Center(
                      child: Text(
                        'Agregá ingredientes para ver qué podés preparar.',
                        style: TextStyle(color: Colors.grey.shade500),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
