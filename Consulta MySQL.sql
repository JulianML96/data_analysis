CREATE TABLE sqlj.bikes
SELECT * 
FROM sqlj.bikes_market
WHERE ex_showroom_price IS NOT NULL;

INSERT INTO sqlj.bikes (name, selling_price, year, seller_type, owner, km_driven, ex_showroom_price)
VALUES ('Honda CBR f4i', 4000, 2003, 'Individual', '2nd owner', 47000, " ");

UPDATE sqlj.bikes
SET ex_showroom_price = "12000"
WHERE name = "Honda CBR f4i";


SELECT name, selling_price, year, km_driven 
FROM sqlj.bikes
WHERE owner <= "2st owner";

CREATE TEMPORARY TABLE Hondas
SELECT *
FROM sqlj.bikes
WHERE name like "%Honda%";
 
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


DROP TABLE sqlj.bikes_market;
DROP TABLE sys.bikes;

SELECT *
FROM Hondas
WHERE selling_price <=25000
AND km_driven < 60000
GROUP BY year
ORDER BY selling_price;
