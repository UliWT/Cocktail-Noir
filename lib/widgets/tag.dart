import'package:flutter/material.dart';

class Tag extends StatelessWidget{
  final String texto;
  final EdgeInsetsGeometry? padding;
  final double? borderRadius;
  final TextStyle? style;

const Tag({
  super.key,
  required this.texto,
  this.padding,
  this.borderRadius,
  this.style,
});


  @override
  Widget build(BuildContext context) {
    final Color colorFondo= const Color.fromARGB(162, 212, 175, 55);

    return Container(
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: colorFondo,
        borderRadius: BorderRadius.circular(borderRadius ?? 10),
      ),
      child: Text(
        texto,
        style: style ??
            const TextStyle(
              color: Color(0xFFF5E7B9),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
      ),
    );
  }}