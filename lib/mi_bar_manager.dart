import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class MiBarManager {
  static final MiBarManager _instancia = MiBarManager._interno();
  // El mapa donde guardamos Categoría -> Set de Ingredientes
  final Map<String, Set<String>> _seleccionados = {};

  factory MiBarManager() => _instancia;
  MiBarManager._interno();

  Future<void> cargarSeleccion() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? jsonData = prefs.getString('mibar_seleccion');
      
      if (jsonData != null) {
        final Map<String, dynamic> decoded = jsonDecode(jsonData);
        _seleccionados.clear();
        
        decoded.forEach((categoria, items) {
          // Convertimos la lista que viene del JSON de nuevo a un Set
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
      // Convertimos los Sets a Listas para que jsonEncode no falle
      final Map<String, List<String>> paraGuardar = _seleccionados.map(
        (key, value) => MapEntry(key, value.toList()),
      );
      await prefs.setString('mibar_seleccion', jsonEncode(paraGuardar));
    } catch (e) {
      print("Error guardando Mi Bar: $e");
    }
  }

  void inicializarCategorias(Iterable<String> categorias) {
    for (var cat in categorias) {
      _seleccionados.putIfAbsent(cat, () => <String>{});
    }
    // No guardamos acá porque es solo inicialización de estructura
  }

  Future<void> toggleSeleccion(String categoria, String item) async {
    final set = _seleccionados.putIfAbsent(categoria, () => <String>{});
    if (set.contains(item)) {
      set.remove(item);
    } else {
      set.add(item);
    }
    await _guardarEnStorage(); // Guardamos el cambio
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

  bool esSeleccionado(String categoria, String item) {
    return _seleccionados[categoria]?.contains(item) ?? false;
  }

  bool isCategoriaAllSelected(String categoria, Iterable<String> items) {
    return items.isNotEmpty && items.every((i) => _seleccionados[categoria]?.contains(i) ?? false);
  }

  Map<String, Set<String>> obtenerSeleccionados() => _seleccionados;

  List<String> getAllSelectedIngredients() {
    final all = <String>{};
    _seleccionados.forEach((categoria, set) {
      if (set.isNotEmpty) {
        all.add(categoria);
        all.addAll(set);
      }
    });
    try {
      final normalizer = (String s) => s
          .toLowerCase()
          .replaceAll(RegExp(r'[\n\t\\/,_\-()\[\].:]'), ' ')
          .replaceAll(RegExp(r'\d+([\.,]\d+)?'), '')
          .replaceAll(RegExp(r'[^a-z\s]'), '')
          .replaceAll(RegExp(r'\s+'), ' ')
          .trim();
      return all.map((e) => normalizer(e)).where((e) => e.isNotEmpty).toList();
    } catch (_) {
      return all.toList();
    }
  }
}