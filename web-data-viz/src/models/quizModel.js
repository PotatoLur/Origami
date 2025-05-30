var database = require("../database/config")

function cadastrar(pontuacao, avaliacao, userName) {
    var instrucao = `
        INSERT INTO quiz (pontuacao, avaliacao, fkUsuario) VALUES 
        (${pontuacao}, 
        '${avaliacao}', 
        (SELECT id FROM usuario WHERE nome = '${userName}')
        );`;
    console.log("Executando a instrução SQL: \n" + instrucao);
    return database.executar(instrucao);
}

function listarBarra(userName) {
    var instrucao = `
        SELECT pontuacao
        FROM quiz
        WHERE fkUsuario = (SELECT id FROM usuario WHERE nome = '${userName}');`;
    console.log("Executando a instrução SQL: \n" + instrucao);
    return database.executar(instrucao);
}

function listarPizza(userName) {
    var instrucao = `
        SELECT tipo, COUNT(tipo) quantidade_projeto 
        FROM projeto p
        WHERE fkUsuario = (SELECT id FROM usuario WHERE nome = '${userName}')
        GROUP BY tipo;`;
    console.log("Executando a instrução SQL: \n" + instrucao);
    return database.executar(instrucao);
}

function listarTabela(userId) {
    var instrucao = `
        SELECT p.nome AS nome, 
               p.tipo AS tipo, 
               totalCurtidas AS curtida, 
               totalComentarios AS comentario
        FROM projeto p
        LEFT JOIN (SELECT fkProjeto, COUNT(cu.fkProjeto) AS totalCurtidas 
                   FROM curtida cu 
                   GROUP BY fkProjeto) AS curtidas ON curtidas.fkProjeto = p.id
        LEFT JOIN (SELECT fkProjeto, COUNT(c.fkProjeto) AS totalComentarios 
                   FROM comentario c 
                   GROUP BY fkProjeto) AS comentarios ON comentarios.fkProjeto = p.id
        WHERE p.fkUsuario = ${userId}
        ORDER BY p.id;`;
    console.log("Executando a instrução SQL: \n" + instrucao);
    return database.executar(instrucao);
}

module.exports = {
    cadastrar,
    listarBarra,
    listarPizza,
    listarTabela
};