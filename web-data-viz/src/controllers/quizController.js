var quizModel = require("../models/quizModel");

function cadastrar(req, res) {
    var pontuacao = req.body.pontuacao;
    var avaliacao = req.body.avaliacao;
    var userName = req.body.userName;

    if (pontuacao === undefined || avaliacao === undefined || userName === undefined) {
        return res.status(400).json({ error: "Dados incompletos" });
    }

    quizModel.cadastrar(pontuacao, avaliacao, userName)
        .then(
            function (resposta) {
                res.status(200).send(resposta);
            })
        .catch(function (erro) {
            res.status(500).json(erro.sqlMessage);
        })
}

function listarBarra(req, res) {
    var userName = req.params.nomeUsuario;

    quizModel.listarBarra(userName)
        .then(function (resultado) {
            res.status(200).json(resultado);
        }).catch(function (erro) {
            res.status(500).json(erro.sqlMessage);
        })
}

function listarPizza(req, res) {
    var userName = req.params.nomeUsuario;

    quizModel.listarPizza(userName)
        .then(function (resultado) {
            res.status(200).json(resultado);
        }).catch(function (erro) {
            res.status(500).json(erro.sqlMessage);
        })
}


module.exports = {
    listarBarra,
    listarPizza,
    cadastrar
}