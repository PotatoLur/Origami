DROP DATABASE origami;
CREATE DATABASE origami;

USE origami;

CREATE TABLE usuario (
	id INT NOT NULL AUTO_INCREMENT,
    email VARCHAR (45),
    nome VARCHAR (45) UNIQUE,
    senha VARCHAR (45),
    PRIMARY KEY (id)
);

CREATE TABLE projeto (
	id INT NOT NULL AUTO_INCREMENT,
    fkUsuario INT NOT NULL,
    nome VARCHAR (100),
    tipo VARCHAR (20),
    PRIMARY KEY (id, fkUsuario),
    FOREIGN KEY (fkUsuario) REFERENCES usuario (id)
);

CREATE TABLE comentario (
	id INT NOT NULL AUTO_INCREMENT,
    fkProjeto INT NOT NULL,
    fkUsuario INT NOT NULL,
    comentario VARCHAR (250),
    data_comentario DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id, fkProjeto, fkUsuario),
    FOREIGN KEY (fkProjeto) REFERENCES projeto (id),
    FOREIGN KEY (fkUsuario) REFERENCES usuario (id)
);

CREATE TABLE quiz (
	id INT NOT NULL AUTO_INCREMENT,
    pontuacao INT,
    avaliacao VARCHAR (45),
    fkUsuario INT,
    PRIMARY KEY(id),
    FOREIGN KEY (fkUsuario) REFERENCES usuario (id)
);

CREATE TABLE curtida (
    id INT AUTO_INCREMENT,
    fkUsuario INT NOT NULL,
    fkProjeto INT NOT NULL,
    data_curtida DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE (fkUsuario, fkProjeto),
    FOREIGN KEY (fkUsuario) REFERENCES usuario(id),
    FOREIGN KEY (fkProjeto) REFERENCES projeto(id)
);

INSERT INTO usuario (email, nome, senha) VALUES
	('joao@email.com', 'João Silva', 'senha123@'),
	('maria@email.com', 'Maria Santos', 'senha456@'),
	('pedro@email.com', 'Pedro Alves', 'senha789@'),
	('ana@email.com', 'Ana Carvalho', 'senha321@'),
    ('aoki@gmail.com', 'Aoki01', 'Aoki01@');
    
INSERT INTO projeto (id, fkUsuario, nome, tipo) VALUES
	(1, 1, '3D Swan', 'Origami 3D'),
	(2, 1, 'Polygonal Cubes and Stars', 'Origami Tradicional'),
	(3, 5, '3D Snake', 'Origami 3D'),
	(4, 5, 'DeBugger', 'Origami 3D'),
	(5, 5, 'Balão 3D', 'Origami 3D'),
    (6, 5, 'Herringbone Tesselation', 'Tesselation'),
	(7, 5, 'Balão tradicional', 'Origami Tradicional'),
    (8, 1, 'Joaninha 3D', 'Origami 3D'),
    (9, 5, 'Icosaedro', 'Origami Modular');

INSERT INTO comentario (id, fkProjeto, fkUsuario, comentario) VALUES
	(1, 1, 2, 'Esse cisne ficou incrível!'),
	(2, 2, 3, 'Simples de aprender, parabéns.'),
	(3, 3, 4, 'Muito bom! Deve ter demorado dias.'),
	(4, 4, 1, 'Que fofinho!'),
	(5, 5, 2, 'Nossa. Eu quero um!'),
	(6, 6, 3, 'Muito interessante!'),
	(7, 7, 1, 'Vou tentar fazer.'),
	(8, 8, 4, 'Muito bem, ficou show com essas cores.'),
    (9, 9, 3, 'Muito legal!');

INSERT INTO quiz (pontuacao, avaliacao, fkUsuario) VALUES
	(5, 'Bom', 1),
    (4, 'Mediano', 1),
    (5, 'Ótimo', 3),
    (3, 'Bom', 4),
    (1, 'Ruim', 5),
    (2, 'Mediano', 2),
    (3, 'Ótimo', 5),
    (4, 'Bom', 3),
    (5, 'Ótimo', 5);

INSERT INTO curtida (id, fkUsuario, fkProjeto) VALUES
	(1, 1, 1),
	(2, 1, 2),
	(3, 1, 3),
	(4, 2, 2),
	(5, 2, 3),
	(6, 2, 4),
	(7, 2, 5),
	(8, 3, 1),
	(9, 3, 5),
	(10, 3, 6),
	(11, 3, 7),
	(12, 4, 1),
	(13, 4, 2),
	(14, 4, 3),
	(15, 4, 8),
	(16, 4, 9);

SELECT * FROM quiz q
INNER JOIN usuario u ON u.id = q.fkUsuario;

SELECT pontuacao 
FROM quiz
WHERE fkUsuario = (SELECT id FROM usuario WHERE nome = 'Aoki01');

SELECT p.id AS id,
       u.nome AS autor,
       p.tipo AS tipo,
       p.nome AS nome,
       c.comentario AS comentario,
	   (SELECT COUNT(*) 
        FROM curtida 
        WHERE fkProjeto = p.id)
        AS curtida,
       cu.nome AS comentUsu
       FROM projeto p
       INNER JOIN usuario u ON u.id = p.fkUsuario
       LEFT JOIN comentario c ON c.fkProjeto = p.id
       LEFT JOIN usuario cu ON cu.id = c.fkUsuario
       GROUP BY p.id, u.nome, p.tipo, p.nome, c.comentario, cu.nome
       ORDER BY p.id;

SELECT p.id AS projeto_id,
	   p.nome AS nome_projeto,
       COUNT(c.id) AS total_curtidas
FROM projeto p
LEFT JOIN curtida c ON p.id = c.fkProjeto
GROUP BY p.id, p.nome;

SELECT * FROM comentario;

SELECT * FROM curtida c
INNER JOIN projeto p ON fkProjeto = p.id
INNER JOIN usuario u ON u.id = c.fkUsuario
WHERE p.nome LIKE '%Balão%'
ORDER BY data_curtida;

SELECT p.nome, p.tipo,
	   totalCurtidas, 
       totalComentarios
FROM projeto p
LEFT JOIN (SELECT fkProjeto, COUNT(cu.fkProjeto) AS totalCurtidas 
		   FROM curtida cu
		   GROUP BY fkProjeto)
           AS curtidas ON curtidas.fkProjeto = p.id
LEFT JOIN (SELECT fkProjeto, COUNT(c.fkProjeto) AS totalComentarios 
		   FROM comentario c
		   GROUP BY fkProjeto) 
           AS comentarios ON comentarios.fkProjeto = p.id
WHERE p.fkUsuario = 5
ORDER BY p.id;