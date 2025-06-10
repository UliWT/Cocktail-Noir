import 'package:flutter/material.dart';
import 'package:myapp/screens/home.dart';
import 'package:myapp/screens/Explorar/explorar.dart';
import 'package:myapp/screens/Preparar/preparar_ya.dart';
import 'package:myapp/screens/NavBar/ajustes.dart';
import 'package:myapp/screens/NavBar/crear.dart';
import 'package:myapp/screens/NavBar/favoritos.dart';
import 'package:myapp/screens/NavBar/mi_bar.dart';
import 'package:myapp/widgets/nav_bar.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({Key? key}) : super(key: key);

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const PrepararYaScreen(),
    const ExplorarScreen(),
    const AjustesScreen(),
    const CrearScreen(),
    const MiBarScreen(),
    const FavoritosScreen(),
  ];

  void _onItemSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Aquí el body cambia según la pantalla seleccionada
      body: _screens[_selectedIndex],

      // Barra de navegación abajo
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onItemSelected: _onItemSelected,
      ),
    );
  }
}
