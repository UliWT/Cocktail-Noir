import 'package:flutter/material.dart';
import 'package:myapp/widgets/tarjeta.dart';
import 'package:myapp/favoritos_manager.dart';

void mostrarDetalleTrago(BuildContext context, Map<String, dynamic> trago, {required VoidCallback onFavoritoChanged}) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
    ),
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setStateModal) {
          return DraggableScrollableSheet(
            expand: false,
            initialChildSize: 0.7,
            minChildSize: 0.4,
            maxChildSize: 0.7,
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF1A1A1A),
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
                  border: Border.all(color: const Color(0xFFD4AF37), width: 2),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black87,
                      blurRadius: 10,
                      offset: Offset(0, -2),
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  controller: scrollController,
                  padding: const EdgeInsets.all(20),
                  child: Tarjeta.desdeMapa(
                    trago,
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    onToggleFavorito: () {
                      FavoritosManager().toggleFavorito(trago);
                      setStateModal(() {});      // actualiza la estrella dentro del modal
                      onFavoritoChanged();        // actualiza la pantalla que llamó el modal
                    },
                  ),
                ),
              );
            },
          );
        },
      );
    },
  );
}
