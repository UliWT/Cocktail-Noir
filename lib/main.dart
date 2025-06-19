import 'package:flutter/material.dart';
import 'package:myapp/screens/home.dart';
import 'package:myapp/screens/NavBar/ajustes.dart';
import 'package:myapp/screens/NavBar/crear.dart';
import 'package:myapp/screens/NavBar/favoritos.dart';
import 'package:myapp/screens/NavBar/mi_bar.dart';
import 'package:myapp/favoritos_manager.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Intentamos cargar favoritos (no async porque ya no hace nada)
    try {
      FavoritosManager().cargarFavoritos();
    } catch (e) {
      debugPrint('Error cargando favoritos: $e');
    }

    return MaterialApp(
      title: 'Cocktail Noir',
      debugShowCheckedModeBanner: false,
      initialRoute: '/home',
      routes: {
        '/home': (context) => const HomeScreen(),
        '/ajustes': (context) => const AjustesScreen(),
        '/crear': (context) => const CrearScreen(),
        '/mi_bar': (context) => const MiBarScreen(),
        '/favoritos': (context) => const FavoritosScreen(),
      },
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF1A1A1A),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1A1A1A),
          foregroundColor: Color(0xFFFFD829),
        ),
      ),
    );
  }
}
