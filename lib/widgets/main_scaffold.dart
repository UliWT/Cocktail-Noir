import 'package:flutter/material.dart';
import 'package:myapp/widgets/nav_bar.dart';

class MainScaffold extends StatelessWidget {
  final int selectedIndex;
  final PreferredSizeWidget? appBar;
  final Widget body;
  final Color? backgroundColor;

  const MainScaffold({
    Key? key,
    required this.selectedIndex,
    this.appBar,
    required this.body,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      backgroundColor: backgroundColor ?? const Color(0xFF1A1A1A),
      body: body,
      bottomNavigationBar: BottomNavBar(
        selectedIndex: selectedIndex,
        onItemSelected: (index) {
          // Navegación según el índice
          switch (index) {
            case 0:
              Navigator.pushReplacementNamed(context, '/ajustes');
              break;
            case 1:
              Navigator.pushReplacementNamed(context, '/crear');
              break;
            case 2:
              Navigator.pushReplacementNamed(context, '/mi_bar');
              break;
            case 3:
              Navigator.pushReplacementNamed(context, '/favoritos');
              break;
          }
        },
      ),
    );
  }
}
