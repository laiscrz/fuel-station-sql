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


/*INSERTS 5 EM CADA TABELA*/

/* Combustível */
INSERT INTO combustivel (idcombustivel, tipo, precolitro) VALUES (1, 'Gasolina', 6.49);
INSERT INTO combustivel (idcombustivel, tipo, precolitro) VALUES (2, 'Etanol', 4.29);
INSERT INTO combustivel (idcombustivel, tipo, precolitro) VALUES (3, 'Diesel', 5.99);
INSERT INTO combustivel (idcombustivel, tipo, precolitro) VALUES (4, 'GNV', 3.69);
INSERT INTO combustivel (idcombustivel, tipo, precolitro) VALUES (5, 'Querosene', 4.99);

/* Tanque */
INSERT INTO tanque (idtanque, capacidade, datainstalacao) VALUES (1, 15000, TO_DATE('2021-05-15', 'YYYY-MM-DD'));
INSERT INTO tanque (idtanque, capacidade, datainstalacao) VALUES (2, 20000, TO_DATE('2020-08-10', 'YYYY-MM-DD'));
INSERT INTO tanque (idtanque, capacidade, datainstalacao) VALUES (3, 10000, TO_DATE('2022-01-25', 'YYYY-MM-DD'));
INSERT INTO tanque (idtanque, capacidade, datainstalacao) VALUES (4, 18000, TO_DATE('2021-12-10', 'YYYY-MM-DD'));
INSERT INTO tanque (idtanque, capacidade, datainstalacao) VALUES (5, 12000, TO_DATE('2023-03-05', 'YYYY-MM-DD'));

/* Bomba */
INSERT INTO bomba (idbomba, tipobomba, statusbomba, combustivel_idcombustivel, tanque_idtanque) 
VALUES (1, 'Bomba 1', 'Ativa', 1, 1);
INSERT INTO bomba (idbomba, tipobomba, statusbomba, combustivel_idcombustivel, tanque_idtanque) 
VALUES (2, 'Bomba 2', 'Ativa', 2, 2);
INSERT INTO bomba (idbomba, tipobomba, statusbomba, combustivel_idcombustivel, tanque_idtanque) 
VALUES (3, 'Bomba 3', 'Inativa', 3, 3);
INSERT INTO bomba (idbomba, tipobomba, statusbomba, combustivel_idcombustivel, tanque_idtanque) 
VALUES (4, 'Bomba 4', 'Ativa', 4, 4);
INSERT INTO bomba (idbomba, tipobomba, statusbomba, combustivel_idcombustivel, tanque_idtanque) 
VALUES (5, 'Bomba 5', 'Ativa', 5, 5);

/* Forma de Pagamento */
INSERT INTO formapagamento (idpagamento, descricaotipo, taxa) VALUES (1, 'Cartão de Crédito', 2.5);
INSERT INTO formapagamento (idpagamento, descricaotipo, taxa) VALUES (2, 'Cartão de Débito', 1.5);
INSERT INTO formapagamento (idpagamento, descricaotipo, taxa) VALUES (3, 'Dinheiro', 0);
INSERT INTO formapagamento (idpagamento, descricaotipo, taxa) VALUES (4, 'Pix', 0);
INSERT INTO formapagamento (idpagamento, descricaotipo, taxa) VALUES (5, 'Cartão de Débito', 1.5);

/* Posto */
INSERT INTO posto (cnpj, nome, horario_funcionamento, endereco) 
VALUES ('52307684000172', 'Ipiranga', '24 horas', 'Rua A, 123');
INSERT INTO posto (cnpj, nome, horario_funcionamento, endereco) 
VALUES ('60133266000134', 'Shell', '6h às 22h', 'Av. B, 456');
INSERT INTO posto (cnpj, nome, horario_funcionamento, endereco) 
VALUES ('62361515000174', 'Petrobras', '24 horas', 'Rua C, 789');
INSERT INTO posto (cnpj, nome, horario_funcionamento, endereco) 
VALUES ('36488202000171', 'Boxter', '6h às 20h', 'Av. D, 101');
INSERT INTO posto (cnpj, nome, horario_funcionamento, endereco) 
VALUES ('42607361000140', 'Rede Graal', '24 horas', 'Rua E, 102');

