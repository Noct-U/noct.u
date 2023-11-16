var database = require("../database/config")

function cadastrar(numSerie, fkEmpresa, fkModelo) {
    console.log("ACESSEI A EMPRESA MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function cadastrar():");

    var instrucao = `
        INSERT INTO computador(numeroSerie,fkEmpresa,fkModeloComputador) VALUES 
            ('${numSerie}','${fkEmpresa}','${fkModelo}');
    `;
    console.log("Executando a instrução SQL: \n" + instrucao);
    return database.executar(instrucao);
}

function cadastrarModelo(modelo) {
    console.log("ACESSEI A EMPRESA MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function cadastrar():");

    var instrucao = `
        INSERT INTO modeloComputador(nome) VALUES 
            ('${modelo}');
    `;
    console.log("Executando a instrução SQL: \n" + instrucao);
    return database.executar(instrucao);
}

function excluirComputador(idComputador) {
    var instrucao = `
    UPDATE computador SET ativo = false WHERE idComputador = ${idComputador};
    `;
    console.log("Executando a instrução SQL: \n" + instrucao);
    return database.executar(instrucao);
}

function consultarUltimoModelo() {
    console.log("ACESSEI A EMPRESA MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function cadastrar():");

    var instrucao = `
        SELECT * FROM modeloComputador 
            ORDER BY idModeloComputador DESC LIMIT 1;
    `;
    console.log("Executando a instrução SQL: \n" + instrucao);
    return database.executar(instrucao);
}

function consultarComputadores(idEmpresa,idLocataria) {

    var instrucao = `
    select modeloComputador.nome as modelo, idComputador as computador,idStatus as idStatusUsuario, status.titulo as nomeStatusUsuario, idEmpresaLocataria,empresaLocataria.nome as locataria
    from modeloComputador JOIN computador on idModeloComputador = fkModeloComputador 
    JOIN status ON idStatus = fkStatus
    JOIN empresaLocataria ON idEmpresaLocataria = fkEmpresaLocataria
    where computador.fkEmpresa = ${idEmpresa} AND fkEmpresaLocataria =  ${idLocataria};
    `;
    console.log("Executando a instrução SQL: \n" + instrucao);
    return database.executar(instrucao);
}


function consultarDisco(idComputador,idHardware) {

    var instrucao = `
    SELECT capacidade, valor FROM captura JOIN componente ON fkComponente = idComponente 
    JOIN hardware ON hardware.idHardware = componente.fkHardware WHERE captura.fkComputador = ${idComputador} AND captura.fkHardware = ${idHardware}
    ORDER BY idCaptura DESC LIMIT 1;
    `;
    console.log("Executando a instrução SQL: \n" + instrucao);
    return database.executar(instrucao);
}
module.exports = {
    cadastrar,
    cadastrarModelo,
    consultarUltimoModelo,
    consultarComputadores,
    excluirComputador,
    consultarDisco
};