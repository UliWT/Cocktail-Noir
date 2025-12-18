import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritosManager {
  static final FavoritosManager _instancia = FavoritosManager._internal();
  factory FavoritosManager() => _instancia;
  FavoritosManager._internal();

  final List<Map<String, dynamic>> _favoritos = [];
  List<Map<String, dynamic>> get favoritos => List.unmodifiable(_favoritos);

  // Carga los datos guardados en el teléfono
  Future<void> cargarFavoritos() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? favoritosString = prefs.getString('lista_favoritos');
      
      if (favoritosString != null) {
        final List<dynamic> decoded = jsonDecode(favoritosString);
        _favoritos.clear();
        _favoritos.addAll(decoded.map((item) => Map<String, dynamic>.from(item)));
      }
    } catch (e) {
      print("Error cargando favoritos: $e");
    }
  }

  // Guarda la lista actual en el teléfono
  Future<void> _guardarEnStorage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String encoded = jsonEncode(_favoritos);
      await prefs.setString('lista_favoritos', encoded);
    } catch (e) {
      print("Error guardando favoritos: $e");
    }
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

    await _guardarEnStorage();
  }
}