/* Funcionário */
INSERT INTO funcionario (cpf, nome, telefone, cargo, posto_cnpj) 
VALUES ('12345678901', 'João da Silva', '11987654321', 'Frentista', '52307684000172');
INSERT INTO funcionario (cpf, nome, telefone, cargo, posto_cnpj) 
VALUES ('98765432109', 'Maria Oliveira', '21987654321', 'Caixa', '60133266000134');
INSERT INTO funcionario (cpf, nome, telefone, cargo, posto_cnpj) 
VALUES ('45678912301', 'Carlos Pereira', '31987654321', 'Gerente', '62361515000174');
INSERT INTO funcionario (cpf, nome, telefone, cargo, posto_cnpj) 
VALUES ('65432198709', 'Ana Souza', '41987654321', 'Supervisor', '36488202000171');
INSERT INTO funcionario (cpf, nome, telefone, cargo, posto_cnpj) 
VALUES ('78912345601', 'Paulo Moreira', '51987654321', 'Atendente', '42607361000140');

/* Produto */
INSERT INTO produto (idproduto, nome, preco) VALUES (1, 'Óleo de Motor', 50.00);
INSERT INTO produto (idproduto, nome, preco) VALUES (2, 'Filtro de Óleo', 30.00);
INSERT INTO produto (idproduto, nome, preco) VALUES (3, 'Pneu', 200.00);
INSERT INTO produto (idproduto, nome, preco) VALUES (4, 'Palheta de Limpador', 25.00);
INSERT INTO produto (idproduto, nome, preco) VALUES (5, 'Adesivo Parabrisa', 10.00);

/* Serviço */
INSERT INTO servico (idservico, nome, preco, descricao, produto_idproduto) 
VALUES (1, 'Troca de Óleo', 100.00, 'Troca de óleo completa', 1);
INSERT INTO servico (idservico, nome, preco, descricao, produto_idproduto) 
VALUES (2, 'Alinhamento e Balanceamento', 150.00, 'Serviço de alinhamento e balanceamento', 3);
INSERT INTO servico (idservico, nome, preco, descricao, produto_idproduto) 
VALUES (3, 'Troca de Filtro de Óleo', 80.00, 'Substituição de filtro de óleo', 2);
INSERT INTO servico (idservico, nome, preco, descricao, produto_idproduto) 
VALUES (4, 'Troca de Palheta', 40.00, 'Troca de palheta do limpador', 4);
INSERT INTO servico (idservico, nome, preco, descricao, produto_idproduto) 
VALUES (5, 'Troca de Pneus', 500.00, 'Troca de quatro pneus', 3);


/* Venda */
INSERT INTO venda (idvenda, datavenda, quantidadelitro, posto_cnpj, servico_idservico, bomba_idbomba) 
VALUES (1, TO_DATE('2023-10-01', 'YYYY-MM-DD'), 50, '52307684000172', 1, 1);
INSERT INTO venda (idvenda, datavenda, quantidadelitro, posto_cnpj, servico_idservico, bomba_idbomba) 
VALUES (2, TO_DATE('2023-09-15', 'YYYY-MM-DD'), 30, '60133266000134', 2, 2);
INSERT INTO venda (idvenda, datavenda, quantidadelitro, posto_cnpj, servico_idservico, bomba_idbomba) 
VALUES (3, TO_DATE('2023-08-25', 'YYYY-MM-DD'), 20, '62361515000174', 3, 3);
INSERT INTO venda (idvenda, datavenda, quantidadelitro, posto_cnpj, servico_idservico, bomba_idbomba) 
VALUES (4, TO_DATE('2023-07-30', 'YYYY-MM-DD'), 40, '36488202000171', 4, 4);
INSERT INTO venda (idvenda, datavenda, quantidadelitro, posto_cnpj, servico_idservico, bomba_idbomba) 
VALUES (5, TO_DATE('2023-06-20', 'YYYY-MM-DD'), 60, '42607361000140', 5, 5);


