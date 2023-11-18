var computadorModel = require("../models/computadorModel");
// var aquarioModel = require("../models/aquarioModel");

function cadastrar(req, res) {
    // Crie uma variável que vá recuperar os valores do arquivo cadastro.html
    var numSerie = req.body.numSerieServer;
    var fkModelo = req.body.fkModeloServer;
    var fkEmpresa = req.body.fkEmpresaServer;
    computadorModel.cadastrar(numSerie,fkEmpresa,fkModelo)
    // empresaModel.cadastrarLocal(numero,complemento)
        .then(
            function (resultado) {
                res.json(resultado);
            }
        ).catch(
            function (erro) {
                console.log(erro);
                console.log(
                    "\nHouve um erro ao realizar o cadastro! Erro: ",
                    erro.sqlMessage
                );
                res.status(500).json(erro.sqlMessage);
            }
        );
}



function cadastrarModelo(req, res) {
    // Crie uma variável que vá recuperar os valores do arquivo cadastro.html
    var modelo = req.body.modeloServer;
    computadorModel.cadastrarModelo(modelo)
        .then(
            function (resultado) {
                res.json(resultado);
            }
        ).catch(
            function (erro) {
                console.log(erro);
                console.log(
                    "\nHouve um erro ao realizar o cadastro! Erro: ",
                    erro.sqlMessage
                );
                res.status(500).json(erro.sqlMessage);
            }
        );
}



function consultarUltimoModelo(req, res) {
    // Crie uma variável que vá recuperar os valores do arquivo cadastro.html
    computadorModel.consultarUltimoModelo()
        .then(
            function (ultimoModelo) {
                res.json(ultimoModelo);
            }
        ).catch(
            function (erro) {
                console.log(erro);
                console.log(
                    "\nHouve um erro ao realizar o cadastro! Erro: ",
                    erro.sqlMessage
                );
                res.status(500).json(erro.sqlMessage);
            }
        );
}

function consultarComputadores(req, res) {
    // Crie uma variável que vá recuperar os valores do arquivo cadastro.html

    var idEmpresa = req.body.idEmpresaServer;
    var idLocataria = req.body.idLocatariaServer;
    computadorModel.consultarComputadores(idEmpresa,idLocataria)
        .then(
            function (resultado) {
                res.json(resultado);
            }
        ).catch(
            function (erro) {
                console.log(erro);
                console.log(
                    "\nHouve um erro ao realizar o cadastro! Erro: ",
                    erro.sqlMessage
                );
                res.status(500).json(erro.sqlMessage);
            }
        );
}


function excluirComputador(req, res) {
    // Crie uma variável que vá recuperar os valores do arquivo cadastro.html

    var idComputador = req.body.idComputadorServer;
    computadorModel.excluirComputador(idComputador)
        .then(
            function (resultado) {
                res.json(resultado);
            }
        ).catch(
            function (erro) {
                console.log(erro);
                console.log(
                    "\nHouve um erro ao realizar o cadastro! Erro: ",
                    erro.sqlMessage
                );
                res.status(500).json(erro.sqlMessage);
            }
        );
}

function consultarDadosGrafico(req, res) {
    // Crie uma variável que vá recuperar os valores do arquivo cadastro.html

    var idHardware = req.body.idHardwareServer;
    var idComputador = req.body.idComputadorServer;
    computadorModel.consultarDadosGrafico(idComputador,idHardware)
        .then(
            function (ultimaCaptura) {
                res.json(ultimaCaptura);
            }
        ).catch(
            function (erro) {
                console.log(erro);
                console.log(
                    "\nHouve um erro ao realizar o cadastro! Erro: ",
                    erro.sqlMessage
                );
                res.status(500).json(erro.sqlMessage);
            }
        );
}

function consultarDadosGraficoCpu(req, res) {
    // Crie uma variável que vá recuperar os valores do arquivo cadastro.html

    var idHardware = req.body.idHardwareServer;
    var idComputador = req.body.idComputadorServer;
    computadorModel.consultarDadosGraficoCpu(idComputador,idHardware)
        .then(
            function (ultimaCaptura) {
                res.json(ultimaCaptura);
            }
        ).catch(
            function (erro) {
                console.log(erro);
                console.log(
                    "\nHouve um erro ao realizar o cadastro! Erro: ",
                    erro.sqlMessage
                );
                res.status(500).json(erro.sqlMessage);
            }
        );
}

function consultarModelos(req, res) {
    computadorModel.consultarModelos()
        .then(
            function (resposta) {
                res.json(resposta);
            }
        ).catch(
            function (erro) {
                console.log(erro);
                console.log(
                    "\nHouve um erro ao realizar o cadastro! Erro: ",
                    erro.sqlMessage
                );
                res.status(500).json(erro.sqlMessage);
            }
        );
}



function consultarTipoHardwares(req, res) {
    computadorModel.consultarTipoHardwares()
        .then(
            function (resposta) {
                res.json(resposta);
            }
        ).catch(
            function (erro) {
                console.log(erro);
                console.log(
                    "\nHouve um erro ao realizar o cadastro! Erro: ",
                    erro.sqlMessage
                );
                res.status(500).json(erro.sqlMessage);
            }
        );
}

module.exports = {
    cadastrar,
    cadastrarModelo,
    consultarUltimoModelo,
    consultarComputadores,
    excluirComputador,
    consultarDadosGrafico,
    consultarDadosGraficoCpu,
    consultarModelos,
    consultarTipoHardwares
}