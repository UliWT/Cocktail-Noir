DROP TABLE IF EXISTS tragos;
CREATE TABLE tragos (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100),
  descripcion TEXT,
  ingredientes TEXT,
  preparacion TEXT,
  decoracion VARCHAR(255),
  tags TEXT
);

INSERT INTO tragos (nombre, descripcion, ingredientes, preparacion, decoracion, tags) VALUES ('Espresso Martini', 'Intenso y sofisticado. Ideal para cerrar la noche con energía y estilo.', '1 shot de espresso (30 ml)
Vodka 45 ml
Kahlúa 30 ml
Almíbar 10 ml', '1. Mezclar todos los ingredientes en una coctelera con hielo
2. Agitar enérgicamente durante 20 segundos
3. Servir en una copa de martini', 'Granos de café', 'Vodka, Sedoso, Dulce, Amargo');
INSERT INTO tragos (nombre, descripcion, ingredientes, preparacion, decoracion, tags) VALUES ('Mojito', 'Refrescante y cítrico, el clásico cubano para días calurosos.', 'Ron blanco 50 ml
8-10 hojas de hierbabuena
2 cucharaditas de azúcar
30 ml jugo de lima
Soda al gusto', '1. Machacar la hierbabuena con azúcar y lima
2. Agregar ron y hielo
3. Completar con soda y mezclar suavemente
4. Servir en vaso highball', 'Hojas de hierbabuena', 'Ron, Refrescante, Cítrico, Herbal');
INSERT INTO tragos (nombre, descripcion, ingredientes, preparacion, decoracion, tags) VALUES ('Negroni', 'Elegante y robusto. La sofisticación italiana en su expresión más pura y contundente.', 'Campari 30 ml
Vermouth Rosso 30 ml
Gin 30 ml', '1. En un vaso mezclador lleno de hielo poner todos los ingredientes
2. Revolver durante 20 segundos
3. Servir en vaso Rocks', 'Cáscara de naranja', 'Campari, Amargo, Clásico');
INSERT INTO tragos (nombre, descripcion, ingredientes, preparacion, decoracion, tags) VALUES ('Piña Colada', 'Dulce y cremoso, un clásico tropical para relajarse.', 'Ron blanco 50 ml
Crema de coco 30 ml
Jugo de piña 90 ml', '1. Mezclar todos los ingredientes en una coctelera con hielo
2. Servir en vaso hurricane', 'Trozo de piña y cereza', 'Ron, Tropical, Cremoso');
INSERT INTO tragos (nombre, descripcion, ingredientes, preparacion, decoracion, tags) VALUES ('Margarita', 'Cítrico y refrescante, el rey de los cócteles mexicanos.', 'Tequila 50 ml
Triple sec 20 ml
Jugo de lima 30 ml
Sal para escarchar el borde', '1. Escarchar el borde del vaso con sal y limón
2. Mezclar todos los ingredientes en una coctelera con hielo
3. Agitar enérgicamente durante 20 segundos
4. Servir en copa Margarita escarchada', 'Rodaja de lima', 'Tequila, Fresco, Salado');
INSERT INTO tragos (nombre, descripcion, ingredientes, preparacion, decoracion, tags) VALUES ('Old Fashioned', 'Clásico y robusto, para quienes disfrutan del whisky puro.', 'Whisky bourbon 60 ml
1 terrón de azúcar
2 dashes de angostura
Hielo al gusto', '1. Disolver azúcar con angostura en el vaso
2. Agregar hielo y whisky
3. Revolver suavemente
4. Servir en vaso Rocks', 'Cáscara de naranja', 'Whisky, Clásico, Seco');
INSERT INTO tragos (nombre, descripcion, ingredientes, preparacion, decoracion, tags) VALUES ('Cosmopolitan', 'Elegante y afrutado, favorito en las noches urbanas.', 'Vodka 45 ml
Triple sec 15 ml
Jugo de arándano 30 ml
Jugo de lima 15 ml', '1. Mezclar todos los ingredientes en una coctelera con hielo
2. Agitar enérgicamente durante 20 segundos
3. Servir en una copa de martini', 'Twist de lima', 'Vodka, Cítrico, Dulce');
INSERT INTO tragos (nombre, descripcion, ingredientes, preparacion, decoracion, tags) VALUES ('Daiquiri', 'Fresco y simple, un clásico cubano que nunca falla.', 'Ron blanco 50 ml
Jugo de lima 25 ml
2 cucharaditas de azúcar', '1. Mezclar todos los ingredientes en una coctelera con hielo
2. Agitar enérgicamente durante 20 segundos
3. Servir en una copa coupe', 'Rodaja de lima', 'Ron, Fresco, Dulce');
INSERT INTO tragos (nombre, descripcion, ingredientes, preparacion, decoracion, tags) VALUES ('Caipirinha', 'El trago nacional de Brasil, cítrico y dulce.', 'Cachaça 50 ml
1 lima cortada en trozos
2 cucharaditas de azúcar', '1. Machacar la lima con azúcar
2. Agregar cachaça y hielo
3. Servir en vaso Rocks', 'Trozo de lima', 'Cachaça, Dulce, Refrescante');
INSERT INTO tragos (nombre, descripcion, ingredientes, preparacion, decoracion, tags) VALUES ('French 75', 'Burbujeante y elegante, ideal para celebraciones.', 'Gin 30 ml
Champagne 60 ml
Jugo de limón 15 ml
1 cucharadita de azúcar', '1. Mezclar todos los ingredientes en una coctelera con hielo
2. Agitar enérgicamente durante 20 segundos
3. Colar y servir en copa flauta
4. Completar con champagne', 'Twist de limón', 'Gin, Cítrico, Elegante');
INSERT INTO tragos (nombre, descripcion, ingredientes, preparacion, decoracion, tags) VALUES ('Sazerac', 'Clásico neoyorquino con un toque de absenta y amargos.', 'Whisky de centeno 60 ml
Azúcar 1 cubo
Amargos Peychaud 3 dashes
Absenta para enjuagar el vaso', '1. Enfriar el vaso con absenta
2. Mezclar whisky, azúcar y amargos en otro vaso
3. Colar en el vaso enfriado
4. Servir sin hielo', 'Cáscara de limón', 'Whisky, Amargo, Clásico');
INSERT INTO tragos (nombre, descripcion, ingredientes, preparacion, decoracion, tags) VALUES ('Aperol Spritz', 'Ligero y burbujeante, el aperitivo veraniego italiano.', 'Aperol 60 ml
Prosecco 90 ml
Soda 30 ml
Rodaja de naranja', '1. Llenar vaso con hielo
2. Agregar Aperol y Prosecco
3. Completar con soda
4. Servir en vaso balón', 'Rodaja de naranja', 'Aperol, Burbujeante, Refrescante');
INSERT INTO tragos (nombre, descripcion, ingredientes, preparacion, decoracion, tags) VALUES ('Tom Collins', 'Refrescante y cítrico, el clásico con gin y limón.', 'Gin 50 ml
Jugo de limón 25 ml
Azúcar 15 ml
Soda al gusto', '1. Mezclar gin, jugo de limón y azúcar
2. Servir con hielo en vaso alto
3. Completar con soda', 'Rodaja de limón', 'Gin, Cítrico, Refrescante');
INSERT INTO tragos (nombre, descripcion, ingredientes, preparacion, decoracion, tags) VALUES ('Mint Julep', 'Clásico sureño, refrescante con menta y bourbon.', 'Bourbon 60 ml
Hojas de menta 10
Azúcar 1 cucharadita
Agua', '1. Machacar menta con azúcar y agua
2. Agregar bourbon y hielo picado
3. Servir en vaso julep', 'Rama de menta', 'Bourbon, Refrescante, Mentolado');
INSERT INTO tragos (nombre, descripcion, ingredientes, preparacion, decoracion, tags) VALUES ('Black Russian', 'Sencillo y fuerte, mezcla de vodka y licor de café.', 'Vodka 50 ml
Licor de café 20 ml', '1. En un vaso mezclador lleno de hielo poner todos los ingredientes
2. Revolver durante 20 segundos
3. Servir en vaso old fashioned', 'Sin decoración', 'Vodka, Café, Fuerte');
INSERT INTO tragos (nombre, descripcion, ingredientes, preparacion, decoracion, tags) VALUES ('Mai Tai', 'Tropical y exótico, mezcla de ron y almendra.', 'Ron blanco 30 ml
Ron oscuro 30 ml
Triple sec 15 ml
Jugo de lima 15 ml
Orgeat 15 ml', '1. Mezclar todos los ingredientes en una coctelera con hielo
2. Servir en vaso old fashioned
3. Decorar con rodaja de lima', 'Rodaja de lima', 'Ron, Tropical, Dulce');
INSERT INTO tragos (nombre, descripcion, ingredientes, preparacion, decoracion, tags) VALUES ('French Martini', 'Dulce y afrutado, con toque de frambuesa y vodka.', 'Vodka 45 ml
Licor de frambuesa 15 ml
Jugo de piña 30 ml', '1. Mezclar todos los ingredientes en una coctelera con hielo
2. Agitar enérgicamente durante 20 segundos
3. Servir en copa de martini', 'Frambuesa fresca', 'Vodka, Frutal, Dulce');
INSERT INTO tragos (nombre, descripcion, ingredientes, preparacion, decoracion, tags) VALUES ('Aviation', 'Clásico con gin, toque floral y cereza marrasquino.', 'Gin 45 ml
Licor de marrasquino 15 ml
Jugo de limón 15 ml
Crema de violeta 5 ml', '1. Mezclar todos los ingredientes en una coctelera con hielo
2. Agitar enérgicamente durante 20 segundos
3. Servir en copa coupe', 'Cereza marrasquino', 'Gin, Floral, Cítrico');
INSERT INTO tragos (nombre, descripcion, ingredientes, preparacion, decoracion, tags) VALUES ('Apple Martini', 'Dulce, ácido y moderno. Un cóctel vibrante con sabor a manzana verde.', 'Vodka 45 ml
Licor de manzana 30 ml
Jugo de lima 15 ml
Hielo', '1. Agitar todos los ingredientes en una coctelera con hielo
2. Colar y servir en una copa de martini bien fría', 'Rodaja fina de manzana verde', 'Vodka, Dulce, Frutal, Ácido');
INSERT INTO tragos (nombre, descripcion, ingredientes, preparacion, decoracion, tags) VALUES ('Long Island Iced Tea', 'Potente y refrescante. Ideal para quienes buscan intensidad con sabor cítrico.', 'Vodka 15 ml
Tequila 15 ml
Ron blanco 15 ml
Ginebra 15 ml
Triple sec 15 ml
Jugo de lima 25 ml
Refresco de cola al gusto
Hielo', '1. Mezclar todos los licores y el jugo de lima en un vaso con hielo
2. Completar con coca cola y revolver suavemente', 'Rodaja de limón', 'Fuerte, Cítrico, Refrescante, Multi-licor');