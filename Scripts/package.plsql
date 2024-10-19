/*

Bianca Leticia Román Caldeira - RM552267 - Turma : 2TDSPH
Charlene Aparecida Estevam Mendes Fialho - RM552252 - Turma : 2TDSPH
Lais Alves Da Silva Cruz - RM:552258 - Turma : 2TDSPH

CP5 - Banco de Dados - Tema: Posto de Gasolina

*/

/* -------------------------- PL/SQL --------------------------*/
SET SERVEROUTPUT ON;
SET VERIFY OFF;

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



--Usar as Funções do Package em um Relatório Customizado
SELECT 
    v.idvenda,
    v.datavenda,
    posto_pkg.calcular_valor_total(v.idvenda) AS valor_total
FROM venda v
WHERE v.posto_cnpj = '52307684000172';
