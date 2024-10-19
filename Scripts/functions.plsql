/*

Bianca Leticia Román Caldeira - RM552267 - Turma : 2TDSPH
Charlene Aparecida Estevam Mendes Fialho - RM552252 - Turma : 2TDSPH
Lais Alves Da Silva Cruz - RM:552258 - Turma : 2TDSPH

CP5 - Banco de Dados - Tema: Posto de Gasolina

*/

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
    SELECT SUM(p.preco)  
    INTO v_valor_total
    FROM servico s
    JOIN produto p ON s.produto_idproduto = p.idproduto; 

    RETURN NVL(v_valor_total, 0);  -- Retorna 0 se não houver serviços
END calcular_valor_produtos_servicos;
