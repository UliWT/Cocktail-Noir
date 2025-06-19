import 'package:flutter/material.dart';
import 'package:myapp/widgets/main_scaffold.dart';
import 'package:myapp/widgets/tarjeta.dart';
import 'package:myapp/favoritos_manager.dart';

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
