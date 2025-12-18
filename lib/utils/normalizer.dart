import 'package:flutter/foundation.dart';

String _removeDiacritics(String s) {
  const from = 'áÁéÉíÍóÓúÚñÑüÜ';
  const to = 'aAeEiIoOuUnNuU';
  var out = s;
  for (var i = 0; i < from.length; i++) {
    out = out.replaceAll(from[i], to[i]);
  }
  return out;
}

String normalizeText(String input) {
  var s = input.toLowerCase();
  s = _removeDiacritics(s);
  s = s.replaceAll(RegExp(r"[\n\t\\/,_\-()\[\].:]"), ' ');
  s = s.replaceAll(RegExp(r"\d+([\.,]\d+)?"), '');
  s = s.replaceAll(RegExp(r"[^a-z\s]"), '');
  s = s.replaceAll(RegExp(r"\s+"), ' ').trim();
  return s;
}

String normalizeIngredient(String input) {
  var s = normalizeText(input);
  
  // Lista de "stop words" reducida para no borrar ingredientes reales
  final stopWords = [
    'ml', 'oz', 'ounce', 'ounces', 'shot', 'shots', 'cl', 'tbsp', 'tsp', 'cup', 'cups',
    'cucharadita', 'cucharaditas', 'cucharada', 'cucharadas', 'kg', 'g', 'l', 'litro', 'litros',
    'de', 'al gusto', 'a gusto', 'fresca', 'fresco', 'opcional', 'un', 'una'
  ];

  final parts = s.split(' ');
  if (parts.length <= 1) return s;

  final filtered = parts.where((p) => p.isNotEmpty && !stopWords.contains(p)).toList();
  return filtered.isEmpty ? s : filtered.join(' ');
}

/// Compara ingrediente de receta vs ingrediente disponible
bool ingredientMatches(String recipeIng, String barIng) {
  // Normalizamos ambos antes de comparar
  final r = normalizeIngredient(recipeIng);
  final b = normalizeIngredient(barIng);

  if (r.isEmpty || b.isEmpty) return false;

  final rTokens = r.split(' ');
  final bTokens = b.split(' ');

  // 1. Match Exacto o por Contención Total
  // (Ej: Bar: "ron blanco" vs Receta: "ron blanco")
  if (r.contains(b) || b.contains(r)) return true;

  // 2. Match Cruce de Tokens (Atrapamos "Ron" en "Ron Blanco")
  for (final bt in bTokens) {
    if (bt.length < 3) continue; // Ignoramos conectores cortos
    for (final rt in rTokens) {
      if (rt.length < 3) continue;
      if (rt == bt || rt.contains(bt) || bt.contains(rt)) return true;
    }
  }
  return false;
}