/* Nota Fiscal */
INSERT INTO notafiscal (idnota, dataemissao, status, venda_idvenda, valortotal) 
VALUES (1, TO_DATE('2023-10-01', 'YYYY-MM-DD'), 'Pago', 1, 250.00);
INSERT INTO notafiscal (idnota, dataemissao, status, venda_idvenda, valortotal) 
VALUES (2, TO_DATE('2023-09-15', 'YYYY-MM-DD'), 'Pago', 2, 150.00);
INSERT INTO notafiscal (idnota, dataemissao, status, venda_idvenda, valortotal) 
VALUES (3, TO_DATE('2023-08-25', 'YYYY-MM-DD'), 'Cancelado', 3, 100.00);
INSERT INTO notafiscal (idnota, dataemissao, status, venda_idvenda, valortotal) 
VALUES (4, TO_DATE('2023-07-30', 'YYYY-MM-DD'), 'Pendente', 4, 300.00);
INSERT INTO notafiscal (idnota, dataemissao, status, venda_idvenda, valortotal) 
VALUES (5, TO_DATE('2023-06-20', 'YYYY-MM-DD'), 'Pago', 5, 450.00);

/* Nota Pagamento */
INSERT INTO nota_pagamento (formapagamento_idpagamento, notafiscal_idnota) VALUES (1, 1);
INSERT INTO nota_pagamento (formapagamento_idpagamento, notafiscal_idnota) VALUES (2, 2);
INSERT INTO nota_pagamento (formapagamento_idpagamento, notafiscal_idnota) VALUES (3, 3);
INSERT INTO nota_pagamento (formapagamento_idpagamento, notafiscal_idnota) VALUES (4, 4);
INSERT INTO nota_pagamento (formapagamento_idpagamento, notafiscal_idnota) VALUES (5, 5);

/* Salvando Alterações*/
COMMIT;

/* SELECT TABLES */
SELECT * FROM bomba;
SELECT * FROM combustivel;
SELECT * FROM formapagamento;
SELECT * FROM funcionario;
SELECT * FROM nota_pagamento;
SELECT * FROM notafiscal;
SELECT * FROM posto;
SELECT * FROM produto;
SELECT * FROM servico;
SELECT * FROM tanque;
SELECT * FROM venda;



/* -------------------------- PL/SQL --------------------------*/
SET SERVEROUTPUT ON;
SET VERIFY OFF;

/* -------------------------- FUNCTIONS --------------------------*/

-- calcular_valor_total
CREATE OR REPLACE FUNCTION calcular_valor_total(p_idvenda NUMBER) 
RETURN NUMBER 
IS
    v_valor_total NUMBER(10,2);
BEGIN
    SELECT v.quantidadelitro * c.precolitro INTO v_valor_total
    FROM venda v
    JOIN bomba b ON v.bomba_idbomba = b.idbomba
    JOIN combustivel c ON b.combustivel_idcombustivel = c.idcombustivel
    WHERE v.idvenda = p_idvenda;
    
    RETURN NVL(v_valor_total, 0);
END;
SELECT calcular_valor_total(1) AS valor_total FROM dual; -- EXECUTA

-- total_vendas_posto
CREATE OR REPLACE FUNCTION total_vendas_posto(p_cnpj VARCHAR2) 
RETURN NUMBER 
IS
    v_total NUMBER(10,2) := 0;
    CURSOR c_vendas IS
        SELECT nf.valortotal
        FROM notafiscal nf
        JOIN venda v ON nf.venda_idvenda = v.idvenda
        WHERE v.posto_cnpj = p_cnpj;
BEGIN
    FOR venda_rec IN c_vendas LOOP
        v_total := v_total + venda_rec.valortotal;
    END LOOP;
    
    RETURN NVL(v_total, 0);
END;
SELECT total_vendas_posto(52307684000172) AS valor_total_posto FROM dual; -- EXECUTA

-- media_preco_combustivel
CREATE OR REPLACE FUNCTION media_preco_combustivel 
RETURN NUMBER 
IS
    v_media NUMBER(8,2);
BEGIN
    SELECT AVG(precolitro) INTO v_media
    FROM combustivel;
    
    RETURN NVL(v_media, 0);
END;
SELECT media_preco_combustivel AS media_combustivel FROM dual; -- EXECUTA

-- calcular_valor_produtos_servicos
CREATE OR REPLACE FUNCTION calcular_valor_produtos_servicos RETURN NUMBER AS
    v_valor_total NUMBER := 0;
