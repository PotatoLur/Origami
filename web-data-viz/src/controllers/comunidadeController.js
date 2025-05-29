var comunidadeModel = require("../models/comunidadeModel");

function listar(req, res) {
    console.log('Controller')
    comunidadeModel.listar()
        .then(function (resposta) {
            console.log("Dados retornados do model:", resposta);
            res.status(200).json(resposta);
        }).catch(function (erro) {
            console.error("Erro no controller:", erro);
            res.status(500).json(erro.sqlMessage);
        })
}


module.exports = {
    listar
}