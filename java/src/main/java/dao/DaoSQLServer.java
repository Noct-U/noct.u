package dao;

import aplicacao.*;
import jdbc.ConexaoSQLServer;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import usuario.Funcionario;

import java.util.List;

public class DaoSQLServer {
    ConexaoSQLServer conexao = new ConexaoSQLServer();
    JdbcTemplate con = conexao.getConexaoDoBanco();

    public DaoSQLServer() {
        this.conexao = conexao;
        this.con = con;
    }

    // FUNÇÕES DE ADICIONAR REGISTROS (INSERT)
    public void adicionarComputador(Computador computador) {
        con.update("INSERT INTO computador (nome, fkEmpresa, fkModeloComputador, fkEmpresaLocataria, fkStatus) VALUES (?, ?, ?, ?, ?)", computador.getNome(), computador.getFkEmpresa(), computador.getFkModeloComputador(), computador.getFkEmpresaLocataria(), computador.getFkStatus());
    }

    public void adicionarComponente(Componente componente) {
        con.update("INSERT INTO componente (fkComputador, fkHardware) VALUES (?, ?)", componente.getFkComputador(), componente.getFkHardware());
    }

    public void adicionarHardwareSemEspecificidade(Hardware hardware) {
        con.update("INSERT INTO hardware (nome, capacidade, fkTipoHardware) VALUES (?, ?, ?)", hardware.getNome(), hardware.getCapacidade(), hardware.getFkTipoHardware());
    }

    public void adicionarCaptura(Captura captura) {
        con.update("INSERT INTO captura (valor, fkComputador, fkHardware, fkComponente) VALUES (?, ?, ?, ?)", captura.getValor(), captura.getFkComputador(), captura.getFkHardware(), captura.getFkComponente());
    }

    public void adicionarAlerta(Alerta alerta) {
        con.update("INSERT INTO alerta (titulo, fkCaptura, fkTipoAlerta) VALUES (?, ?, ?)", alerta.getTitulo(), alerta.getFkCaptura(), alerta.getFkTipoAlerta());
    }

    public List<Funcionario> exibirUsuario(String email) {
        // SEMPRE FAZER ESSE BLOCO DE CODIGO PARA PRINTAR NA TELA E GUARDAR NO VETOR "personagensDoBanco"
        List<Funcionario> funcionarioDoBanco = con.query("SELECT nome, email, senha, fkTipoUsuario, fkEmpresaLocadora, fkEmpresa, fkStatus from usuario WHERE email = ?", new BeanPropertyRowMapper<>(Funcionario.class), email);
        return funcionarioDoBanco;
    }

    public Computador exibirComputadorAtual(String nome) {
        // ISSO AQUI BUSCA 1 ELEMENTO (COM PERSONALIZAÇÃO)
        Computador computadorDoBanco = con.queryForObject("SELECT nome, fkEmpresa, fkModeloComputador, fkEmpresaLocataria, fkStatus FROM computador WHERE nome = ?", new BeanPropertyRowMapper<>(Computador.class), nome);
        return computadorDoBanco;
    }

    public List<EmpresaLocataria> exibirEmpresasLocatarias(Integer fkEmpresa) {
        // SEMPRE FAZER ESSE BLOCO DE CODIGO PARA PRINTAR NA TELA E GUARDAR NO VETOR "personagensDoBanco"
        List<EmpresaLocataria> empresasLocatariasDoBanco = con.query("SELECT nome, fkMatriz, fkEmpresa, fkStatus FROM empresaLocataria WHERE fkEmpresa = ? AND fkStatus = 1", new BeanPropertyRowMapper<>(EmpresaLocataria.class), fkEmpresa);
        return empresasLocatariasDoBanco;
    }