BEGIN
    SELECT SUM(p.preco)  -- Considerando que a soma do preço dos produtos utilizados
    INTO v_valor_total
    FROM servico s
    JOIN produto p ON s.produto_idproduto = p.idproduto;  -- Alterado para o nome correto da coluna

    RETURN NVL(v_valor_total, 0);  -- Retorna 0 se não houver serviços
END calcular_valor_produtos_servicos;


/* -------------------------- PROCEDURES -------------------------- */
-- registrar_venda
CREATE OR REPLACE PROCEDURE registrar_venda(
    p_quantidadelitro NUMBER,
    p_posto_cnpj VARCHAR2,
    p_servico_idservico NUMBER,
    p_bomba_idbomba NUMBER,
    p_forma_pagamento_id NUMBER
) 
IS
    v_idvenda NUMBER;
    v_idnota NUMBER;
    v_valor_total NUMBER;
BEGIN
    -- Obter o próximo idvenda
    SELECT NVL(MAX(idvenda), 0) + 1 INTO v_idvenda FROM venda;
    
    -- Inserir nova venda
    INSERT INTO venda (idvenda, datavenda, quantidadelitro, posto_cnpj, servico_idservico, bomba_idbomba)
    VALUES (v_idvenda, SYSDATE, p_quantidadelitro, p_posto_cnpj, p_servico_idservico, p_bomba_idbomba);
    
    -- Calcular valor total usando a função
    v_valor_total := calcular_valor_total(v_idvenda);
    
    -- Obter o próximo idnota
    SELECT NVL(MAX(idnota), 0) + 1 INTO v_idnota FROM notafiscal;
    
    -- Inserir nota fiscal
    INSERT INTO notafiscal (idnota, dataemissao, status, venda_idvenda, valortotal)
    VALUES (v_idnota, SYSDATE, 'Pago', v_idvenda, v_valor_total);
    
    -- Associar forma de pagamento
    INSERT INTO nota_pagamento (formapagamento_idpagamento, notafiscal_idnota)
    VALUES (p_forma_pagamento_id, v_idnota);
    
    COMMIT;
   
    DBMS_OUTPUT.PUT_LINE('Venda registrada com sucesso! ID da Venda: ' || v_idvenda);
    DBMS_OUTPUT.PUT_LINE('Nota fiscal emitida com sucesso! ID da Nota: ' || v_idnota);
END;

BEGIN
    registrar_venda(
        p_quantidadelitro => 100,              
        p_posto_cnpj => '52307684000172',     
        p_servico_idservico => 1,              
        p_bomba_idbomba => 1,                  
        p_forma_pagamento_id => 1                
    );
END;

-- gerar_relatorio_vendas_posto
CREATE OR REPLACE PROCEDURE gerar_relatorio_vendas_posto(p_cnpj VARCHAR2) 
IS
    CURSOR c_relatorio IS
        SELECT v.idvenda, v.datavenda, v.quantidadelitro, c.tipo, nf.valortotal
        FROM venda v
        JOIN bomba b ON v.bomba_idbomba = b.idbomba
        JOIN combustivel c ON b.combustivel_idcombustivel = c.idcombustivel
        JOIN notafiscal nf ON v.idvenda = nf.venda_idvenda
        WHERE v.posto_cnpj = p_cnpj;
    rec_relatorio c_relatorio%ROWTYPE;
BEGIN
    DBMS_OUTPUT.PUT_LINE('Relatório de Vendas do Posto: ' || p_cnpj);
    
    OPEN c_relatorio;
    LOOP
        FETCH c_relatorio INTO rec_relatorio;
        EXIT WHEN c_relatorio%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('ID: ' || rec_relatorio.idvenda || 
                             ' | Data: ' || TO_CHAR(rec_relatorio.datavenda, 'DD/MM/YYYY') || 
                             ' | Litros: ' || rec_relatorio.quantidadelitro || 
                             ' | Combustível: ' || rec_relatorio.tipo || 
                             ' | Valor: R$ ' || rec_relatorio.valortotal);
    END LOOP;
    CLOSE c_relatorio;
END;

BEGIN
    gerar_relatorio_vendas_posto('52307684000172'); -- EXECUTA
END;

-- gerar_relatorio_servico_produto
CREATE OR REPLACE PROCEDURE gerar_relatorio_servico_produto AS
    CURSOR c_produtos IS
        SELECT nome, preco FROM produto;

    v_nome_produto produto.nome%TYPE;
    v_preco_unitario produto.preco%TYPE;

    v_valor_total_produtos NUMBER;

