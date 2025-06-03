const multer = require('multer');

// Diretório onde os arquivos serão salvos
// ATENÇÃO: É necessário manter o diretório 'public' para poder utilizar no front-end
const diretorio = 'public/img/';

const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, diretorio)
  },

  filename: (req, file, cb) => {
    cb(null, `${file.originalname}`)
  }
});

module.exports = multer({ storage });