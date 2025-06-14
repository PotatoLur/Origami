var database = require("../database/config")

function listar() {
    var instrucao = `
        SELECT 
            p.id AS id,
            u.nome AS autor,
            p.tipo AS tipo,
            p.nome AS nome,
            (SELECT COUNT(*) FROM curtida WHERE fkProjeto = p.id) AS curtida,
            c.comentario AS comentario,
            cu.nome AS comentUsu
        FROM projeto p
        INNER JOIN usuario u ON u.id = p.fkUsuario
        LEFT JOIN comentario c ON c.fkProjeto = p.id
        LEFT JOIN usuario cu ON cu.id = c.fkUsuario
        ORDER BY p.id;`;
    return database.executar(instrucao);
}

function adicionar(fkUsuario, fkProjeto) {
    var instrucao = `
        INSERT INTO curtida (fkUsuario, fkProjeto) VALUES 
        (${fkUsuario}, ${fkProjeto});`;
    return database.executar(instrucao);
}

function remover(fkUsuario, fkProjeto) {
    var instrucao = `
        DELETE FROM curtida 
        WHERE fkUsuario = ${fkUsuario} 
        AND fkProjeto = ${fkProjeto};`;
    return database.executar(instrucao);
}

function verificar(fkUsuario, fkProjeto) {
    var instrucao = `
        SELECT COUNT(*) AS naoCurtiu
        FROM curtida 
        WHERE fkUsuario = ${fkUsuario} 
        AND fkProjeto = ${fkProjeto};`;
    return database.executar(instrucao);
}

function comentar(fkUsuario, fkProjeto, comentario) {
    var instrucao = `
        INSERT INTO comentario (fkUsuario, fkProjeto, comentario) VALUES 
        (${fkUsuario}, ${fkProjeto}, '${comentario}');`;
    return database.executar(instrucao);
}

function enviar(usuario) {
  const instrucao = `INSERT INTO projeto (fkUsuario, nome, tipo) values (${usuario.id}, '${usuario.nome}', '${usuario.tipo}')`;

  return database.executar(instrucao);
}

module.exports = {
    listar,
    adicionar,
    remover,
    verificar,
    comentar,
    enviar
};