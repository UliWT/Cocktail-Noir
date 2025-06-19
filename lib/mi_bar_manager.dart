class MiBarManager {
  static final MiBarManager _instancia = MiBarManager._interno();
  final Map<String, Set<String>> _seleccionados = {};

  factory MiBarManager() => _instancia;

  MiBarManager._interno();

  /// Inicializa las categorías vacías si no existen
  void inicializarCategorias(Iterable<String> categorias) {
    for (var cat in categorias) {
      _seleccionados.putIfAbsent(cat, () => <String>{});
    }
  }

  /// Alterna el estado de selección
  void toggleSeleccion(String categoria, String item) {
    final set = _seleccionados.putIfAbsent(categoria, () => <String>{});
    if (set.contains(item)) {
      set.remove(item);
    } else {
      set.add(item);
    }
  }

  /// Devuelve si un ítem está seleccionado
  bool esSeleccionado(String categoria, String item) {
    return _seleccionados[categoria]?.contains(item) ?? false;
  }

  /// Devuelve el mapa completo
  Map<String, Set<String>> obtenerSeleccionados() => _seleccionados;
}
