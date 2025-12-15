import 'dart:math';
import 'package:myapp/favoritos_manager.dart';
import 'package:flutter/material.dart';
import 'package:myapp/widgets/main_scaffold.dart';
import 'package:myapp/widgets/tarjeta.dart';
import 'package:myapp/widgets/boton.dart';
import 'package:myapp/data/db_helper.dart';

class SorprendemeScreen extends StatefulWidget {
  const SorprendemeScreen({super.key});

  @override
  State<SorprendemeScreen> createState() => _SorprendemeScreenState();
}

class _SorprendemeScreenState extends State<SorprendemeScreen> {
  late Map<String, dynamic> tragoActual;
  final _random = Random();
  List<Map<String, dynamic>> _todosTragos = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _cargarTragos();
  }

  Future<void> _cargarTragos() async {
    try {
      final dbTragos = await DBHelper().getAllTragos();
      if (dbTragos.isNotEmpty) {
        setState(() {
          _todosTragos = dbTragos;
          tragoActual = dbTragos[_random.nextInt(dbTragos.length)];
          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      print('Error cargando tragos en sorprendeme: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _refrescarTrago() {
    if (_todosTragos.isEmpty) return;
    setState(() {
      Map<String, dynamic> nuevoTrago;
      do {
        nuevoTrago = _todosTragos[_random.nextInt(_todosTragos.length)];
      } while (nuevoTrago == tragoActual && _todosTragos.length > 1);
      tragoActual = nuevoTrago;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      selectedIndex: 0,
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1A1A),
        elevation: 0,
        title: const Text('Sorprendeme'),
      ),
      backgroundColor: const Color(0xFF1A1A1A),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(color: Colors.yellow),
            )
          : Padding(
        padding: const EdgeInsets.all(16),
        child: _todosTragos.isEmpty
            ? Center(
                child: Text(
                  'No hay tragos disponibles.',
                  style: TextStyle(color: Colors.grey.shade400),
                ),
              )
            : Column(
                children: [
                  // Normalizar tags que pueden ser String o List
                  Builder(builder: (context) {
                    final t = tragoActual;
                    final rawTags = t['tags'];
                    final List<String> tagsList = rawTags is String
                        ? rawTags.split(',').map((s) => s.trim()).where((s) => s.isNotEmpty).toList()
                        : List<String>.from(rawTags ?? []);

                    return Tarjeta(
                      nombre: t['nombre'] ?? '',
                      descripcion: t['descripcion'],
                      ingredientes: t['ingredientes'],
                      preparacion: t['preparacion'],
                      decoracion: t['decoracion'],
                      tags: tagsList,
                      width: double.infinity,
                      trago: t,
                      onToggleFavorito: () {
                        setState(() {
                          FavoritosManager().toggleFavorito(t);
                        });
                      },
                    );
                  }),
                  const SizedBox(height: 24),
                  Boton(
                    texto: '¡Otra Sorpresa!',
                    onPressed: _refrescarTrago,
                    padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 14),
                    borderRadius: 8,
                    style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
      ),
    );
  }
}
