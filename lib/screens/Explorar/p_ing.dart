import 'package:flutter/material.dart';
import 'package:myapp/widgets/main_scaffold.dart';
import 'package:myapp/widgets/textField.dart';
import 'package:myapp/widgets/boton.dart';
import 'package:myapp/widgets/tarjeta.dart';
import 'package:myapp/data/db_helper.dart';
import 'package:myapp/widgets/modalSheet.dart';
import 'package:myapp/mi_bar_manager.dart';

class PIngScreen extends StatefulWidget {
  const PIngScreen({super.key});

  @override
  State<PIngScreen> createState() => _PIngScreenState();
}

class _PIngScreenState extends State<PIngScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<String> _ingredientesSeleccionados = [];
  List<Map<String, dynamic>> _todosTragos = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _cargarTragos();
  }

  Future<void> _cargarTragos() async {
    try {
      final dbTragos = await DBHelper().getAllTragos();
      setState(() {
        _todosTragos = dbTragos;
        _isLoading = false;
      });
    } catch (e) {
      print('Error cargando tragos en p_ing: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

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
    

    // Ingredientes disponibles: lo que seleccionó el usuario en MiBar + lo que agregó manualmente
    final miBarDisponibles = MiBarManager().getAllSelectedIngredients().map(normalizar).toSet();
    final userAdded = _ingredientesSeleccionados.map(normalizar).toSet();
    final availableSet = {...miBarDisponibles, ...userAdded};

    // Ingredientes para filtrar (lo que el usuario buscó explícitamente)
    final filterTerms = _ingredientesSeleccionados.map(normalizar).toList();

    // Si no hay términos de filtro y tampoco hay items en MiBar, no mostrar resultados
    if (filterTerms.isEmpty && miBarDisponibles.isEmpty) {
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
              const Center(child: Text('Agregá ingredientes o marcá lo que tenés en Mi Bar')),
            ],
          ),
        ),
      );
    }

    final List<Map<String, dynamic>> candidatos = _todosTragos.where((trago) {
      final ingredientesTrago = (trago['ingredientes'] as String)
          .split('\n')
          .map(normalizar)
          .toList();

      // El trago es candidato si contiene todos los términos de filtro (si hay)
      if (filterTerms.isNotEmpty) {
        return filterTerms.every((term) => ingredientesTrago.any((i) => i.contains(term)));
      }
      // Si no hay filtro explícito, considerar todos los tragos
      return true;
    }).toList();

    final tragosPosibles = <Map<String, dynamic>>[];
    final tragosFaltantes = <Map<String, dynamic>>[];

    for (var trago in candidatos) {
      final ingredientesTrago = (trago['ingredientes'] as String)
          .split('\n')
          .map(normalizar)
          .toList();

      // verificar si todos los ingredientes del trago están cubiertos por availableSet
      final missing = <String>[];
      for (var ingr in ingredientesTrago) {
        final matched = availableSet.any((a) => ingr.contains(a) || a.contains(ingr));
        if (!matched) missing.add(ingr);
      }

      if (missing.isEmpty) {
        tragosPosibles.add(trago);
      } else {
        // marcar solo si el trago contiene alguno de los términos de filtro (para relevancia)
        final tieneAlgunoFiltro = filterTerms.isEmpty
            ? true
            : filterTerms.any((term) => ingredientesTrago.any((i) => i.contains(term)));
        if (tieneAlgunoFiltro) tragosFaltantes.add(trago);
      }
    }

    return MainScaffold(
      selectedIndex: 0,
      appBar: AppBar(
        title: const Text('Buscar por Ingrediente'),
        backgroundColor: const Color(0xFF1A1A1A),
      ),
      backgroundColor: const Color(0xFF1A1A1A),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(color: Colors.yellow),
            )
          : Padding(
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
                  if (_ingredientesSeleccionados.isNotEmpty || MiBarManager().getAllSelectedIngredients().isNotEmpty) ...[
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
                            onTap: () => mostrarDetalleTrago(context, trago, onFavoritoChanged: () => setState(() {})),
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
                          onTap: () => mostrarDetalleTrago(context, trago, onFavoritoChanged: () => setState(() {})),
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