BEGIN
    -- Relatório de Produtos
    DBMS_OUTPUT.PUT_LINE('----- Relatório de Produtos -----');
    OPEN c_produtos;
    LOOP
        FETCH c_produtos INTO v_nome_produto, v_preco_unitario;
        EXIT WHEN c_produtos%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('Produto: ' || v_nome_produto || 
                             ', Preço Unitário: R$ ' || v_preco_unitario);
    END LOOP;
    CLOSE c_produtos;

    -- Cálculo do valor dos produtos utilizados em serviços
    v_valor_total_produtos := calcular_valor_produtos_servicos();

    DBMS_OUTPUT.PUT_LINE('----- Valor Total dos Produtos Utilizados em Serviços -----');
    DBMS_OUTPUT.PUT_LINE('Valor Total: R$ ' || v_valor_total_produtos);

END gerar_relatorio_servico_produto;
BEGIN
    gerar_relatorio_servico_produto; -- Chama o procedimento para gerar o relatório
END;


/* -------------------------- PACKAGE  -------------------------- */

/*Criando o Package*/

CREATE OR REPLACE PACKAGE posto_pkg IS
    -- Funções
    FUNCTION calcular_valor_total(p_idvenda NUMBER) RETURN NUMBER;
    FUNCTION total_vendas_posto(p_cnpj VARCHAR2) RETURN NUMBER;
    FUNCTION media_preco_combustivel RETURN NUMBER;
    FUNCTION calcular_valor_produtos_servicos RETURN NUMBER;

    -- Procedimentos
    PROCEDURE registrar_venda(
        p_quantidadelitro NUMBER,
        p_posto_cnpj VARCHAR2,
        p_servico_idservico NUMBER,
        p_bomba_idbomba NUMBER,
        p_forma_pagamento_id NUMBER
    );
    PROCEDURE gerar_relatorio_vendas_posto(p_cnpj VARCHAR2);
END posto_pkg;
/

/*Corpo do Package*/

