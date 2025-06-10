import 'package:flutter/material.dart';

class Boton extends StatelessWidget {
  final String texto;
  final VoidCallback? onPressed;
  final EdgeInsetsGeometry? padding;
  final double? borderRadius;

  const Boton({
    super.key,
    required this.texto,
    this.onPressed,
    this.padding,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final Color colorNormalFondo = Color(0xFF303030);
    final Color colorNormalTexto = Colors.white;
    final Color colorNormalBorde = Color(0xFFD4AF37);

    final Color colorPresionadoFondo = Color(0xFFD4AF37);
    final Color colorPresionadoTexto = Color(0xFF4C4C4C);
    final Color colorPresionadoBorde = Color(0xFFFFCD29);

    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        padding: MaterialStateProperty.all(
          padding ?? const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
        ),
        backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {
          if (states.contains(MaterialState.pressed)) {
            return colorPresionadoFondo;
          }
          return colorNormalFondo;
        }),
        foregroundColor: MaterialStateProperty.resolveWith<Color>((states) {
          if (states.contains(MaterialState.pressed)) {
            return colorPresionadoTexto;
          }
          return colorNormalTexto;
        }),
        side: MaterialStateProperty.resolveWith<BorderSide>((states) {
          if (states.contains(MaterialState.pressed)) {
            return BorderSide(color: colorPresionadoBorde, width: 2);
          }
          return BorderSide(color: colorNormalBorde, width: 2);
        }),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 4),
          ),
        ),
        textStyle: MaterialStateProperty.resolveWith<TextStyle>((states) {
          if (states.contains(MaterialState.pressed)) {
            return TextStyle(
              shadows: [
                Shadow(
                  offset: Offset(0, 0),
                  color: colorPresionadoBorde,
                  blurRadius: 3,
                ),
              ],
            );
          }
          return TextStyle();
        }),
      ),
      child: Text(texto),
    );
  }
}
