# Resumen del proyecto MyApp

Este documento resume la finalidad de los archivos principales del proyecto, dónde están las partes clave y cómo funciona el flujo de datos.

## Estructura general
- `lib/`: código fuente de la app Flutter.
- `assets/db/dbcocktail.db`: base de datos SQLite incluida (preconstruida).
- `lib/data/`: helpers y acceso a datos (DBHelper, modelos, scripts relacionados).
- `lib/screens/`: pantallas de la app (Explorar, Preparar, NavBar, etc.).
- `lib/widgets/`: componentes reutilizables (Tarjeta, Modal, Boton, NavBar, etc.).
- `lib/scripts/`: scripts de utilidad (generar DB, antes había scripts de traducción/inspección).

## Archivos y su propósito (clave)

- `lib/main.dart`: punto de entrada de la app; configura tema y rutas principales.

- `lib/data/db_helper.dart`: manejador de la base de datos SQLite en runtime.
  - Copia la `assets/db/dbcocktail.db` al directorio de documentos en el primer arranque o cuando la asset es más reciente.
  - Expone `getAllTragos()`, `insertTrago()`, `updateTrago()`, `deleteTrago()` y `debugDump()` para inspección.
  - **Importante**: la sincronización con APIs fue removida; la app usa la DB local incluida.

- `assets/db/dbcocktail.db`: la base de datos de cócteles usada por la app.
  - Si necesitas revertir a la versión anterior, existe `assets/db/dbcocktail.db.bak` (backup creado por scripts).

- `lib/widgets/tarjeta.dart`: componente principal para mostrar un trago.
  - Factoría `Tarjeta.desdeMapa` normaliza campos (`tags`, `ingredientes`) y evita crashes por tipos inesperados.

- `lib/widgets/modalSheet.dart`: muestra detalles de un trago en un modal; reutiliza `Tarjeta`.

- `lib/screens/Explorar/`:
  - `p_ing.dart`: búsqueda por ingrediente (integra `MiBarManager`).
  - `busca_t.dart`: búsqueda por tag.
  - `novedades.dart`: pantalla de novedades (lista de tragos destacados). Actualmente carga datos en memoria; puede cambiar para leer de DB.

- `lib/favoritos_manager.dart` y `lib/mi_bar_manager.dart`: gestores en memoria para favoritos y los ingredientes del usuario.

- `lib/scripts/generate_db.dart`: script para generar una versión preconstruida de la DB (descarga desde TheCocktailDB). Útil para regenerar `assets/db/dbcocktail.db` fuera de la app.
  - Nota: los scripts de traducción/inspección fueron añadidos temporalmente y ahora se han dejado como stubs.

## Flujo de datos clave
- Lectura inicial de la DB: `DBHelper._initDB()` copia `assets/db/dbcocktail.db` si hace falta y abre la DB con `sqflite`.
- Mostrar listas: las pantallas llaman `DBHelper().getAllTragos()` (u otras consultas) para obtener mapas que alimentan `Tarjeta`.
- Favoritos / MiBar: gestionados en memoria por sus managers; pueden almacenarse posteriormente en la DB si querés persistencia.

## Qué modifiqué ahora
- Restauré `assets/db/dbcocktail.db` desde el backup `.bak` para volver al estado que funciona.
- Eliminé/neutralicé el código de integración con la API (`lib/data/cocktail_api_service.dart` fue reemplazado por un stub) y los scripts de traducción/inspección fueron dejados como stubs.

## Siguientes pasos recomendados (para la entrega)
1. Ejecutar la app y verificar pantallas: `flutter run`.
2. Revisar `Novedades` si querés que muestre items persistentes: implementar lectura desde DB en lugar de la lista en memoria.
3. Si querés persistir MiBar/Favoritos, añadir columnas/tablas y usar `DBHelper.insertTrago()` o tablas específicas.

Si querés, puedo generar una versión más detallada con referencia por archivo (cada archivo con una pequeña descripción) o un diagrama de dependencias.

***
Documento generado automáticamente — dime si querés que incluya más archivos o ejemplos de queries.
