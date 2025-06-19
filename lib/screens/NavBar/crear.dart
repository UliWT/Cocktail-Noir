import 'package:flutter/material.dart';
import 'package:myapp/widgets/main_scaffold.dart';
import 'package:myapp/widgets/boton.dart';

class CrearScreen extends StatefulWidget {
  const CrearScreen({Key? key}) : super(key: key);

  @override
  State<CrearScreen> createState() => _CrearScreenState();
}

class _CrearScreenState extends State<CrearScreen> {
  // Índice de la sección activa: 0=Información, 1=Ingredientes, 2=Preparación, 3=Vista previa
  int _seccionActiva = 0;

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      selectedIndex: 2, // Asumiendo que es el índice de Crear en el menú
      backgroundColor: const Color(0xFF1A1A1A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1A1A),
        title: const Text('Crear', style: TextStyle(color: Color(0xFFFFD829))),
        iconTheme: const IconThemeData(color: Color(0xFFFFD829)),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Botones para seleccionar sección
SizedBox(
  height: 100, // Altura justa para una fila de botones
  child: GridView.count(
    crossAxisCount: 4, // 4 columnas = 1 fila
    childAspectRatio: 2.6, // Ancho más largo que alto
    mainAxisSpacing: 10,
    crossAxisSpacing: 10,
    physics: const NeverScrollableScrollPhysics(),
    children: [
      Boton(
        texto: 'Información',
        style: const TextStyle(fontSize: 13),
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
        borderRadius: 5,
        seleccionado: _seccionActiva == 0,
        onPressed: () => setState(() => _seccionActiva = 0),
      ),
      Boton(
        texto: 'Ingredientes',
        style: const TextStyle(fontSize: 13),
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
        borderRadius: 5,
        seleccionado: _seccionActiva == 1,
        onPressed: () => setState(() => _seccionActiva = 1),
      ),
      Boton(
        texto: 'Preparación',
        style: const TextStyle(fontSize: 13),
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
        borderRadius: 5,
        seleccionado: _seccionActiva == 2,
        onPressed: () => setState(() => _seccionActiva = 2),
      ),
      Boton(
        texto: 'Vista previa',
        style: const TextStyle(fontSize: 13),
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
        borderRadius: 5,
        seleccionado: _seccionActiva == 3,
        onPressed: () => setState(() => _seccionActiva = 3),
      ),
    ],
  ),
),


            const SizedBox(height: 20),

            // Contenido según sección seleccionada
            Expanded(
              child: _construirSeccion(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _construirSeccion() {
    switch (_seccionActiva) {
      case 0:
        return _seccionInformacion();
      case 1:
        return Center(child: Text('Ingredientes - en construcción', style: TextStyle(color: Colors.white)));
      case 2:
        return Center(child: Text('Preparación - en construcción', style: TextStyle(color: Colors.white)));
      case 3:
        return Center(child: Text('Vista previa - en construcción', style: TextStyle(color: Colors.white)));
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _seccionInformacion() {
    return ListView(
      children: [
        TextField(
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            labelText: 'Nombre del trago',
            labelStyle: const TextStyle(color: Color(0xFFFFD829)),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Color(0xFFFFD829)),
              borderRadius: BorderRadius.circular(8),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Color(0xFFFFD829), width: 2),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          style: const TextStyle(color: Colors.white),
          maxLines: 3,
          decoration: InputDecoration(
            labelText: 'Descripción',
            labelStyle: const TextStyle(color: Color(0xFFFFD829)),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Color(0xFFFFD829)),
              borderRadius: BorderRadius.circular(8),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Color(0xFFFFD829), width: 2),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        // Acá podés agregar más campos si querés
      ],
    );
  }
}