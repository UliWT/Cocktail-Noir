import 'package:flutter/material.dart';

class BarraBusqueda extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onBuscar;
  final EdgeInsetsGeometry? paddingIcon;
  final double paddingVertical;
  final double paddingHorizontal;

  const BarraBusqueda({
    super.key,
    required this.controller,
    required this.onBuscar,
    this.paddingIcon,
    this.paddingVertical = 6,
    this.paddingHorizontal = 12,
  });

  @override
  Widget build(BuildContext context) {
  return Container(
  height: 56,
  decoration: BoxDecoration(
    border: Border.all(color: const Color(0xFFFFD829), width: 1.5),
    borderRadius: BorderRadius.circular(6),
  ),
  child: Row(
    children: [
      Expanded(
        child: TextField(
          controller: controller,
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            hintText: 'Buscar trago...',
            hintStyle: TextStyle(color: Colors.grey),
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(horizontal: 12),
          ),
        ),
      ),
      Material(
        color: const Color(0xFFFFD829),
        child: InkWell(
          onTap: onBuscar,
          child: SizedBox(
            width: 56,
            height: 56,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: const Icon(Icons.search, color: Colors.black),
            ),
          ),
        ),
      ),
    ],
  ),
);

  }
}
