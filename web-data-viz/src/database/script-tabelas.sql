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
    nome VARCHAR (45),
    tipo VARCHAR (45),
    curtida INT,
    PRIMARY KEY (id, fkUsuario),
    FOREIGN KEY (fkUsuario) REFERENCES usuario (id)
);

CREATE TABLE comentario (
	id INT NOT NULL,
    fkProjeto INT NOT NULL,
    fkUsuario INT NOT NULL,
    comentario VARCHAR (250),
    PRIMARY KEY (id, fkProjeto, fkUsuario),
    FOREIGN KEY (fkProjeto) REFERENCES projeto (id),
    FOREIGN KEY (fkUsuario) REFERENCES usuario (id)
);

INSERT INTO usuario (email, nome, senha) VALUES
	('joao@email.com', 'joaosilva', 'senha123@'),
	('maria@email.com', 'mariasantos', 'senha456@'),
	('pedro@email.com', 'pedroalves', 'senha789@'),
	('ana@email.com', 'anacarvalho', 'senha321@');

INSERT INTO projeto (id, fkUsuario, nome, tipo, curtida) VALUES
	(1, 1, 'Tsuru', 'Origami Tradicional', 15),
	(2, 2, 'Flor de Lótus', 'Origami Modular', 25),
	(3, 3, 'Cisne', 'Origami 3D', 30),
	(4, 4, 'Estrela Ninja', 'Origami Modular', 12),
	(5, 1, 'Borboleta', 'Origami Tradicional', 20);

INSERT INTO comentario (id, fkProjeto, fkUsuario, comentario) VALUES
	(1, 1, 2, 'Muito bonito seu tsuru!'),
	(2, 2, 1, 'Adorei sua flor de lótus!'),
	(3, 3, 4, 'Esse cisne ficou incrível!'),
	(4, 4, 3, 'Estrela muito bem feita!'),
	(5, 5, 2, 'Linda borboleta!'),
	(6, 1, 3, 'O papel usado ficou ótimo!'),
	(7, 3, 1, 'Nunca vi um cisne tão detalhado!'),
	(8, 2, 4, 'Parabéns pelo trabalho!');

SELECT * FROM projeto;
SELECT * FROM usuario;