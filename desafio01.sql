\c postgres
DROP DATABASE blog;

CREATE DATABASE blog;

\c blog

CREATE TABLE usuarios(
    id SERIAL,
    email VARCHAR(50),
    PRIMARY KEY(id)
);

CREATE TABLE posts(
    id INT,
    usuario_id INT,
    titulo VARCHAR(200),
    fecha DATE,
    PRIMARY KEY(id),
    FOREIGN KEY(usuario_id) REFERENCES usuarios(id)
);

CREATE TABLE comentarios(
    id INT,
    usuario_id INT,
    post_id INT,
    texto VARCHAR,
    fecha DATE,
    PRIMARY KEY(id),
    FOREIGN KEY(post_id) REFERENCES posts(id),
    FOREIGN KEY(usuario_id) REFERENCES usuarios(id)
);

INSERT INTO usuarios (email) VALUES ('usuario01@hotmail.com');
INSERT INTO usuarios (email) VALUES ('usuario02@gmail.com');
INSERT INTO usuarios (email) VALUES ('usuario03@gmail.com');
INSERT INTO usuarios (email) VALUES ('usuario04@hotmail.com');
INSERT INTO usuarios (email) VALUES ('usuario05@yahoo.com');
INSERT INTO usuarios (email) VALUES ('usuario06@hotmail.com');
INSERT INTO usuarios (email) VALUES ('usuario07@yahoo.com');
INSERT INTO usuarios (email) VALUES ('usuario08@yahoo.com');
INSERT INTO usuarios (email) VALUES ('usuario09@yahoo.com');

\copy posts FROM 'post.csv' csv header;
\copy comentarios FROM 'comentarios.csv' csv header;

SELECT email, p.id, titulo 
FROM usuarios u
INNER JOIN posts p
ON u.id = usuario_id
WHERE u.id = 5; 

SELECT B.email, A.id, A.texto
FROM comentarios AS A
INNER JOIN usuarios AS B
ON B.id = A.usuario_id
WHERE B.email !='usuario06@hotmail.com';

SELECT * 
FROM usuarios u
LEFT JOIN posts p
ON u.id = p.usuario_id
WHERE p.id IS NULL;

SELECT *
FROM posts p
FULL OUTER JOIN comentarios com
ON p.id = com.post_ID;

SELECT u.*, p.fecha
FROM usuarios AS u
INNER JOIN posts AS p
ON u.id = p.usuario_id
WHERE EXTRACT(MONTH FROM p.fecha) = 06;