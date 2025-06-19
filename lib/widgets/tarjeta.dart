import 'package:flutter/material.dart';
import 'package:myapp/favoritos_manager.dart';
import 'tag.dart'; // Tu widget de tag

class Tarjeta extends StatelessWidget {
  final String titulo;
  final String? descripcion;
  final String? ingredientes;
  final String? preparacion;
  final String? decoracion;
  final List<String> tags;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;

  final Map<String, dynamic>? trago;
  final VoidCallback? onToggleFavorito;

  const Tarjeta({
    super.key,
    required this.titulo,
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
  });

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
        border: Border.all(color: Color(0xFFFFD829), width: 2),
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                titulo,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Color(0xFFFFD829),
                ),
              ),
              if (descripcion != null && descripcion!.trim().isNotEmpty)
                Text(
                  descripcion!,
                  style: const TextStyle(color: Colors.white),
                  softWrap: true,
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
                  children: tags
                      .map((texto) => Tag(
                            texto: texto,
                          ))
                      .toList(),
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
                  FavoritosManager().esFavorito(titulo)
                      ? Icons.star
                      : Icons.star_border,
                  color: Color(0xFFFFD829),
                  size: 28,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
