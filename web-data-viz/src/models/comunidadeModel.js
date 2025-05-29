var database = require("../database/config")

function listar() {
    var instrucao = `
        SELECT p.id AS id,
	           u.nome AS autor,
               p.tipo AS tipo,
               p.nome AS nome,
               comentario
        FROM projeto p
        INNER JOIN usuario u ON u.id = p.fkUsuario
        INNER JOIN comentario c ON c.fkProjeto = p.id
        ORDER BY p.id;`;
    console.log("Executando a instrução SQL: \n" + instrucao);
    return database.executar(instrucao);
}

module.exports = {
    listar
};