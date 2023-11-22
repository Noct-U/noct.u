CREATE USER 'aluno'@'172.17.0.1' IDENTIFIED BY 'aluno';
GRANT ALL PRIVILEGES ON *.* TO 'aluno'@'172.17.0.1' WITH GRANT OPTION;

FLUSH PRIVILEGES;

USE noctu;

CREATE TABLE empresa(
	idEmpresa INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45) NOT NULL,
    razaoSocial VARCHAR(100) NOT NULL,
    cnpj CHAR(14) NOT NULL UNIQUE,
    telefoneFixo CHAR(12) NOT NULL
);

CREATE TABLE endereco(
	idEndereco INT PRIMARY KEY AUTO_INCREMENT,
	cep CHAR(8) NOT NULL,
    cidade VARCHAR(45) NOT NULL,
    bairro VARCHAR(45) NOT NULL,
    uf CHAR(2) NOT NULL,
    logradouro VARCHAR(45) NOT NULL
);

CREATE TABLE local(
	idLocal INT AUTO_INCREMENT,
    numero INT NOT NULL,
    complemento VARCHAR(45),
    fkEndereco INT NOT NULL,
    fkEmpresa INT NOT NULL,
    FOREIGN KEY (fkEndereco) REFERENCES endereco(idEndereco),
    FOREIGN KEY (fkEmpresa) REFERENCES empresa(idEmpresa),
    PRIMARY KEY (idLocal, fkEndereco, fkEmpresa)
);

CREATE TABLE status(
	idStatus INT PRIMARY KEY AUTO_INCREMENT,
    titulo VARCHAR(45)
);

CREATE TABLE empresaLocataria (
	idEmpresaLocataria INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45) NOT NULL,
    cnpj CHAR(14),
    fkMatriz INT,
    fkEmpresa INT,
    fkStatus INT,
    FOREIGN KEY (fkMatriz) REFERENCES empresaLocataria(idEmpresaLocataria),
    FOREIGN KEY (fkEmpresa) REFERENCES empresa(idEmpresa),
    FOREIGN KEY (fkStatus) REFERENCES status(idStatus)
);
    
CREATE TABLE tipoUsuario(
	idTipoUsuario INT PRIMARY KEY AUTO_INCREMENT,
    nomeTipo VARCHAR(45) NOT NULL
);
    
CREATE TABLE usuario(
	idUsuario INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45) NOT NULL,
	email VARCHAR(45) NOT NULL,
    senha VARCHAR(45) NOT NULL,
    fkTipoUsuario INT,
    fkEmpresaLocadora INT,
    fkEmpresa INT,
    fkStatus INT,
    FOREIGN KEY (fkTipoUsuario) REFERENCES tipoUsuario(idTipoUsuario),
    FOREIGN KEY (fkEmpresaLocadora) REFERENCES empresaLocataria(idEmpresaLocataria) ON DELETE CASCADE ON UPDATE CASCADE, 
    FOREIGN KEY (fkEmpresa) REFERENCES empresa(idEmpresa),
    FOREIGN KEY (fkStatus) REFERENCES status(idStatus)
); 

CREATE TABLE modeloComputador(
	idModeloComputador INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45)
);
 
CREATE TABLE computador(
	idComputador INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL UNIQUE,
    fkEmpresa INT,
    fkModeloComputador INT,
    fkEmpresaLocataria INT,
    fkStatus INT,
    FOREIGN KEY (fkEmpresa) REFERENCES empresa(idEmpresa),
    FOREIGN KEY (fkModeloComputador) REFERENCES modeloComputador(idModeloComputador), 
    FOREIGN KEY (fkEmpresaLocataria) REFERENCES empresaLocataria(idEmpresaLocataria) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (fkStatus) REFERENCES status(idStatus)
);

CREATE TABLE unidadeMedida(
	idUnidadeMedida INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45),
	simbolo VARCHAR(3)
);

CREATE TABLE tipoHardware(
	idTipoHardware INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45) NOT NULL,
    fkUnidademedida INT,
    FOREIGN KEY (fkUnidadeMedida) REFERENCES unidadeMedida(idUnidadeMedida)
);

