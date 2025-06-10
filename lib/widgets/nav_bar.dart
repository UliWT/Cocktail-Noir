import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemSelected;

  const BottomNavBar({
    Key? key,
    required this.selectedIndex,
    required this.onItemSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selectedIndex >= 0 && selectedIndex <= 3 ? selectedIndex : 0,
      onTap: onItemSelected,
      backgroundColor: const Color(0xFF1A1A1A),
      selectedItemColor: const Color(0xFFFFD829),
      unselectedItemColor: Colors.grey,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Ajustes'),
        BottomNavigationBarItem(icon: Icon(Icons.add_box), label: 'Crear'),
        BottomNavigationBarItem(icon: Icon(Icons.local_bar), label: 'Mi Bar'),
        BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favoritos'),
      ],
    );
  }
}
