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
  'Licor': ['Triple Sec', 'Amaretto', 'Baileys', 'Kahlúa', 'Chocolate'],
  'Aperitivo': ['Campari', 'Aperol', 'Fernet'],
  'Brandy': ['Cognac', 'Armagnac'],
  'Bitters': ['Angostura', 'Chocolate'],
  'Gaseosas': ['Coca Cola', 'Sprite', 'Fanta'],
  'Frutas': ['Frutilla', 'Durazno', 'Manzana', 'Pera', 'Cereza', 'Frambuesa'],
};


  final Set<String> desplegados = {};

  @override
  void initState() {
    super.initState();
    MiBarManager().inicializarCategorias(categorias.keys);
  }

  void toggleSeleccion(String categoria, String item) {
    setState(() {
      MiBarManager().toggleSeleccion(categoria, item);
    });
  }

  void toggleDesplegado(String categoria, bool expanded) {
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
              onExpansionChanged: (val) => toggleDesplegado(categoria, val),
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
              trailing: const SizedBox.shrink(),
              children: [
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: items.map((item) {
                    final seleccionado = MiBarManager().esSeleccionado(categoria, item);
                    return Boton(
                      texto: item,
                      seleccionado: seleccionado,
                      onPressed: () => toggleSeleccion(categoria, item),
                      style: const TextStyle(fontSize: 14),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      borderRadius: 20,
                      key: ValueKey('$categoria-$item-$seleccionado'),
                    );
                  }).toList(),
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