CREATE TABLE hardware(
	idHardware INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    especificidade VARCHAR(45),
    capacidade DOUBLE NOT NULL,
	fkTipoHardware INT,
    FOREIGN KEY (fkTipoHardware) REFERENCES tipoHardware(idTipoHardware)
);

-- JAR pega

CREATE TABLE parametro(
	idParametro INT PRIMARY KEY AUTO_INCREMENT,
    min DOUBLE,
    max DOUBLE,
    fkUnidadeMedida INT,
    fkTipoHardware INT,
    fkModeloComputador INT,
    FOREIGN KEY (fkUnidadeMedida) REFERENCES unidadeMedida(idUnidadeMedida),
    FOREIGN KEY (fkTipoHardware) REFERENCES tipoHardware(idTipoHardware),
    FOREIGN KEY (fkModeloComputador) REFERENCES modeloComputador(idModeloComputador)
);

CREATE TABLE componente(
	idComponente INT AUTO_INCREMENT NOT NULL,
    fkComputador INT NOT NULL,
    fkHardware INT NOT NULL,
    FOREIGN KEY (fkHardware) REFERENCES hardware(idHardware),
    FOREIGN KEY (fkComputador) REFERENCES computador(idComputador) ON DELETE CASCADE ON UPDATE CASCADE,
    PRIMARY KEY (idComponente, fkHardware, fkComputador)
); 


-- JAR pega

CREATE TABLE captura (
	idCaptura INT PRIMARY KEY AUTO_INCREMENT,
    valor DOUBLE,
    descricao VARCHAR(45),
    dtCaptura DATETIME DEFAULT CURRENT_TIMESTAMP,
    fkComputador INT,
    fkHardware INT,
    fkComponente INT,
    FOREIGN KEY (fkComputador) REFERENCES componente(fkComputador) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (fkHardware) REFERENCES componente(fkHardware), 
    FOREIGN KEY (fkComponente) REFERENCES componente(idComponente) ON DELETE CASCADE ON UPDATE CASCADE
);

-- JAR pega

CREATE TABLE tipoAlerta(
	idTipoAlerta INT PRIMARY KEY AUTO_INCREMENT,
    descricao VARCHAR(45)
);

CREATE TABLE alerta(
	idAlerta INT PRIMARY KEY AUTO_INCREMENT,
    titulo VARCHAR(100),
    dtAlerta DATETIME DEFAULT CURRENT_TIMESTAMP,
    fkCaptura INT,
    fkTipoAlerta INT,
    FOREIGN KEY (fkCaptura) REFERENCES captura(idCaptura),
    FOREIGN KEY (fkTipoAlerta) REFERENCES tipoAlerta(idTipoAlerta)
);

<<<<<<< HEAD
use noctu;

INSERT INTO empresa(nome, razaoSocial, cnpj, telefoneFixo) VALUES
	('Simpress', 'Ltda', '12356789019183', '119333576377'), -- TIRAR DEPOIS
	('PressSim', 'Ltda', '12356789019283', '119333576377'); -- TIRAR DEPOIS
    
INSERT INTO endereco (cep, uf, cidade, bairro, logradouro) VALUES
	('08474230', 'SP', 'São Paulo', 'Paulista', 'Rua Haddock Lobo'); -- TIRAR DEPOIS
    
INSERT INTO local (numero, fkEndereco, fkEmpresa) VALUES
	(211, 1, 1); -- TIRAR DEPOIS
    
INSERT INTO status (titulo) VALUES
	('Ativo'),
	('Inativo');

INSERT INTO empresaLocataria (nome, cnpj, fkEmpresa) VALUES
	('SPTech', '10293029381203', 1), -- TIRAR DEPOIS
	('LiminhaTech', '31242131231', 2); -- TIRAR DEPOIS
=======
INSERT INTO status VALUES
	(null, 'ATIVO'),
	(null, 'INATIVO');
>>>>>>> 4925269cd33207c1784edee6daf921dbbc009543

INSERT INTO tipoUsuario (nomeTipo) VALUES
	('ADMIN'),
	('COMUM');


INSERT INTO modeloComputador VALUES
	(null, 'Padrão');

