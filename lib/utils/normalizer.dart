String _removeDiacritics(String s) {
  const from = 'áÁéÉíÍóÓúÚñÑüÜ';
  const to   = 'aAeEiIoOuUnNuU';
  var out = s;
  for (var i = 0; i < from.length; i++) {
    out = out.replaceAll(from[i], to[i]);
  }
  return out;
}

String normalizeText(String input) {
  var s = input.toLowerCase();
  s = _removeDiacritics(s);
  // reemplazar múltiples separadores por espacio
  s = s.replaceAll(RegExp(r"[\n\t\\/,_\-()\[\].:]"), ' ');
  // eliminar números y unidades puntuales (pero conservar palabras como 'jugo')
  s = s.replaceAll(RegExp(r"\d+([\.,]\d+)?"), '');
  // quitar puntuación restante
  s = s.replaceAll(RegExp(r"[^a-z\s]"), '');
  // normalizar espacios
  s = s.replaceAll(RegExp(r"\s+"), ' ').trim();
  return s;
}

String normalizeIngredient(String input) {
  var s = normalizeText(input);
  // quitar palabras comunes que no aportan al match
  final stop = [
    'ml','oz','ounce','ounces','shot','shots','cl','tbsp','tsp','cup','cups',
    'cucharadita','cucharaditas','cucharada','cucharadas','kg','g','l','litro','litros',
    'jugo','de','rodaja','rodajas','trozo','trozos','slice','slices','cubitos','cubito',
    'al gusto','a gusto','algun','alguna'
  ];
  final parts = s.split(' ');
  final filtered = parts.where((p) => p.isNotEmpty && !stop.contains(p)).toList();
  return filtered.join(' ');
}

List<String> tokenize(String input) {
  final s = normalizeIngredient(input);
  if (s.isEmpty) return [];
  return s.split(' ');
}

bool ingredientMatches(String ingredientNormalized, String availableNormalized) {
  if (ingredientNormalized.isEmpty || availableNormalized.isEmpty) return false;
  // match by token overlap
  final aTokens = availableNormalized.split(' ');
  final iTokens = ingredientNormalized.split(' ');
  for (final at in aTokens) {
    for (final it in iTokens) {
      if (at == it) return true;
      if (it.contains(at) || at.contains(it)) return true;
    }
  }
  return false;
}
