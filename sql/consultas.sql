
-- ============================================================
-- PROJETO: MERCADO ATLÂNTICO
-- Banco de dados: Firebird
-- Conexão: ODBC via Power Query
--
-- ORIGEM DOS DADOS:
-- - view_item2: dados de vendas
-- - produtos: cadastro de produtos e relacionamento com seções
-- - estoque: informações de estoque
-- - recebimentositens: itens recebidos
-- - secoes: tabela importada diretamente do banco pelo Power Query,
--   sem elaboração de consulta SQL específica para sua extração.
--
-- A tabela secoes foi utilizada para complementar a identificação
-- das seções dos produtos.
-- ============================================================




-- ============================================================
-- 1. ANÁLISE DE VENDAS E RENTABILIDADE POR PRODUTO E FILIAL
-- Objetivo:
-- Consolidar indicadores diários de vendas, quantidade,
-- custo médio, preço praticado e lucro estimado.
-- ============================================================

SELECT
    CAST(v.wdatacaixa AS DATE) AS Datacaixa,
    p.widsecao AS Idsecao,
    v.widproduto AS Idproduto,
    v.wcodigoproduto AS codigo,
    v.wnomefiscal AS Nomeproduto,
    AVG(v.wcustounitario) AS Custo,
    AVG(v.wprecopraticado) AS Precopraticado,
    SUM(v.wquantidade) AS Quantidade,
    SUM(
        v.wvenda -
        (
            v.wvalordesconto
            + v.wdescontopromocao
            + v.wdescontoscanntech
        )
    ) AS Venda,
    SUM(
        (v.wprecopraticado - v.wcustounitario)
        * v.wquantidade
    ) AS Lucro,
    v.widfilial AS Filial
FROM view_item2 v
JOIN produtos p
    ON p.widproduto = v.widproduto
WHERE
    CAST(v.wdatacaixa AS DATE) >= '2026-08-01'
    AND v.wcancelado IS NULL
GROUP BY
    CAST(v.wdatacaixa AS DATE),
    v.widproduto,
    v.wcodigoproduto,
    p.widsecao,
    v.wnomefiscal,
    v.widfilial;


-- ============================================================
-- 2. ANÁLISE DE ESTOQUE E RECEBIMENTOS
-- Objetivo:
-- Consolidar o estoque por data, filial e produto,
-- relacionando-o às quantidades recebidas.
-- Utiliza CTEs para organizar as etapas da consulta.
-- ============================================================

WITH est AS (
    SELECT
        CAST(e.wupdatetime AS DATE) AS dataestoque,
        e.widfilial AS filial,
        e.widproduto,
        SUM(e.wquantidade) AS estoqueatual
    FROM estoque e
    WHERE
        CAST(e.wupdatetime AS DATE) >= '2026-08-01'
        AND e.widfilial != 1
    GROUP BY
        CAST(e.wupdatetime AS DATE),
        e.widfilial,
        e.widproduto
),
rec AS (
    SELECT
        CAST(r.wdatarecebimento AS DATE) AS datarec,
        r.widfilial AS filial,
        r.widproduto,
        SUM(r.wquantidade) AS qtd_recebida
    FROM recebimentositens r
    WHERE
        CAST(r.wdatarecebimento AS DATE) >= '2026-08-01'
    GROUP BY
        CAST(r.wdatarecebimento AS DATE),
        r.widfilial,
        r.widproduto
)
SELECT
    est.dataestoque,
    est.filial AS Filial,
    s.widsecao AS Idsecao,
    p.wcodigoprincipal AS codigo,
    p.widproduto AS Idproduto,
    p.wnomeproduto AS Nomeproduto,
    est.estoqueatual,
    COALESCE(rec.qtd_recebida, 0) AS qtd_recebida
FROM est
JOIN produtos p
    ON p.widproduto = est.widproduto
JOIN secoes s
    ON s.widsecao = p.widsecao
LEFT JOIN rec
    ON rec.widproduto = est.widproduto
    AND rec.filial = est.filial
    AND rec.datarec = est.dataestoque
ORDER BY
    est.dataestoque;
