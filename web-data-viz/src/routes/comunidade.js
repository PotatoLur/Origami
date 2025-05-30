const express = require("express");
const router = express.Router();

const comunidadeController = require("../controllers/comunidadeController");

router.get("/listar", comunidadeController.listar);

router.post("/adicionar", comunidadeController.adicionar);

router.post("/remover", comunidadeController.remover);

router.get("/verificar/:usuarioId/:postId", comunidadeController.verificar);

router.post("/comentar", comunidadeController.comentar);

module.exports = router;