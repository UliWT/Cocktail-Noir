import 'package:flutter/material.dart';
import 'package:myapp/widgets/main_scaffold.dart';
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
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.7,
        minChildSize: 0.4,
        maxChildSize: 0.95,
        builder: (context, scrollController) {
          return Container(
            decoration: BoxDecoration(
              color: const Color(0xFF1A1A1A),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
              border: Border.all(color: const Color(0xFFD4AF37), width: 2),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black87,
                  blurRadius: 10,
                  offset: Offset(0, -2),
                ),
              ],
            ),
            child: SingleChildScrollView(
              controller: scrollController,
              padding: const EdgeInsets.all(20),
              child: Tarjeta(
                nombre: trago['nombre'],
                descripcion: trago['descripcion'],
                ingredientes: trago['ingredientes'],
                preparacion: trago['preparacion'],
                decoracion: trago['decoracion'],
                tags: List<String>.from(trago['tags'] ?? []),
                width: double.infinity,
                padding: const EdgeInsets.all(20),
              ),
            ),
          );
        },
      ),
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
