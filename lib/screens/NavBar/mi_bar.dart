import 'package:flutter/material.dart';
import 'package:myapp/widgets/main_scaffold.dart';
import 'package:myapp/widgets/boton.dart';
import 'package:myapp/mi_bar_manager.dart';

class MiBarScreen extends StatefulWidget {
  const MiBarScreen({super.key});

  @override
  State<MiBarScreen> createState() => _MiBarScreenState();
}

class _MiBarScreenState extends State<MiBarScreen> {
  final Map<String, List<String>> categorias = {
    'Ron': ['Blanco', 'Dorado', 'Añejo', 'Overproof'],
    'Tequila': ['Blanco', 'Reposado', 'Añejo'],
    'Whisky': ['Scotch', 'Bourbon', 'Rye', 'Irlandés'],
    'Vodka': ['Clásico', 'Saborizado'],
    'Ginebra': ['London Dry', 'Old Tom', 'Pink Gin'],
    'Vermouth': ['Blanco', 'Rosso', 'Seco'],
    'Licor': ['Triple Sec', 'Amaretto', 'Baileys', 'Kahlúa', 'Chocolate', 'Cachaça'],
    'Aperitivo': ['Campari', 'Aperol', 'Fernet'],
    'Brandy': ['Cognac', 'Armagnac'],
    'Bitters': ['Angostura', 'Chocolate'],
    'Gaseosas': ['Coca Cola', 'Sprite', 'Fanta'],
    'Frutas': ['Frutilla', 'Durazno', 'Manzana', 'Pera', 'Cereza', 'Frambuesa', 'Lima', 'Limón',],
    'Ingredientes básicos': [
      'Jugo de lima',
      'Jugo de limón',
      'Rodaja de lima',
      'Azúcar',
      'Sal',
      'Almíbar',
      'Hielo',
      'Soda',
      'Agua',
      'Jarabe simple',
      'Espresso'
    ],
    'Otros':['Hierba buena', 'Albahaca', 'Menta']
  };

  final Set<String> desplegados = {};

  @override
  void initState() {
    super.initState();
    // Inicializamos las categorías en el Manager
    MiBarManager().inicializarCategorias(categorias.keys);
  }

  // --- CORRECCIÓN: Funciones asíncronas fuera del setState ---

  Future<void> _toggleSeleccion(String categoria, String item) async {
    await MiBarManager().toggleSeleccion(categoria, item);
    if (mounted) setState(() {});
  }

  Future<void> _toggleSeleccionCategoria(String categoria, List<String> items) async {
    await MiBarManager().toggleSeleccionCategoria(categoria, items);
    if (mounted) setState(() {});
  }

  void _toggleDesplegado(String categoria, bool expanded) {
    setState(() {
      if (expanded) {
        desplegados.add(categoria);
      } else {
        desplegados.remove(categoria);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final manager = MiBarManager();

    return MainScaffold(
      selectedIndex: 3,
      appBar: AppBar(title: const Text("Mi Bar")),
      backgroundColor: const Color(0xFF1A1A1A),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: categorias.entries.map((entry) {
          final categoria = entry.key;
          final items = entry.value;
          final expandido = desplegados.contains(categoria);
          final allSelected = manager.isCategoriaAllSelected(categoria, items);

          return Container(
            margin: const EdgeInsets.only(bottom: 25),
            decoration: BoxDecoration(
              color: expandido ? const Color(0xFF303030) : const Color(0xFFFFCD29),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: expandido ? const Color(0xFFD4AF37) : const Color(0xFFFFCD29),
                width: 2,
              ),
            ),
            child: ExpansionTile(
              onExpansionChanged: (val) => _toggleDesplegado(categoria, val),
              tilePadding: const EdgeInsets.symmetric(horizontal: 16),
              title: Center(
                child: Text(
                  categoria,
                  style: TextStyle(
                    color: expandido ? const Color(0xFFD4AF37) : const Color(0xFF4C4C4C),
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              trailing: IconButton(
                icon: Icon(
                  allSelected ? Icons.check_box : Icons.check_box_outline_blank,
                  color: allSelected ? const Color(0xFF4C4C4C) : const Color(0xFFD4AF37),
                ),
                onPressed: () => _toggleSeleccionCategoria(categoria, items),
                tooltip: 'Seleccionar/Deseleccionar todo',
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: items.map((item) {
                      final seleccionado = manager.esSeleccionado(categoria, item);
                      return Boton(
                        texto: item,
                        seleccionado: seleccionado,
                        onPressed: () => _toggleSeleccion(categoria, item),
                        style: const TextStyle(fontSize: 14),
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        borderRadius: 20,
                        key: ValueKey('$categoria-$item-$seleccionado'),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}