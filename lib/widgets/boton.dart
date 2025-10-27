import 'package:flutter/material.dart';

class Boton extends StatelessWidget {
  final String texto;
  final VoidCallback? onPressed;
  final EdgeInsetsGeometry? padding;
  final double? borderRadius;
  final TextStyle? style;
  final String? emoji;
  final bool seleccionado;

  const Boton({
    super.key,
    required this.texto,
    this.onPressed,
    this.padding,
    this.borderRadius,
    this.style,
    this.emoji,
    this.seleccionado = false,
  });

  @override
  Widget build(BuildContext context) {
    final Color colorNormalFondo = const Color(0xFF303030);
    final Color colorNormalTexto = Colors.white;
    final Color colorNormalBorde = const Color(0xFFD4AF37);

    final Color colorPresionadoFondo = const Color(0xFFD4AF37);
    final Color colorPresionadoTexto = const Color(0xFF4C4C4C);
    final Color colorPresionadoBorde = const Color(0xFFFFCD29);

    // COLORES INVERTIDOS PARA ESTADO SELECCIONADO
    final Color colorSeleccionadoFondo = colorPresionadoFondo;
    final Color colorSeleccionadoTexto = colorPresionadoTexto;
    final Color colorSeleccionadoBorde = colorPresionadoBorde;  

    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        padding: MaterialStateProperty.all(
          padding ?? const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
        ),
        backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {
          if (seleccionado) {
            return colorSeleccionadoFondo;
          }
          if (states.contains(MaterialState.pressed)) {
            return colorPresionadoFondo;
          }
          return colorNormalFondo;
        }),
        foregroundColor: MaterialStateProperty.resolveWith<Color>((states) {
          if (seleccionado) {
            return colorSeleccionadoTexto;
          }
          if (states.contains(MaterialState.pressed)) {
            return colorPresionadoTexto;
          }
          return colorNormalTexto;
        }),
        side: MaterialStateProperty.resolveWith<BorderSide>((states) {
          if (seleccionado) {
            return BorderSide(color: colorSeleccionadoBorde, width: 2);
          }
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
          TextStyle baseStyle = style ?? const TextStyle(fontSize: 16);
          if (seleccionado) {
            return baseStyle.copyWith(
              shadows: [
                Shadow(
                  offset: Offset(0, 0),
                  color: colorSeleccionadoBorde,
                  blurRadius: 3,
                ),
              ],
            );
          }
          if (states.contains(MaterialState.pressed)) {
            return baseStyle.copyWith(
              shadows: [
                Shadow(
                  offset: Offset(0, 0),
                  color: colorPresionadoBorde,
                  blurRadius: 3,
                ),
              ],
            );
          }
          return baseStyle;
        }),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (emoji != null) ...[
            Text(
              emoji!,
              style: const TextStyle(fontSize: 28),
            ),
            const SizedBox(height: 6),
          ],
          Text(texto, style: style),
        ],
      ),
    );
  }
}
