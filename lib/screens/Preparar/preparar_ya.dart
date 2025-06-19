import 'package:flutter/material.dart';
import 'package:myapp/widgets/main_scaffold.dart';
import 'package:myapp/widgets/textField.dart';
import 'package:myapp/widgets/tarjeta.dart';
import 'package:myapp/favoritos_manager.dart';
import 'package:myapp/data/tragos.dart' as data;
import 'package:myapp/widgets/modalSheet.dart';  // Importamos el modalSheet

class PrepararYaScreen extends StatefulWidget {
  const PrepararYaScreen({super.key});

  @override
  State<PrepararYaScreen> createState() => _PrepararYaScreenState();
}

class _PrepararYaScreenState extends State<PrepararYaScreen> {
  final TextEditingController _controller = TextEditingController();
  String _busqueda = '';

  void _realizarBusqueda() {
    setState(() {
      _busqueda = _controller.text;
    });
  }

  void _mostrarDetalle(BuildContext context, Map<String, dynamic> trago) {
    mostrarDetalleTrago(
      context,
      trago,
      onFavoritoChanged: () {
        setState(() {}); // Solo refrescamos la pantalla para actualizar la estrella fuera del modal
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final tragosFiltrados = data.tragos.where((trago) {
      return trago['nombre'].toLowerCase().contains(_busqueda.toLowerCase());
    }).toList();

    return MainScaffold(
      selectedIndex: 0,
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1A1A),
        elevation: 0,
        title: const Text('Preparar Ya'),
      ),
      backgroundColor: const Color(0xFF1A1A1A),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            BarraBusqueda(
              controller: _controller,
              onBuscar: _realizarBusqueda,
              paddingVertical: 10,
              paddingHorizontal: 20,
              paddingIcon: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: tragosFiltrados.isEmpty
                  ? const Center(
                      child: Text(
                        'No se encontraron tragos.',
                        style: TextStyle(color: Colors.white70),
                      ),
                    )
                  : ListView.builder(
                      itemCount: tragosFiltrados.length,
                      itemBuilder: (context, index) {
                        final tragoActual = tragosFiltrados[index];
                        return GestureDetector(
                          onTap: () => _mostrarDetalle(context, tragoActual),
                          child: Tarjeta(
                            nombre: tragoActual['nombre'],
                            descripcion: tragoActual['descripcion'],
                            tags: List<String>.from(tragoActual['tags']),
                            width: double.infinity,
                            trago: tragoActual,
                            onToggleFavorito: () {
                              setState(() {
                                FavoritosManager().toggleFavorito(tragoActual);
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
