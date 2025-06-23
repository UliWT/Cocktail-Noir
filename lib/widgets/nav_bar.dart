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
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        height: 3,
        color: const Color(0xFFD4AF37),
      ),

      Theme(
        data: Theme.of(context).copyWith(
          canvasColor: const Color(0xFF1A1A1A),
        ),
        child: BottomNavigationBar(
          currentIndex: selectedIndex >= 0 && selectedIndex <= 4 ? selectedIndex : 0,
          onTap: onItemSelected,
          backgroundColor: const Color(0xFF1A1A1A),
          selectedItemColor: const Color(0xFFFFD829),
          unselectedItemColor: Colors.grey,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Ajustes'),
            BottomNavigationBarItem(icon: Icon(Icons.add_box), label: 'Crear'),
            BottomNavigationBarItem(icon: Icon(Icons.local_bar), label: 'Mi Bar'),
            BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favoritos'),
          ],
        ),
      ),
    ],
  );
}

}
