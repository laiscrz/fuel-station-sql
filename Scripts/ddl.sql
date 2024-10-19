/*

Bianca Leticia Román Caldeira - RM552267 - Turma : 2TDSPH
Charlene Aparecida Estevam Mendes Fialho - RM552252 - Turma : 2TDSPH
Lais Alves Da Silva Cruz - RM:552258 - Turma : 2TDSPH

CP5 - Banco de Dados - Tema: Posto de Gasolina

*/

-- DDL 

/* DROP TABLES */
DROP TABLE bomba CASCADE CONSTRAINTS;
DROP TABLE combustivel CASCADE CONSTRAINTS;
DROP TABLE formapagamento CASCADE CONSTRAINTS;
DROP TABLE funcionario CASCADE CONSTRAINTS;
DROP TABLE nota_pagamento CASCADE CONSTRAINTS;
DROP TABLE notafiscal CASCADE CONSTRAINTS;
DROP TABLE posto CASCADE CONSTRAINTS;
DROP TABLE produto CASCADE CONSTRAINTS;
DROP TABLE servico CASCADE CONSTRAINTS;
DROP TABLE tanque CASCADE CONSTRAINTS;
DROP TABLE venda CASCADE CONSTRAINTS;

/* CREATES TABLES */
CREATE TABLE bomba (
    idbomba NUMBER(4) PRIMARY KEY,
    tipobomba VARCHAR2(50),
    statusbomba VARCHAR2(20),
    combustivel_idcombustivel NUMBER(4) NOT NULL,
    tanque_idtanque NUMBER(4) NOT NULL
);

CREATE TABLE combustivel (
    idcombustivel NUMBER(4) PRIMARY KEY,
    tipo VARCHAR2(100),
    precolitro NUMBER(8, 2)
);

CREATE TABLE formapagamento (
    idpagamento NUMBER(4) PRIMARY KEY,
    descricaotipo VARCHAR2(100),
    taxa NUMBER(8, 2)
);

CREATE TABLE funcionario (
    cpf VARCHAR2(12) PRIMARY KEY,
    nome VARCHAR2(100),
    telefone VARCHAR2(20),
    cargo VARCHAR2(80),
    posto_cnpj VARCHAR2(15) NOT NULL
);

CREATE TABLE nota_pagamento (
    formapagamento_idpagamento NUMBER(4) NOT NULL,
    notafiscal_idnota NUMBER(4) NOT NULL,
    PRIMARY KEY (formapagamento_idpagamento, notafiscal_idnota)
);

CREATE TABLE notafiscal (
    idnota NUMBER(4) PRIMARY KEY,
    dataemissao DATE,
    status VARCHAR2(20),
    venda_idvenda NUMBER(4) NOT NULL,
    valortotal NUMBER(10, 2)
);

CREATE TABLE posto (
    cnpj VARCHAR2(15) PRIMARY KEY,
    nome VARCHAR2(100),
    horario_funcionamento VARCHAR2(50),
    endereco VARCHAR2(150)
);

CREATE TABLE produto (
    idproduto NUMBER(4) PRIMARY KEY,
    nome VARCHAR2(50),
    preco NUMBER(8, 2)
);

CREATE TABLE servico (
    idservico NUMBER(4) PRIMARY KEY,
    nome VARCHAR2(100),
    preco NUMBER(8, 2),
    descricao VARCHAR2(150),
    produto_idproduto NUMBER(4) NOT NULL
);

CREATE TABLE tanque (
    idtanque NUMBER(4) PRIMARY KEY,
    capacidade NUMBER(10, 2),
    datainstalacao DATE
);

CREATE TABLE venda (
    idvenda NUMBER(4) PRIMARY KEY,
    datavenda DATE,
    quantidadelitro NUMBER(10, 2),
    posto_cnpj VARCHAR2(15) NOT NULL,
    servico_idservico NUMBER(4) NOT NULL,
    bomba_idbomba NUMBER(4) NOT NULL
);

-- Relacionamentos (Foreign Keys)
ALTER TABLE bomba
    ADD CONSTRAINT fk_bomba_combustivel FOREIGN KEY (combustivel_idcombustivel)
    REFERENCES combustivel (idcombustivel);

ALTER TABLE bomba
    ADD CONSTRAINT fk_bomba_tanque FOREIGN KEY (tanque_idtanque)
    REFERENCES tanque (idtanque);

ALTER TABLE funcionario
    ADD CONSTRAINT fk_funcionario_posto FOREIGN KEY (posto_cnpj)
    REFERENCES posto (cnpj);

ALTER TABLE nota_pagamento
    ADD CONSTRAINT fk_notapagamento_formapagamento FOREIGN KEY (formapagamento_idpagamento)
    REFERENCES formapagamento (idpagamento);

ALTER TABLE nota_pagamento
    ADD CONSTRAINT fk_notapagamento_notafiscal FOREIGN KEY (notafiscal_idnota)
    REFERENCES notafiscal (idnota);

ALTER TABLE notafiscal
    ADD CONSTRAINT fk_notafiscal_venda FOREIGN KEY (venda_idvenda)
    REFERENCES venda (idvenda);

ALTER TABLE servico
    ADD CONSTRAINT fk_servico_produto FOREIGN KEY (produto_idproduto)
    REFERENCES produto (idproduto);

ALTER TABLE venda
    ADD CONSTRAINT fk_venda_bomba FOREIGN KEY (bomba_idbomba)
    REFERENCES bomba (idbomba);

ALTER TABLE venda
    ADD CONSTRAINT fk_venda_posto FOREIGN KEY (posto_cnpj)
    REFERENCES posto (cnpj);

ALTER TABLE venda
    ADD CONSTRAINT fk_venda_servico FOREIGN KEY (servico_idservico)
    REFERENCES servico (idservico);

