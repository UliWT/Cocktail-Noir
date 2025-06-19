// favoritos_manager.dart
class FavoritosManager {
  static final FavoritosManager _instancia = FavoritosManager._internal();

  factory FavoritosManager() => _instancia;

  FavoritosManager._internal();

  final List<Map<String, dynamic>> _favoritos = [];

  List<Map<String, dynamic>> get favoritos => List.unmodifiable(_favoritos);

  // Ahora esta función no hace nada (era para cargar desde almacenamiento)
  Future<void> cargarFavoritos() async {
    // Ya no se cargan desde ningún lado
    _favoritos.clear();
  }

  // Esta función también queda vacía
  Future<void> _guardarEnStorage() async {
    // Ya no se guarda en ningún lado
  }

  bool esFavorito(String titulo) {
    return _favoritos.any((trago) => trago['nombre'] == titulo);
  }

  Future<void> toggleFavorito(Map<String, dynamic> trago) async {
    final index = _favoritos.indexWhere((t) => t['nombre'] == trago['nombre']);

    if (index == -1) {
      _favoritos.add(trago);
    } else {
      _favoritos.removeAt(index);
    }

    await _guardarEnStorage(); // esta línea sigue para mantener la firma
  }
}
