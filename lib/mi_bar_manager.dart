class MiBarManager {
  static final MiBarManager _instancia = MiBarManager._interno();
  final Map<String, Set<String>> _seleccionados = {};

  factory MiBarManager() => _instancia;

  MiBarManager._interno();

  void inicializarCategorias(Iterable<String> categorias) {
    for (var cat in categorias) {
      _seleccionados.putIfAbsent(cat, () => <String>{});
    }
  }

  void toggleSeleccion(String categoria, String item) {
    final set = _seleccionados.putIfAbsent(categoria, () => <String>{});
    if (set.contains(item)) {
      set.remove(item);
    } else {
      set.add(item);
    }
  }

  bool esSeleccionado(String categoria, String item) {
    return _seleccionados[categoria]?.contains(item) ?? false;
  }

  Map<String, Set<String>> obtenerSeleccionados() => _seleccionados;

  // Método para obtener todos los ingredientes seleccionados como lista plana
  List<String> getAllSelectedIngredients() {
    final all = <String>{};
    for (var set in _seleccionados.values) {
      all.addAll(set);
    }
    return all.toList();
  }
}