CREATE OR REPLACE PACKAGE BODY posto_pkg IS
    -- Função para calcular valor total da venda
    FUNCTION calcular_valor_total(p_idvenda NUMBER) RETURN NUMBER IS
        v_valor_total NUMBER(10,2);
    BEGIN
        SELECT v.quantidadelitro * c.precolitro INTO v_valor_total
        FROM venda v
        JOIN bomba b ON v.bomba_idbomba = b.idbomba
        JOIN combustivel c ON b.combustivel_idcombustivel = c.idcombustivel
        WHERE v.idvenda = p_idvenda;
        
        RETURN NVL(v_valor_total, 0);
    END calcular_valor_total;

    -- Função para calcular total de vendas por posto
    FUNCTION total_vendas_posto(p_cnpj VARCHAR2) RETURN NUMBER IS
        v_total NUMBER(10,2) := 0;
        CURSOR c_vendas IS
            SELECT nf.valortotal
            FROM notafiscal nf
            JOIN venda v ON nf.venda_idvenda = v.idvenda
            WHERE v.posto_cnpj = p_cnpj;
    BEGIN
        FOR venda_rec IN c_vendas LOOP
            v_total := v_total + venda_rec.valortotal;
        END LOOP;
        
        RETURN NVL(v_total, 0);
    END total_vendas_posto;

    -- Função para calcular a média de preço dos combustíveis
    FUNCTION media_preco_combustivel RETURN NUMBER IS
        v_media NUMBER(8,2);
    BEGIN
        SELECT AVG(precolitro) INTO v_media
        FROM combustivel;
        
        RETURN NVL(v_media, 0);
    END media_preco_combustivel;

    -- Função para calcular o valor dos produtos e serviços
    FUNCTION calcular_valor_produtos_servicos RETURN NUMBER IS
        v_valor_total NUMBER := 0;
    BEGIN
        SELECT SUM(p.preco)
        INTO v_valor_total
        FROM servico s
        JOIN produto p ON s.produto_idproduto = p.idproduto;

        RETURN NVL(v_valor_total, 0);
    END calcular_valor_produtos_servicos;

    -- Procedimento para registrar uma venda
    PROCEDURE registrar_venda(
        p_quantidadelitro NUMBER,
        p_posto_cnpj VARCHAR2,
        p_servico_idservico NUMBER,
        p_bomba_idbomba NUMBER,
        p_forma_pagamento_id NUMBER
    ) IS
        v_idvenda NUMBER;
        v_idnota NUMBER;
        v_valor_total NUMBER;
    BEGIN
        SELECT NVL(MAX(idvenda), 0) + 1 INTO v_idvenda FROM venda;
        
        INSERT INTO venda (idvenda, datavenda, quantidadelitro, posto_cnpj, servico_idservico, bomba_idbomba)
        VALUES (v_idvenda, SYSDATE, p_quantidadelitro, p_posto_cnpj, p_servico_idservico, p_bomba_idbomba);
        
        v_valor_total := calcular_valor_total(v_idvenda);
        
        SELECT NVL(MAX(idnota), 0) + 1 INTO v_idnota FROM notafiscal;
        
        INSERT INTO notafiscal (idnota, dataemissao, status, venda_idvenda, valortotal)
        VALUES (v_idnota, SYSDATE, 'Pago', v_idvenda, v_valor_total);
        
        INSERT INTO nota_pagamento (formapagamento_idpagamento, notafiscal_idnota)
        VALUES (p_forma_pagamento_id, v_idnota);
        
        COMMIT;
       
        DBMS_OUTPUT.PUT_LINE('Venda registrada com sucesso! ID da Venda: ' || v_idvenda);
        DBMS_OUTPUT.PUT_LINE('Nota fiscal emitida com sucesso! ID da Nota: ' || v_idnota);
    END registrar_venda;

    -- Procedimento para gerar relatório de vendas de um posto
    PROCEDURE gerar_relatorio_vendas_posto(p_cnpj VARCHAR2) IS
        CURSOR c_relatorio IS
            SELECT v.idvenda, v.datavenda, v.quantidadelitro, c.tipo, nf.valortotal
            FROM venda v
            JOIN bomba b ON v.bomba_idbomba = b.idbomba
            JOIN combustivel c ON b.combustivel_idcombustivel = c.idcombustivel
            JOIN notafiscal nf ON v.idvenda = nf.venda_idvenda
            WHERE v.posto_cnpj = p_cnpj;
        rec_relatorio c_relatorio%ROWTYPE;
    BEGIN
        DBMS_OUTPUT.PUT_LINE('Relatório de Vendas do Posto: ' || p_cnpj);
        
        OPEN c_relatorio;
        LOOP
            FETCH c_relatorio INTO rec_relatorio;
            EXIT WHEN c_relatorio%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE('ID: ' || rec_relatorio.idvenda || 
                                 ' | Data: ' || TO_CHAR(rec_relatorio.datavenda, 'DD/MM/YYYY') || 
                                 ' | Litros: ' || rec_relatorio.quantidadelitro || 
                                 ' | Combustível: ' || rec_relatorio.tipo || 
                                 ' | Valor Total: ' || rec_relatorio.valortotal);
        END LOOP;
        CLOSE c_relatorio;
    END gerar_relatorio_vendas_posto;
    
END posto_pkg;
/

/* Exemplos de uso de funções e procedimentos do package */

--Função do Package para Calcular o Valor Total de uma Venda
SELECT posto_pkg.calcular_valor_total(5) AS valor_total
FROM dual;


--Obter o Total de Vendas de um Posto com um Determinado CNPJ
SELECT posto_pkg.total_vendas_posto('52307684000172') AS total_vendas
FROM dual;


--Chamar a Função para Obter a Média de Preços de Combustíveis
SELECT posto_pkg.media_preco_combustivel() AS media_preco
FROM dual;


--Chamar a Função para Calcular o Valor dos Produtos e Serviços
SELECT posto_pkg.calcular_valor_produtos_servicos() AS valor_produtos_servicos
FROM dual;


--Chamar o Procedimento para Gerar um Relatório de Vendas do Posto
BEGIN
    posto_pkg.gerar_relatorio_vendas_posto('52307684000172');
END;
/


--Usar as Funções do Package em um Relatório Customizado
SELECT 
    v.idvenda,
    v.datavenda,
    posto_pkg.calcular_valor_total(v.idvenda) AS valor_total
FROM venda v
WHERE v.posto_cnpj = '52307684000172';








