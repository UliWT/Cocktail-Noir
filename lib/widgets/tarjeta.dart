import 'package:flutter/material.dart';
import 'package:myapp/favoritos_manager.dart';
import 'tag.dart';

class Tarjeta extends StatelessWidget {
  final String nombre;
  final String? descripcion;
  final String? ingredientes;
  final String? preparacion;
  final String? decoracion;
  final List<String> tags;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onTap;

  final Map<String, dynamic>? trago; // para pasar el mapa entero
  final VoidCallback? onToggleFavorito;

  // Constructor principal (con parámetros explícitos)
  const Tarjeta({
    Key? key,
    required this.nombre,
    this.descripcion,
    this.ingredientes,
    this.preparacion,
    this.decoracion,
    this.tags = const [],
    this.width,
    this.height,
    this.padding,
    this.trago,
    this.onToggleFavorito,
    this.onTap,
  }) : super(key: key);

  // Constructor de fábrica que crea la tarjeta a partir de un Map (ej. un trago)
  factory Tarjeta.desdeMapa(
    Map<String, dynamic> trago, {
    Key? key,
    double? width,
    double? height,
    EdgeInsetsGeometry? padding,
    VoidCallback? onToggleFavorito,
  }) {
    // Normalizar tags que pueden venir como String (comma-separated) o List
    List<String> _parseTags(dynamic raw) {
      if (raw == null) return <String>[];
      if (raw is List) return raw.map((e) => e.toString()).toList();
      if (raw is String) {
        return raw
            .split(',')
            .map((s) => s.trim())
            .where((s) => s.isNotEmpty)
            .toList();
      }
      return [raw.toString()];
    }

    // Normalizar ingredientes que pueden venir como List o String
    String? _parseIngredientes(dynamic raw) {
      if (raw == null) return null;
      if (raw is List) return raw.map((e) => e.toString()).join('\n');
      return raw.toString();
    }

    return Tarjeta(
      key: key,
      nombre: trago['nombre'] ?? '',
      descripcion: trago['descripcion'],
      ingredientes: _parseIngredientes(trago['ingredientes']),
      preparacion: trago['preparacion'],
      decoracion: trago['decoracion'],
      tags: _parseTags(trago['tags']),
      width: width,
      height: height,
      padding: padding,
      trago: trago,
      onToggleFavorito: onToggleFavorito,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: padding ?? const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF2C2C2C),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFFFD829), width: 2),
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                nombre,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Color(0xFFFFD829),
                ),
              ),
              if (descripcion != null && descripcion!.trim().isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Text(
                    descripcion!,
                    style: const TextStyle(color: Colors.white),
                    softWrap: true,
                  ),
                ),
              if (ingredientes != null && ingredientes!.trim().isNotEmpty) ...[
                const SizedBox(height: 12),
                const Text(
                  'Ingredientes',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                Text(
                  ingredientes!,
                  style: const TextStyle(color: Colors.white),
                  softWrap: true,
                ),
              ],
              if (preparacion != null && preparacion!.trim().isNotEmpty) ...[
                const SizedBox(height: 12),
                const Text(
                  'Preparación',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                Text(
                  preparacion!,
                  style: const TextStyle(color: Colors.white),
                  softWrap: true,
                ),
              ],
              if (decoracion != null && decoracion!.trim().isNotEmpty) ...[
                const SizedBox(height: 12),
                const Text(
                  'Decoración',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.white,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                Text(
                  decoracion!,
                  style: const TextStyle(
                    fontStyle: FontStyle.italic,
                    color: Colors.white,
                  ),
                  softWrap: true,
                ),
              ],
              if (tags.isNotEmpty) ...[
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  runSpacing: 6,
                  children: tags.map((texto) => Tag(texto: texto)).toList(),
                ),
              ],
            ],
          ),
          if (trago != null && onToggleFavorito != null)
            Positioned(
              top: 4,
              right: 4,
              child: GestureDetector(
                onTap: onToggleFavorito,
                child: Icon(
                  FavoritosManager().esFavorito(nombre)
                      ? Icons.star
                      : Icons.star_border,
                  color: const Color(0xFFFFD829),
                  size: 28,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
