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

module.exports = {
    cadastrar,
    listarBarra,
    listarPizza
};