import 'package:flutter/material.dart';
import 'package:myapp/widgets/main_scaffold.dart';
import 'package:myapp/widgets/tarjeta.dart';
import 'package:myapp/favoritos_manager.dart';
import 'package:myapp/widgets/modalSheet.dart';

class NovedadesScreen extends StatefulWidget {
  const NovedadesScreen({super.key});

  @override
  State<NovedadesScreen> createState() => _NovedadesScreenState();
}

class _NovedadesScreenState extends State<NovedadesScreen> {
  final List<Map<String, dynamic>> novedades = [
    {
      'nombre': 'Smoked Paprika Bloody Mary',
      'descripcion': 'Picante y ahumado. La mañana que despierta con carácter y personalidad indomable.',
      'tags': ['Vodka', 'Salado', 'Picante'],
    },
    {
      'nombre': 'Blueberry Basil Gin Fizz',
      'descripcion': 'Fruta fresca con un toque verde y aromático. Una mezcla frutal y perfumada, perfecta para tardes livianas',
      'tags': ['Arandano', 'Refrescante', 'Herbaceo'],
    },
    {
      'nombre': 'Spicy Mocha Old Fashioned',
      'descripcion': 'Una combinación profunda con notas de cacao y café. Para quienes buscan algo oscuro, diferente y con carácter.',
      'tags': ['Whisky', 'Cremoso', 'Picante'],
    },
    {
      'nombre': 'Coconut Matcha Cooler',
      'descripcion': 'Delicado y fresco, con una base de té verde y un toque cremoso de coco. Un viaje sutil en cada sorbo.',
      'tags': ['Coco', 'Tropical', 'Innovador'],
    },
    {
      'nombre': 'Lavender Pear Fizz',
      'descripcion': 'Floral y delicado. Una caricia aromática que transporta a jardines en primavera.',
      'tags': ['Pisco', 'Frutal', 'Refrescante'],
    },
    {
      'nombre': 'Mango Habanero Margarita',
      'descripcion': 'Tropical con mordida. La dulzura exótica que sorprende con un final ardiente memorable.',
      'tags': ['Tequila', 'Picante', 'Innovador'],
    },
  ];

  void _mostrarDetalleTrago(BuildContext context, Map<String, dynamic> trago) {
    mostrarDetalleTrago(
      context,
      trago,
      onFavoritoChanged: () => setState(() {}),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      selectedIndex: 0,
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1A1A),
        elevation: 0,
        title: const Text('Novedades'),
      ),
      backgroundColor: const Color(0xFF1A1A1A),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView.builder(
          itemCount: novedades.length,
          itemBuilder: (context, index) {
            final novedad = novedades[index];
            return GestureDetector(
              onTap: () => _mostrarDetalleTrago(context, novedad),
              child: Tarjeta(
                nombre: novedad['nombre'],
                descripcion: novedad['descripcion'],
                tags: List<String>.from(novedad['tags']),
                width: double.infinity,
                trago: novedad,
                onToggleFavorito: () {
                  setState(() {
                    FavoritosManager().toggleFavorito(novedad);
                  });
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
