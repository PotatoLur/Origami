var express = require("express");
var router = express.Router();

var quizController = require("../controllers/quizController");

router.post("/cadastrar", function (req, res) {
    quizController.cadastrar(req, res);
});

router.get("/listarBarra/:nomeUsuario", function (req, res) {
    quizController.listarBarra(req, res);
});

router.get("/listarPizza/:nomeUsuario", function (req, res) {
    quizController.listarPizza(req, res);
});

router.get("/listarTabela/:userId", function (req, res) {
    quizController.listarTabela(req, res);
});

module.exports = router;