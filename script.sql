/*

Bianca Leticia Román Caldeira - RM552267 - Turma : 2TDSPH
Charlene Aparecida Estevam Mendes Fialho - RM552252 - Turma : 2TDSPH
Lais Alves Da Silva Cruz - RM:552258 - Turma : 2TDSPH

CP5 - Banco de Dados - Tema: Posto de Gasolina

*/

-- DDL 

/* CREATES TABLES */
CREATE TABLE bomba (
    idbomba                   NUMBER(4) NOT NULL,
    tipobomba                 VARCHAR2(50),
    statusbomba               VARCHAR2(20),
    combustivel_idcombustivel NUMBER(4) NOT NULL,
    tanque_idtanque           NUMBER(4) NOT NULL
);

ALTER TABLE bomba ADD CONSTRAINT bomba_pk PRIMARY KEY ( idbomba );

CREATE TABLE combustivel (
    idcombustivel NUMBER(4) NOT NULL,
    tipo          VARCHAR2(100),
    precolitro    NUMBER(8, 2)
);

ALTER TABLE combustivel ADD CONSTRAINT combustivel_pk PRIMARY KEY ( idcombustivel );

CREATE TABLE formapagamento (
    idpagamento   NUMBER(4) NOT NULL,
    descricaotipo VARCHAR2(100),
    taxa          NUMBER(8, 2)
);

ALTER TABLE formapagamento ADD CONSTRAINT formapagamento_pk PRIMARY KEY ( idpagamento );

CREATE TABLE funcionario (
    cpf        VARCHAR2(12) NOT NULL,
    nome       VARCHAR2(100),
    telefone   VARCHAR2(20),
    cargo      VARCHAR2(80),
    posto_cnpj VARCHAR2(15) NOT NULL
);

ALTER TABLE funcionario ADD CONSTRAINT funcionario_pk PRIMARY KEY ( cpf );

CREATE TABLE nota_pagamento (
    formapagamento_idpagamento NUMBER(4) NOT NULL,
    notafiscal_idnota          NUMBER(4) NOT NULL
);

ALTER TABLE nota_pagamento ADD CONSTRAINT nota_pagamento_pk PRIMARY KEY ( formapagamento_idpagamento,
                                                                          notafiscal_idnota );

CREATE TABLE notafiscal (
    idnota        NUMBER(4) NOT NULL,
    dataemissao   DATE,
    status        VARCHAR2(20),
    venda_idvenda NUMBER(4) NOT NULL,
    valortotal    NUMBER(10, 2)
);

ALTER TABLE notafiscal ADD CONSTRAINT notafiscal_pk PRIMARY KEY ( idnota );

CREATE TABLE posto (
    cnpj                  VARCHAR2(15) NOT NULL,
    nome                  VARCHAR2(100),
    horario_funcionamento VARCHAR2(50),
    endereco              VARCHAR2(150)
);

ALTER TABLE posto ADD CONSTRAINT posto_pk PRIMARY KEY ( cnpj );

CREATE TABLE produto (
    idproduto NUMBER(4) NOT NULL,
    nome      VARCHAR2(50),
    preco     NUMBER(8, 2)
);

ALTER TABLE produto ADD CONSTRAINT produto_pk PRIMARY KEY ( idproduto );

CREATE TABLE servico (
    idservico         NUMBER(4) NOT NULL,
    nome              VARCHAR2(100),
    preco             NUMBER(8, 2),
    descricao         VARCHAR2(150),
    produto_idproduto NUMBER(4) NOT NULL
);

ALTER TABLE servico ADD CONSTRAINT servico_pk PRIMARY KEY ( idservico );

CREATE TABLE tanque (
    idtanque       NUMBER(4) NOT NULL,
    capacidade     NUMBER(10, 2),
    datainstalacao DATE
);

ALTER TABLE tanque ADD CONSTRAINT tanque_pk PRIMARY KEY ( idtanque );

CREATE TABLE venda (
    idvenda           NUMBER(4) NOT NULL,
    datavenda         DATE,
    quantidadelitro   NUMBER(10, 2),
    posto_cnpj        VARCHAR2(15) NOT NULL,
    servico_idservico NUMBER(4) NOT NULL,
    bomba_idbomba     NUMBER(4) NOT NULL
);

ALTER TABLE venda ADD CONSTRAINT venda_pk PRIMARY KEY ( idvenda );


/* FKS*/
ALTER TABLE bomba
    ADD CONSTRAINT bomba_combustivel_fk FOREIGN KEY ( combustivel_idcombustivel )
        REFERENCES combustivel ( idcombustivel );

ALTER TABLE bomba
    ADD CONSTRAINT bomba_tanque_fk FOREIGN KEY ( tanque_idtanque )
        REFERENCES tanque ( idtanque );

ALTER TABLE funcionario
    ADD CONSTRAINT funcionario_posto_fk FOREIGN KEY ( posto_cnpj )
        REFERENCES posto ( cnpj );

ALTER TABLE nota_pagamento
    ADD CONSTRAINT nota_pagamento_formapagamento_fk FOREIGN KEY ( formapagamento_idpagamento )
        REFERENCES formapagamento ( idpagamento );

ALTER TABLE nota_pagamento
    ADD CONSTRAINT nota_pagamento_notafiscal_fk FOREIGN KEY ( notafiscal_idnota )
        REFERENCES notafiscal ( idnota );

ALTER TABLE notafiscal
    ADD CONSTRAINT notafiscal_venda_fk FOREIGN KEY ( venda_idvenda )
        REFERENCES venda ( idvenda );

ALTER TABLE servico
    ADD CONSTRAINT servico_produto_fk FOREIGN KEY ( produto_idproduto )
        REFERENCES produto ( idproduto );

ALTER TABLE venda
    ADD CONSTRAINT venda_bomba_fk FOREIGN KEY ( bomba_idbomba )
        REFERENCES bomba ( idbomba );

ALTER TABLE venda
    ADD CONSTRAINT venda_posto_fk FOREIGN KEY ( posto_cnpj )
        REFERENCES posto ( cnpj );

ALTER TABLE venda
    ADD CONSTRAINT venda_servico_fk FOREIGN KEY ( servico_idservico )
        REFERENCES servico ( idservico );


