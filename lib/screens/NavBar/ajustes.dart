import 'package:flutter/material.dart';
import 'package:myapp/widgets/boton.dart';
import 'package:myapp/widgets/main_scaffold.dart';

class AjustesScreen extends StatefulWidget {
  const AjustesScreen({Key? key}) : super(key: key);

  @override
  State<AjustesScreen> createState() => _AjustesScreenState();
}

class _AjustesScreenState extends State<AjustesScreen> {
  bool ignorarDecoracion = true;
  bool habilitarNube = false;
  bool mostrarNotificaciones = true;
  bool modoEvento = false;

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      selectedIndex: 1, // ajustá según la posición en tu BottomNavBar
      backgroundColor: const Color(0xFF1A1A1A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1A1A),
        title: const Text('Ajustes', style: TextStyle(color: Color(0xFFFFD829))),
        iconTheme: const IconThemeData(color: Color(0xFFFFD829)),
        elevation: 0,
      ),
      body: ListView(
  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
  children: [
    _buildCheckboxTile(
      'Ignorar decoración',
      ignorarDecoracion,
      (val) => setState(() => ignorarDecoracion = val ?? false),
    ),
    const Divider(color: Color(0xFFFFD829)),
    _buildCheckboxTile(
      'Habilitar almacenamiento en la nube',
      habilitarNube,
      (val) => setState(() => habilitarNube = val ?? false),
    ),
    const Divider(color: Color(0xFFFFD829)),
    _buildCheckboxTile(
      'Mostrar notificaciones',
      mostrarNotificaciones,
      (val) => setState(() => mostrarNotificaciones = val ?? false),
    ),
    const Divider(color: Color(0xFFFFD829)),
    _buildCheckboxTile(
      'Modo evento',
      modoEvento,
      (val) => setState(() => modoEvento = val ?? false),
    ),
    const Divider(color: Color(0xFFFFD829)),
    Boton(
      texto: 'Sincronizar con otro dispositivo',
      onPressed: () {
        
      },
      padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 30),
      borderRadius: 12,
    ),
    const Divider(color: Color(0xFFFFD829)),
    Boton(
      texto: 'Borrar datos/Preferencias',
      onPressed: () {
        
      },
      padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 30),
      borderRadius: 12,
    ),
    const Divider(color: Color(0xFFFFD829)),
    Boton(
      texto: 'Cerrar sesión',
      onPressed: () {

      },
            padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 30),
      borderRadius: 12,
    ),
  ],
),

    );
  }

  Widget _buildCheckboxTile(String text, bool value, ValueChanged<bool?> onChanged) {
    return CheckboxListTile(
      title: Text(
        text,
        style: const TextStyle(color: Colors.white),
      ),
      value: value,
      onChanged: onChanged,
      checkColor: Colors.black,
      activeColor: const Color(0xFFFFD829),
      controlAffinity: ListTileControlAffinity.leading,
      contentPadding: EdgeInsets.zero,
    );
  }

  // ignore: unused_element
  Widget _buildButton(String text, VoidCallback onPressed) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          side: const BorderSide(color: Color(0xFFFFD829)),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: const EdgeInsets.symmetric(vertical: 14),
          elevation: 0,
        ),
        child: Text(
          text,
          style: const TextStyle(color: Color(0xFFFFD829), fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
