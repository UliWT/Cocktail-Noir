import 'package:flutter/material.dart';
import 'package:myapp/widgets/main_scaffold.dart';
import 'package:myapp/widgets/modalSheet.dart';
import 'package:myapp/widgets/tarjeta.dart';
import 'package:myapp/widgets/textField.dart';
import 'package:myapp/favoritos_manager.dart';

class FavoritosScreen extends StatefulWidget {
  const FavoritosScreen({super.key});

  @override
  State<FavoritosScreen> createState() => _FavoritosScreenState();
}

class _FavoritosScreenState extends State<FavoritosScreen> {
  final TextEditingController _controller = TextEditingController();
  String _busqueda = '';

  void _realizarBusqueda() {
    setState(() {
      _busqueda = _controller.text;
    });
  }

  void _mostrarDetalleTrago(BuildContext context, Map<String, dynamic> trago) {
    mostrarDetalleTrago(
      context,
      trago,
      onFavoritoChanged: () => setState(() {}),
    );
  }
  @override
  Widget build(BuildContext context) {
    final favoritos = FavoritosManager().favoritos;

    final favoritosFiltrados = favoritos.where((f) {
      return f['nombre']
          .toString()
          .toLowerCase()
          .contains(_busqueda.toLowerCase());
    }).toList();

    return MainScaffold(
      selectedIndex: 4,
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1A1A),
        elevation: 0,
      ),
      backgroundColor: const Color(0xFF1A1A1A),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Favoritos',
              style: TextStyle(
                fontSize: 24,
                color: Color(0xFFFFD829),
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            BarraBusqueda(
              controller: _controller,
              onBuscar: _realizarBusqueda,
              paddingVertical: 10,
              paddingHorizontal: 20,
              paddingIcon: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: favoritosFiltrados.isEmpty
                  ? const Center(
                      child: Text(
                        'No se encontraron tragos.',
                        style: TextStyle(color: Colors.white70),
                      ),
                    )
                  : ListView.builder(
                      itemCount: favoritosFiltrados.length,
                      itemBuilder: (context, index) {
                        final trago = favoritosFiltrados[index];
                        return GestureDetector(
                          onTap: () => _mostrarDetalleTrago(context, trago),
                          child: Tarjeta(
                            nombre: trago['nombre'],
                            descripcion: trago['descripcion'],
                            tags: List<String>.from(trago['tags']),
                            width: double.infinity,
                            trago: trago,
                            onToggleFavorito: () {
                              setState(() {
                                FavoritosManager().toggleFavorito(trago);
                              });
                            },
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
