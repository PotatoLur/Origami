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

function adicionar(req, res) {
    comunidadeModel.adicionar(req.body.usuarioId, req.body.postId)
        .then(resposta => {
            res.status(200).json({ success: true });
        })
        .catch(erro => res.status(500).json(erro));
}

function remover(req, res) {
    comunidadeModel.remover(req.body.usuarioId, req.body.postId)
        .then(resposta => res.status(200).json(resposta))
        .catch(erro => res.status(500).json(erro));
}

function verificar(req, res) {
    comunidadeModel.verificar(req.params.usuarioId, req.params.postId)
        .then(resposta => res.status(200).json(resposta[0]))
        .catch(erro => res.status(500).json(erro));
}

function comentar(req, res) {
    comunidadeModel.comentar(
        req.body.usuarioId, 
        req.body.postId,
        req.body.comentario
    ).then(resposta => res.status(200).json(resposta))
     .catch(erro => res.status(500).json(erro));
}


function enviar(req, res) {
  const imagem = req.file.filename;

  const {nome, tipo, id} = req.body

  const usuario = { nome, tipo, id, imagem }
  
  comunidadeModel.enviar(usuario)
  .then(resultado => {
    res.status(201).send("Post enviado com sucesso");
  }).catch(err => {
    res.status(500).send(err);
  });
}

module.exports = {
    listar,
    adicionar,
    remover,
    verificar,
    comentar,
    enviar
}