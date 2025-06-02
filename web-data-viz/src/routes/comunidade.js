const express = require("express");
const router = express.Router();

const comunidadeController = require("../controllers/comunidadeController");

const upload = require('../config/configUpload');

router.get("/listar", comunidadeController.listar);

router.post("/adicionar", comunidadeController.adicionar);

router.post("/remover", comunidadeController.remover);

router.get("/verificar/:usuarioId/:postId", comunidadeController.verificar);

router.post("/comentar", comunidadeController.comentar);

router.post('/enviar', upload.single('foto'), (req, res) => {
  comunidadeController.enviar(req, res);
});

module.exports = router;