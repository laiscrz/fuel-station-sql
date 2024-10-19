/*

Bianca Leticia Román Caldeira - RM552267 - Turma : 2TDSPH
Charlene Aparecida Estevam Mendes Fialho - RM552252 - Turma : 2TDSPH
Lais Alves Da Silva Cruz - RM:552258 - Turma : 2TDSPH

CP5 - Banco de Dados - Tema: Posto de Gasolina

*/

/* -------------------------- PL/SQL --------------------------*/
SET SERVEROUTPUT ON;
SET VERIFY OFF;

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