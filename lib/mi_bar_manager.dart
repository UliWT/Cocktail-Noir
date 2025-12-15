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

  // Selecciona todos los items de una categoría o los deselecciona si ya estaban todos seleccionados
  void toggleSeleccionCategoria(String categoria, Iterable<String> items) {
    final set = _seleccionados.putIfAbsent(categoria, () => <String>{});
    final allSelected = items.every((i) => set.contains(i));
    if (allSelected) {
      // deseleccionar todos
      for (var i in items) set.remove(i);
    } else {
      // seleccionar todos
      for (var i in items) set.add(i);
    }
  }

  bool isCategoriaAllSelected(String categoria, Iterable<String> items) {
    return items.isNotEmpty && items.every((i) => _seleccionados[categoria]?.contains(i) ?? false);
  }

  Map<String, Set<String>> obtenerSeleccionados() => _seleccionados;

  // Método para obtener todos los ingredientes seleccionados como lista plana.
  // Si una categoría tiene elementos seleccionados, también se incluye el nombre
  // de la categoría (por ejemplo, seleccionar tipos de Ron también aporta "Ron").
  List<String> getAllSelectedIngredients() {
    final all = <String>{};
    _seleccionados.forEach((categoria, set) {
      if (set.isNotEmpty) {
        all.add(categoria);
        all.addAll(set);
      }
    });
    return all.toList();
  }
}
