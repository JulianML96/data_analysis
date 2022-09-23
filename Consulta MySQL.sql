## Creamos una tabla con un archivo .CSV descargado previamente de nuestra base de datos o software de gestión de bases de datos, donde descartamos 
## los que tienen celdas vacías en la columna ex_showroom_price. 
CREATE TABLE sqlj.bikes
SELECT * 
FROM sqlj.bikes_market
WHERE ex_showroom_price IS NOT NULL;

## Añadimos una nueva entrada al inventario.
INSERT INTO sqlj.bikes (name, selling_price, year, seller_type, owner, km_driven, ex_showroom_price)
VALUES ('Honda CBR f4i', 4000, 2003, 'Individual', '2nd owner', 47000, " ");

## Actualizamos una entrada en concreto, aunque se podría hacer por marca o modelo. 
UPDATE sqlj.bikes
SET ex_showroom_price = "12000"
WHERE name = "Honda CBR f4i";

## Realizamos una consulta donde sea primer o segundo propietario.
SELECT name, selling_price, year, km_driven 
FROM sqlj.bikes
WHERE owner <= "2st owner";

## Creamos una tabla temporal sobre la marca de interés del cliente, Honda.
CREATE TEMPORARY TABLE Hondas
SELECT *
FROM sqlj.bikes
WHERE name like "%Honda%";
 
## Mostramos el precio medio, máximo y promedio.
SELECT
	min(selling_price) AS min_price,
	max(selling_price) AS max_price,
	AVG(selling_price) AS average_price
FROM (SELECT name, selling_price, year, km_driven 
	FROM sqlj.bikes
	WHERE name like "%Honda%"
	GROUP BY year
	ORDER BY selling_price)
AS filter_table;

## Eliminamos las tablas que no nos sirven.
DROP TABLE sqlj.bikes_market;
DROP TABLE sys.bikes;

##  Realizamos la búsqueda exacta según los parámetros dados, menos de $25.000 y menos de 60.000 Km.
SELECT *
FROM Hondas
WHERE selling_price <=25000
AND km_driven < 60000
GROUP BY year
ORDER BY selling_price;
