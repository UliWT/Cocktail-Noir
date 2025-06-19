import 'package:flutter/material.dart';
import 'package:myapp/widgets/main_scaffold.dart';
import 'package:myapp/widgets/textField.dart';
import 'package:myapp/widgets/tarjeta.dart';
import 'package:myapp/favoritos_manager.dart';
import 'package:myapp/data/tragos.dart' as data;

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
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF2C2C2C),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  trago['nombre'],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 26,
                    color: Color(0xFFFFD829),
                  ),
                ),
                const SizedBox(height: 10),
                if (trago['descripcion'] != null && trago['descripcion'].trim().isNotEmpty)
                  Text(
                    trago['descripcion'],
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                const SizedBox(height: 16),
                if (trago['ingredientes'] != null && trago['ingredientes'].trim().isNotEmpty)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Ingredientes',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        trago['ingredientes'],
                        style: const TextStyle(color: Colors.white),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                if (trago['preparacion'] != null && trago['preparacion'].trim().isNotEmpty)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Preparación',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        trago['preparacion'],
                        style: const TextStyle(color: Colors.white),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                if (trago['decoracion'] != null && trago['decoracion'].trim().isNotEmpty)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Decoración',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        trago['decoracion'],
                        style: const TextStyle(
                          fontStyle: FontStyle.italic,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton.icon(
                    icon: Icon(
                      FavoritosManager().esFavorito(trago['nombre'])
                          ? Icons.star
                          : Icons.star_border,
                      color: const Color(0xFFFFD829),
                    ),
                    label: const Text('Favorito'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1A1A1A),
                    ),
                    onPressed: () {
                      setState(() {
                        FavoritosManager().toggleFavorito(trago);
                      });
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
            ),
          ),
        );
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
