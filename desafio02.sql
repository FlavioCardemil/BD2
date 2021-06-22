psql

CREATE DATABASE clase02

\echo :AUTOCOMMIT
\SET AUTOCOMMIT off


psql -U flavio clase02 < unidad2.sql


BEGIN TRANSACTION;

INSERT INTO compra (cliente_id,fecha) VALUES (1,now())
INSERT INTO detalle_compra (producto_id,compra_id,cantidad) VALUES (9,(SELECT max(id) FROM compra),5);
UPDATE producto SET stock = stock - 5;
SELECT * FROM producto WHERE id = 9;
COMMIT;
SELECT * FROM producto WHERE id = 9;


BEGIN TRANSACTION;
INSERT INTO compra (cliente_id,fecha) VALUES (2,now());
INSERT INTO detalle_compra (producto_id,compra_id,cantidad) VALUES (1,(SELECT max(id) FROM compra),3);
INSERT INTO detalle_compra (producto_id,compra_id,cantidad) VALUES (2,(SELECT max(id) FROM compra),3);
INSERT INTO detalle_compra (producto_id,compra_id,cantidad) VALUES (8,(SELECT max(id) FROM compra),3);
UPDATE producto SET stock = stock - 3 WHERE id=1;
UPDATE producto SET stock = stock - 3 WHERE id=2;
UPDATE producto SET stock = stock - 3 WHERE id=8;
SELECT * FROM producto WHERE id = 1;
SELECT * FROM producto WHERE id = 2;
SELECT * FROM producto WHERE id = 8;
COMMIT;
BEGIN;
SAVEPOINT checkpoint;
INSERT INTO compra (id, cliente_id, fecha)
VALUES (33, 1, NOW());
UPDATE producto SET stock = stock - 5 WHERE id = 9;
ROLLBACK TO SAVEPOINT checkpoint;
COMMIT;
SELECT id, stock FROM producto WHERE descripcion = 'producto9';


SELECT id, stock FROM producto WHERE descripcion = 'producto1';
SELECT id, stock FROM producto WHERE descripcion = 'producto2';
SELECT id, stock FROM producto WHERE descripcion = 'producto8';


BEGIN;
INSERT INTO compra (id, cliente_id, fecha)
VALUES (33, 2, NOW());
UPDATE producto SET stock = stock - 3 WHERE id = 1;
SAVEPOINT checkpoint;
INSERT INTO compra (id, cliente_id, fecha)
VALUES (34, 2, NOW());
UPDATE producto SET stock = stock - 3 WHERE id = 2;
SAVEPOINT checkpoint;
INSERT INTO compra (id, cliente_id, fecha)
VALUES (35, 2, NOW());
UPDATE producto SET stock = stock - 3 WHERE id = 8;
ROLLBACK TO SAVEPOINT checkpoint;
COMMIT;

SELECT stock FROM producto WHERE id = 1;
SELECT stock FROM producto WHERE id = 2;
SELECT stock FROM producto WHERE id = 8;

\set AUTOCOMMIT off

BEGIN;
    SAVEPOINT add_client;
    INSERT INTO cliente (id,nombre,email)
    VALUES (11, 'Pedro', usuario11@gmail.com);
    SELECT * FROM cliente WHERE id = 11;
    ROLLBACK to SAVEPOINT add_client;
    SELECT * FROM cliente WHERE id = 11;
COMMIT;


\set AUTOCOMMIT on