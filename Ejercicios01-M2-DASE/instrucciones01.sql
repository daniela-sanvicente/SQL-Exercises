INSERT INTO Friends (sexo,nombre,profesion,actor) VALUES ('M','Paul Stevens','Actor','Bruce Willis');

UPDATE Friends SET profesion="Camarera" WHERE nombre="Ursula Buffay";

UPDATE BigBangTheory SET profesion="Físico" WHERE personaje="Stephen Hawking";

DELETE FROM LocosAddams WHERE id=160;

SELECT * FROM estados ORDER BY clientes DESC LIMIT 5;

SELECT nombre FROM estados WHERE fabrica=1;

SELECT "Friends" AS "Resultado", sexo, COUNT(*) AS TotalSexo FROM Friends GROUP BY sexo
UNION ALL
SELECT "BigBangTheory", sexo, COUNT(*) AS TotalSexo FROM BigBangTheory GROUP BY sexo
UNION ALL
SELECT "LocosAddams", sexo, COUNT(*) AS TotalSexo FROM LocosAddams GROUP BY sexo;

