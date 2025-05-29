DROP DATABASE origami;
CREATE DATABASE origami;

USE origami;

CREATE TABLE usuario (
	id INT NOT NULL AUTO_INCREMENT,
    email VARCHAR (45),
    nome VARCHAR (45),
    senha VARCHAR (45),
    PRIMARY KEY (id)
);

CREATE TABLE projeto (
	id INT NOT NULL,
    fkUsuario INT NOT NULL,
    nome VARCHAR (100),
    tipo VARCHAR (20),
    curtida INT,
    PRIMARY KEY (id, fkUsuario),
    FOREIGN KEY (fkUsuario) REFERENCES usuario (id)
);

CREATE TABLE comentario (
	id INT NOT NULL,
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

INSERT INTO usuario (email, nome, senha) VALUES
	('joao@email.com', 'joaosilva', 'senha123@'),
	('maria@email.com', 'mariasantos', 'senha456@'),
	('pedro@email.com', 'pedroalves', 'senha789@'),
	('ana@email.com', 'anacarvalho', 'senha321@'),
    ('aoki@gmail.com', 'Aoki01', 'Aoki01@');
    
INSERT INTO projeto (id, fkUsuario, nome, tipo, curtida) VALUES
	(1, 5, '3D Swan', 'Origami 3D', 15),
	(2, 5, 'Polygonal Cubes and Stars', 'Origami Tradicional', 14),
	(3, 5, '3D Snake', 'Origami 3D', 30),
	(4, 5, 'DeBugger', 'Origami 3D', 22),
	(5, 5, 'Balão 3D', 'Origami 3D', 50),
    (6, 5, 'Herringbone Tesselation', 'Tesselation', 12),
	(7, 5, 'Balão tradicional', 'Origami Tradicional', 10),
    (8, 5, 'Joaninha 3D', 'Origami 3D', 20),
    (9, 5, 'Icosaedro', 'Origami Modular', 21);

INSERT INTO comentario (id, fkProjeto, fkUsuario, comentario) VALUES
	(1, 1, 2, 'Esse cisne ficou incrível!'),
	(2, 2, 3, 'Simples de aprender, parabéns.'),
	(3, 3, 4, 'Muito bom! Deve ter demorado dias.'),
	(4, 4, 1, 'Que fofinho!'),
	(5, 5, 2, 'Nossa. Eu quero um!'),
	(6, 6, 3, 'Muito interessante!'),
	(7, 7, 1, 'Vou tentar fazer.'),
	(8, 8, 4, 'Muito bem, ficou show com essas cores.');

INSERT INTO quiz (pontuacao, avaliacao, fkUsuario) VALUES
	(5, 'Bom', 1),
    (4, 'Mediano', 1),
    (5, 'Ótimo', 3),
    (3, 'Bom', 4),
    (1, 'Ruim', 5),
    (2, 'Mediano', 2),
    (3, 'Ótimo', 5),
    (4, 'Bom', 3);

SELECT * FROM projeto p
WHERE fkUsuario = (SELECT id FROM usuario WHERE nome = 'joaosilva');

SELECT tipo, COUNT(tipo) quantidade_projeto FROM projeto p
WHERE fkUsuario = (SELECT id FROM usuario WHERE nome = 'joaosilva')
GROUP BY tipo;

SELECT * FROM projeto p
INNER JOIN usuario u ON u.id = p.fkUsuario
INNER JOIN quiz q ON q.fkUsuario = u.id
WHERE u.id = (SELECT id FROM usuario WHERE nome = 'joaosilva');

SELECT * FROM usuario;

SELECT * FROM quiz q
INNER JOIN usuario u ON u.id = q.fkUsuario;

SELECT * FROM quiz;

SELECT pontuacao 
FROM quiz
WHERE fkUsuario = (SELECT id FROM usuario WHERE nome = 'Aoki01');

SELECT comentario, nome FROM comentario c
INNER JOIN usuario u ON u.id = c.fkUsuario;

SELECT p.id AS id,
	   u.nome AS autor,
       p.tipo AS tipo,
       p.nome AS nome,
       comentario,
       c.fkUsuario AS comentUsu
FROM projeto p
INNER JOIN usuario u ON u.id = p.fkUsuario
INNER JOIN comentario c ON c.fkProjeto = p.id
ORDER BY p.id;