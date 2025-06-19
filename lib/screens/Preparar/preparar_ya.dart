import 'package:flutter/material.dart';
import 'package:myapp/widgets/main_scaffold.dart';
import 'package:myapp/widgets/textField.dart';
import 'package:myapp/widgets/tarjeta.dart';
import 'package:myapp/favoritos_manager.dart';

class PrepararYaScreen extends StatefulWidget {
  const PrepararYaScreen({super.key});

  @override
  State<PrepararYaScreen> createState() => _PrepararYaScreenState();
}

class _PrepararYaScreenState extends State<PrepararYaScreen> {
  final TextEditingController _controller = TextEditingController();
  String _busqueda = '';

final List<Map<String, dynamic>> tragos = [
  {
    'nombre': 'Espresso Martini',
    'descripcion': 'Intenso y sofisticado. Ideal para cerrar la noche con energía y estilo.',
    'ingredientes': 'Shot de espresso\nVodka 45 ml\nKhalua 30 ml\nAlmíbar 10 ml',
    'preparacion': '1. Mezclar todos los ingredientes en una coctelera con hielo\n2. Agitar enérgicamente durante 20 segundos\n3. Servir en una copa de martini previamente enfriada',
    'decoracion': 'Granos de café',
    'tags': ['Vodka', 'Sedoso', 'Dulce', 'Amargo'],
  },
  {
    'nombre': 'Mojito',
    'descripcion': 'Refrescante y cítrico, el clásico cubano para días calurosos.',
    'ingredientes': 'Ron blanco 50 ml\nHierbabuena\nAzúcar\nLima\nSoda',
    'preparacion': '1. Machacar la hierbabuena con azúcar y lima\n2. Agregar ron y hielo\n3. Completar con soda y mezclar suavemente',
    'decoracion': 'Hojas de hierbabuena',
    'tags': ['Ron', 'Refrescante', 'Cítrico', 'Herbal'],
  },
  {
    'nombre':'Negroni',
    'descripcion':'Elegante y robusto.La sofisticación italiana en su expresión más pura y contundente.',
    'ingredientes':'Campari 30 ml\nVermouth Rosso 30 ml\n Gin 30 ml',
    'preparacion':'1. En un vaso mezclador lleno de hielo poner todos los ingredientes\n 2. Revolver con una cuchara durante unos 20 segundos\n 3. Servir en un vaso rocks previamente enfriado',
    'decoracion':'Cascara de naranja',
    'tags':['Campari', 'Amargo', 'Clasico'],
  },
  {
    'nombre': 'Piña Colada',
    'descripcion': 'Dulce y cremoso, un clásico tropical para relajarse.',
    'ingredientes': 'Ron blanco 50 ml\nCrema de coco 30 ml\nJugo de piña 90 ml',
    'preparacion': '1. Licuar todos los ingredientes con hielo\n2. Servir en vaso alto\n3. Decorar con trozo de piña',
    'decoracion': 'Trozo de piña y cereza',
    'tags': ['Ron', 'Tropical', 'Cremoso'],
  },
  {
    'nombre': 'Margarita',
    'descripcion': 'Cítrico y refrescante, el rey de los cócteles mexicanos.',
    'ingredientes': 'Tequila 50 ml\nTriple sec 20 ml\nJugo de lima 30 ml\nSal para el borde',
    'preparacion': '1. Escarchar el borde del vaso con sal y limón\n2. Mezclar todos los ingredientes en una coctelera con hielo\n3. Servir en vaso de margarita escarchado',
    'decoracion': 'Rodaja de lima',
    'tags': ['Tequila', 'Fresco', 'Salado'],
  },
  {
    'nombre': 'Old Fashioned',
    'descripcion': 'Clásico y robusto, para quienes disfrutan del whisky puro.',
    'ingredientes': 'Whisky bourbon 60 ml\nAzúcar\nAngostura\nHielo',
    'preparacion': '1. Disolver azúcar con angostura en el vaso\n2. Agregar hielo y whisky\n3. Revolver suavemente',
    'decoracion': 'Cáscara de naranja',
    'tags': ['Whisky', 'Amargo', 'Robusto'],
  },
  {
    'nombre': 'Cosmopolitan',
    'descripcion': 'Elegante y afrutado, favorito en las noches urbanas.',
    'ingredientes': 'Vodka 45 ml\nTriple sec 15 ml\nJugo de arándano 30 ml\nJugo de lima 15 ml',
    'preparacion': '1. Mezclar todos los ingredientes en una coctelera con hielo\n2. Colar en copa de cóctel enfriada\n3. Decorar con twist de lima',
    'decoracion': 'Twist de lima',
    'tags': ['Vodka', 'Cítrico', 'Dulce'],
  },
  {
    'nombre': 'Daiquiri',
    'descripcion': 'Fresco y simple, un clásico cubano que nunca falla.',
    'ingredientes': 'Ron blanco 50 ml\nJugo de lima 25 ml\nAzúcar 2 cucharaditas',
    'preparacion': '1. Agitar todos los ingredientes con hielo\n2. Colar en copa de cóctel\n3. Decorar con rodaja de lima',
    'decoracion': 'Rodaja de lima',
    'tags': ['Ron', 'Fresco', 'Dulce'],
  },
  {
    'nombre': 'Caipirinha',
    'descripcion': 'El trago nacional de Brasil, cítrico y dulce.',
    'ingredientes': 'Cachaça 50 ml\nLima\nAzúcar',
    'preparacion': '1. Machacar la lima con azúcar\n2. Agregar cachaça y hielo\n3. Revolver bien',
    'decoracion': 'Trozo de lima',
    'tags': ['Cachaça', 'Dulce', 'Refrescante'],
  },
  {
    'nombre': 'French 75',
    'descripcion': 'Burbujeante y elegante, ideal para celebraciones.',
    'ingredientes': 'Gin 30 ml\nChampagne 60 ml\nJugo de limón 15 ml\nAzúcar 1 cucharadita',
    'preparacion': '1. Agitar gin, limón y azúcar con hielo\n2. Colar en copa flauta\n3. Completar con champagne',
    'decoracion': 'Twist de limón',
    'tags': ['Gin', 'Cítrico', 'Elegante'],
  },
  {
    'nombre': 'Whisky Sour',
    'descripcion': 'Equilibrado y refrescante. El equilibrio magistral entre tradición y frescura cítrica.',
    'ingredientes':'Whisky 60 ml\nAlmíbar 20ml\nJugo de limón 30 ml\n1 Clara de huevo',
    'preparacion':'1. Mezclar todos los ingredientes en una coctelera sin hielo\n2. Agitar en seco durante 20 segundos\n3.Agregar hielo a la coctelera y agitar durante 10 segundos\n4.Servir en una copa coupe previamente enfriada',
    'decoracion': 'Gotas de Bitter de Angostura',
    'tags': ['Whisky', 'Cítrico', 'Clasico'],
  },
  {
    'nombre': 'Manhattan',
    'descripcion': 'Elegante y fuerte, un clásico neoyorquino.',
    'ingredientes': 'Whisky rye 50 ml\nVermouth rojo 20 ml\nAngostura',
    'preparacion': '1. Revolver ingredientes con hielo\n2. Colar en copa de cóctel\n3. Decorar con cereza',
    'decoracion': 'Cereza',
    'tags': ['Whisky', 'Dulce', 'Elegante'],
  },
  {
    'nombre': 'Gin Tonic',
    'descripcion': 'Simple, refrescante y perfecto para cualquier ocasión.',
    'ingredientes': 'Gin 50 ml\nTónica\nRodaja de lima o pepino',
    'preparacion': '1. Llenar vaso con hielo\n2. Agregar gin\n3. Completar con tónica y decorar',
    'decoracion': 'Rodaja de lima o pepino',
    'tags': ['Gin', 'Simple', 'Cítrico'],
  },
  {
    'nombre': 'Bloody Mary',
    'descripcion': 'Salado y picante, ideal para brunchs.',
    'ingredientes': 'Vodka 50 ml\nJugo de tomate\nSalsa Worcestershire\nSalsa Tabasco\nSal y pimienta',
    'preparacion': '1. En un vaso mezclador lleno de hielo poner todos los ingredientes\n2. Revolver bien\n3. Decorar con apio',
    'decoracion': 'Apio',
    'tags': ['Vodka', 'Picante', 'Refrescante'],
  },
  {
    'nombre': 'Sex on the Beach',
    'descripcion': 'Dulce y frutal, clásico de verano.',
    'ingredientes': 'Vodka 40 ml\nLicor de durazno 20 ml\nJugo de naranja 40 ml\nJugo de arándano 40 ml',
    'preparacion': '1. Mezclar todos los ingredientes en una coctelera con hielo\n2. Colar en vaso alto\n3. Decorar con rodaja de naranja',
    'decoracion': 'Rodaja de naranja',
    'tags': ['Vodka', 'Frutal', 'Fresco'],
  },
];

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
    final tragosFiltrados = tragos.where((trago) {
      return trago['nombre'].toLowerCase().contains(_busqueda.toLowerCase());
    }).toList();

    return MainScaffold(
      selectedIndex: -1,
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
                            titulo: tragoActual['nombre'],
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