INSERT INTO tipoHardware VALUES	
	(NULL, 'CPU', 1),
	(NULL, 'RAM', 2),
	(NULL, 'DISCO', 2),
	(NULL, 'JANELA', 3);

INSERT INTO empresa(nome, razaoSocial, cnpj, telefoneFixo) VALUES
	('Simpress', 'Ltda', '92183', '119333576377');
    
INSERT INTO empresaLocataria (nome, cnpj, fkEmpresa, fkStatus, fkMatriz) VALUES
  ('SPTech', '10293029381203', 1, 1, null),
	('LUAN', '1231242141', 1, 1, 1);

INSERT INTO usuario values
 (null, 'mc lovin', 'mclovin@email.com', '123', 1, null, 1, 1),
 (null, 'kevin', 'kevin@email.com', '123', 2, null, 1, 1);

INSERT INTO parametro (min, max, fkUnidadeMedida, fkTipoHardware, fkModeloComputador) values
	(40, 60, 1, 1, 1),	
    (60, 80, 1, 2, 1),
	(20, 70, 1, 3, 1),
	(50, 100, 3, 4, 1);

INSERT INTO tipoAlerta (descricao) values
	('ATENÇÃO'),	
    ('URGENTE');
    
 -- MYSQL-API
 
 -- UPDATE computador SET fkStatus = 2 WHERE idComputador = '';
 -- exibir computadores
select modeloComputador.nome as modelo, idComputador as computador, empresaLocataria.nome as locataria, computador.fkStatus
    from modeloComputador JOIN computador on idModeloComputador = fkModeloComputador 
    JOIN empresaLocataria ON idEmpresaLocataria = fkEmpresaLocataria WHERE computador.fkStatus = 1 AND
    computador.fkEmpresa = 1 AND fkEmpresaLocataria = 1;
    
-- exibirEmpresas
/*SELECT empresaLocataria.*,empresa.idEmpresa,empresa.nome AS nomeEmpresaOutsorcing FROM empresaLocataria 
        JOIN empresa ON empresa.idEmpresa = empresaLocataria.fkEmpresa 
            WHERE fkEmpresa = 1 AND fkStatus = 1;*/

SELECT * FROM empresaLocataria WHERE fkStatus = 1;

select modeloComputador.idModeloComputador AS idModelo,modeloComputador.nome as modelo, idComputador as computador,idStatus as idStatusComputador, status.titulo as nomeStatusUsuario, idEmpresaLocataria,empresaLocataria.nome as locataria
    from modeloComputador JOIN computador on idModeloComputador = fkModeloComputador 
    JOIN status ON idStatus = fkStatus
    JOIN empresaLocataria ON idEmpresaLocataria = fkEmpresaLocataria
    where computador.fkEmpresa = 1 AND fkEmpresaLocataria =  1 AND computador.fkStatus = 1;

SELECT * FROM empresa;    
/*SELECT *, ROW_NUMBER() OVER (ORDER BY nome) AS ordem
FROM empresa ORDER BY ordem DESC LIMIT 1;*/


SELECT COUNT(*) AS Alertas, idComputador, computador.nome, empresaLocataria.nome FROM computador 
	JOIN componente ON fkComputador = idComputador
    JOIN empresaLocataria ON fkEmpresaLocataria = idEmpresaLocataria
    JOIN captura ON fkComponente = idComponente
    JOIN alerta ON fkCaptura = idCaptura
    JOIN tipoAlerta ON fkTipoAlerta = idTipoAlerta WHERE DATEDIFF(NOW(), dtAlerta) < 7 AND computador.fkStatus = 1 GROUP BY idComputador ORDER BY alertas DESC;    

SELECT COUNT(*) AS Alertas, idEmpresaLocataria FROM computador 
	JOIN componente ON fkComputador = idComputador
    JOIN empresaLocataria ON fkEmpresaLocataria = idEmpresaLocataria
    JOIN captura ON fkComponente = idComponente
    JOIN alerta ON fkCaptura = idCaptura
    JOIN tipoAlerta ON fkTipoAlerta = idTipoAlerta WHERE DATEDIFF(NOW(), dtAlerta) < 7 AND computador.fkStatus = 1 GROUP BY idEmpresaLocataria ORDER BY alertas DESC;    
