import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:myapp/utils/normalizer.dart'; // Asegurate de que la ruta sea correcta

class MiBarManager {
  static final MiBarManager _instancia = MiBarManager._interno();
  final Map<String, Set<String>> _seleccionados = {};

  factory MiBarManager() => _instancia;
  MiBarManager._interno();

  // --- PERSISTENCIA ---

  Future<void> cargarSeleccion() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? jsonData = prefs.getString('mibar_seleccion');
      
      if (jsonData != null) {
        final Map<String, dynamic> decoded = jsonDecode(jsonData);
        _seleccionados.clear();
        decoded.forEach((categoria, items) {
          _seleccionados[categoria] = Set<String>.from(items);
        });
      }
    } catch (e) {
      print("Error cargando Mi Bar: $e");
    }
  }

  Future<void> _guardarEnStorage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final Map<String, List<String>> paraGuardar = _seleccionados.map(
        (key, value) => MapEntry(key, value.toList()),
      );
      await prefs.setString('mibar_seleccion', jsonEncode(paraGuardar));
    } catch (e) {
      print("Error guardando Mi Bar: $e");
    }
  }

  // --- LÓGICA DE SELECCIÓN ---

  void inicializarCategorias(Iterable<String> categorias) {
    for (var cat in categorias) {
      _seleccionados.putIfAbsent(cat, () => <String>{});
    }
  }

  Future<void> toggleSeleccion(String categoria, String item) async {
    final set = _seleccionados.putIfAbsent(categoria, () => <String>{});
    if (set.contains(item)) {
      set.remove(item);
    } else {
      set.add(item);
    }
    await _guardarEnStorage();
  }

  Future<void> toggleSeleccionCategoria(String categoria, Iterable<String> items) async {
    final set = _seleccionados.putIfAbsent(categoria, () => <String>{});
    final allSelected = items.every((i) => set.contains(i));
    if (allSelected) {
      for (var i in items) set.remove(i);
    } else {
      for (var i in items) set.add(i);
    }
    await _guardarEnStorage();
  }

  // --- CONSULTAS ---

  bool esSeleccionado(String categoria, String item) {
    return _seleccionados[categoria]?.contains(item) ?? false;
  }

  bool isCategoriaAllSelected(String categoria, Iterable<String> items) {
    return items.isNotEmpty && items.every((i) => _seleccionados[categoria]?.contains(i) ?? false);
  }

  /// ESTA ES LA FUNCIÓN CLAVE PARA EL BUSCADOR
  List<String> getAllSelectedIngredients() {
    final allRawStrings = <String>{};

    _seleccionados.forEach((categoria, itemsSet) {
      if (itemsSet.isNotEmpty) {
        // 1. Agregamos la categoría sola (ej: "Ron")
        allRawStrings.add(categoria);

        for (var item in itemsSet) {
          // 2. Agregamos el item solo (ej: "Blanco")
          allRawStrings.add(item);
          
          // 3. Agregamos la combinación (ej: "Ron Blanco")
          // Esto es lo que hace que el Daiquiri funcione
          allRawStrings.add("$categoria $item");
        }
      }
    });

    // Normalizamos toda la lista antes de mandarla al buscador
    return allRawStrings
        .map((e) => normalizeIngredient(e))
        .where((e) => e.isNotEmpty)
        .toList();
  }
}