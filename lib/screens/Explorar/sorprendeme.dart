import 'dart:math';
import 'package:myapp/favoritos_manager.dart';
import 'package:flutter/material.dart';
import 'package:myapp/widgets/main_scaffold.dart';
import 'package:myapp/widgets/tarjeta.dart';
import 'package:myapp/widgets/boton.dart'; 

class SorprendemeScreen extends StatefulWidget {
  const SorprendemeScreen({super.key});

  @override
  State<SorprendemeScreen> createState() => _SorprendemeScreenState();
}

class _SorprendemeScreenState extends State<SorprendemeScreen> {
  final List<Map<String, dynamic>> tragos = [
    {
      'nombre': 'Espresso Martini',
      'descripcion': 'Intenso y sofisticado. Ideal para cerrar la noche con energía y estilo.',
      'ingredientes':'Shot de espresso\nVodka 45 ml\nKhalua 30 ml\nAlmibar 10 ml',
      'preparacion':'1. Mezclar todos los ingredientes en una coctelera con hielo\n2. Agitar energicamente durante 20 segundos\n3. Servir en una copa de martini previamente enfriada',
      'decoracion': 'Granos de café',
      'tags': ['Café', 'Sedoso', 'Dulce', 'Amargo'],
    },
    {
      'nombre': 'Baileys Chocolatini',
      'descripcion': 'Cremoso y seductor. El encuentro perfecto entre cremosidad irlandesa y tentación del chocolate.',
      'ingredientes':'Baileys 30 ml\nLicor de Chocolate 30ml\nKhalua 30 ml',
      'preparacion':'1. Mezclar todos los ingredientes en una coctelera con hielo\n2. Agitar energicamente durante 20 segundos\n3. Servir en una copa de martini previamente enfriada',
      'decoracion': 'Ralladura de Chocolate',
      'tags': ['Baileys', 'Cremoso', 'Sedoso'],
    },
        {
      'nombre': 'Whisky Sour',
      'descripcion': 'Equilibrado y refrescante. El equilibrio magistral entre tradición y frescura cítrica.',
      'ingredientes':'Whisky 60 ml\nAlmibar 20ml\nJugo de limón 30 ml\n1 Clara de huevo',
      'preparacion':'1. Mezclar todos los ingredientes en una coctelera sin hielo\n2. Agitar en seco durante 20 segundos\n3.Agregar hielo a la coctelera y agitar durante 10 segundos\n4.Servir en una copa coupe previamente enfriada',
      'decoracion': 'Gotas de Bitter de Angostura',
      'tags': ['Whisky', 'Cítrico', 'Clasico'],
    },
    {
      'nombre':'Daiquiri de Durazno',
      'descripcion':'Refrescante y frutal. El sabor del verano capturado en un equilibrio perfecto.',
      'ingredientes':'Duraznos al almibar\nRon blanco 20%\njugo de limón 10%',
      'preparacion':'1. Poner todos los ingredientes en una licuadora\n2. Licuar por 40 segundos\n3. Pasar a recipiente con hielo y revolver',
      'tags':['Ron', 'Frutal', 'Tropical'],
    },
    {
      'nombre':'Negroni',
      'descripcion':'Elegante y robusto.La sofisticación italiana en su expresión más pura y contundente.',
      'ingredientes':'Campari 30 ml\nVermouth Rosso 30 ml\n Gin 30 ml',
      'preparacion':'1. En un vaso mezclador lleno de hielo poner todos los ingredientes\n 2. Revolver con una cuchara durante unos 20 segundos\n 3. Servir en un vaso rocks previamente enfriado',
      'decoracion':'Cascara de naranja',
      'tags':['Campari', 'Amargo', 'Clasico'],
    }
  ];

  late Map<String, dynamic> tragoActual;

  final _random = Random();

  @override
  void initState() {
    super.initState();
    tragoActual = tragos[_random.nextInt(tragos.length)];
  }

  void _refrescarTrago() {
    setState(() {
      // Elegir otro trago aleatorio distinto al actual
      Map<String, dynamic> nuevoTrago;
      do {
        nuevoTrago = tragos[_random.nextInt(tragos.length)];
      } while (nuevoTrago == tragoActual);
      tragoActual = nuevoTrago;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      selectedIndex: 0,
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1A1A),
        elevation: 0,
        title: const Text('Sorprendeme'),
      ),
      backgroundColor: const Color(0xFF1A1A1A),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
              Tarjeta(
                titulo: tragoActual['nombre'],
                descripcion: tragoActual['descripcion'],
                ingredientes: tragoActual['ingredientes'],
                preparacion: tragoActual['preparacion'],
                decoracion: tragoActual['decoracion'],
                tags: List<String>.from(tragoActual['tags']),
                width: double.infinity,
                trago: tragoActual,
                onToggleFavorito: () {
                  setState(() {
                    FavoritosManager().toggleFavorito(tragoActual);
                  });
                },
              ),
            const SizedBox(height: 24),
            Boton(
              texto: '¡Otra Sorpresa!',
              onPressed: _refrescarTrago,
              padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 14),
              borderRadius: 8,
              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