    public EmpresaLocataria exibirEmpresasLocatariasMatriz(Integer idEmpresaLocataria) {
        // SEMPRE FAZER ESSE BLOCO DE CODIGO PARA PRINTAR NA TELA E GUARDAR NO VETOR "personagensDoBanco"
        EmpresaLocataria empresasLocatariasMatrizDoBanco = con.queryForObject("SELECT matriz.nome, matriz.fkMatriz, matriz.fkEmpresa, matriz.fkStatus FROM empresaLocataria AS emp JOIN empresaLocataria AS matriz ON matriz.idEmpresaLocataria = emp.fkMatriz WHERE emp.idEmpresaLocataria = ?", new BeanPropertyRowMapper<>(EmpresaLocataria.class), idEmpresaLocataria);
        return empresasLocatariasMatrizDoBanco;
    }

    public List<Captura> exibirCapturasDeUmTipo(Integer tipo) {
        // SEMPRE FAZER ESSE BLOCO DE CODIGO PARA PRINTAR NA TELA E GUARDAR NO VETOR "personagensDoBanco"
        List<Captura> capturasDoBanco = con.query("SELECT valor, dtCaptura, fkTipoHardware FROM captura AS cpt JOIN componente AS cmp ON idComponente = fkComponente JOIN Hardware AS hdw ON hdw.idHardware = cmp.fkHardware WHERE hdw.fkTipoHardware = ? ORDER BY dtCaptura DESC LIMIT 10", new BeanPropertyRowMapper<>(Captura.class), tipo);
        return capturasDoBanco;
    }

    public List<Parametro> exibirParametrosDoModeloComputador(Integer fkModeloComputador) {
        // SEMPRE FAZER ESSE BLOCO DE CODIGO PARA PRINTAR NA TELA E GUARDAR NO VETOR "personagensDoBanco"
        List<Parametro> parametrosDoBanco = con.query("SELECT min, max, fkUnidadeMedida, fkTipoHardware, fkModeloComputador FROM parametro WHERE fkModeloComputador = ?", new BeanPropertyRowMapper<>(Parametro.class), fkModeloComputador);
        return parametrosDoBanco;
    }

    public List<Computador> exibirIdComputadorPeloNomeComputador(String nome) {
        // SEMPRE FAZER ESSE BLOCO DE CODIGO PARA PRINTAR NA TELA E GUARDAR NO VETOR "personagensDoBanco"
        List<Computador> computadorDoBanco = con.query("SELECT IdComputador FROM computador WHERE nome = ?", new BeanPropertyRowMapper<>(Computador.class), nome);
        return computadorDoBanco;
    }

    public List<Hardware> exibirIdHardwarePeloNomeHardware(String nome) {
        // SEMPRE FAZER ESSE BLOCO DE CODIGO PARA PRINTAR NA TELA E GUARDAR NO VETOR "personagensDoBanco"
        List<Hardware> hardwareDoBanco = con.query("SELECT idHardware FROM hardware WHERE nome = ? ORDER BY idHardware DESC", new BeanPropertyRowMapper<>(Hardware.class), nome);
        return hardwareDoBanco;
    }

    public List<Componente> exibirIdComponentePeloIdComputadorEIdHardware(Integer fkComputador, Integer fkHardware) {
        // SEMPRE FAZER ESSE BLOCO DE CODIGO PARA PRINTAR NA TELA E GUARDAR NO VETOR "personagensDoBanco"
        List<Componente> componentesDoBanco = con.query("SELECT idComponente FROM componente WHERE fkComputador = ? AND fkHardware = ?", new BeanPropertyRowMapper<>(Componente.class), fkComputador, fkHardware);
        return componentesDoBanco;
    }

    public List<Computador> exibirComputadorCadastrado(String nome) {
        // SEMPRE FAZER ESSE BLOCO DE CODIGO PARA PRINTAR NA TELA E GUARDAR NO VETOR "personagensDoBanco"
        List<Computador> computadorDoBanco = con.query("SELECT nome, fkEmpresa, fkModeloComputador, fkEmpresaLocataria, fkStatus FROM computador WHERE nome = ?", new BeanPropertyRowMapper<>(Computador.class), nome);
        return computadorDoBanco;
    }

    // ATUALZAR REGISTROS (UPDATE)
    public void atualizarComputador(Integer opcao) {
        con.update("UPDATE computador SET fkStatus = ? WHERE idComputador = 1", opcao);
    }
}
