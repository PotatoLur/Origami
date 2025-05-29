const express = require("express");
const router = express.Router();

const comunidadeController = require("../controllers/comunidadeController");

// router.get("/listar", function (req, res) {
//     comunidadeController.listar(req, res);
// });

router.get("/listar", comunidadeController.listar);

module.exports = router;