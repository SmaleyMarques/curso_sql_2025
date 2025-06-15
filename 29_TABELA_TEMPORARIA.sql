-- TABELA TEMPORÁRIA (#)
-- TABELA TEMPORÁRIA GLOBAL (##)

CREATE TABLE #tblTemporaria
(
 cod_cliente	INT,
 nome_cliente	VARCHAR(80),
 total_vendido	MONEY
)

SELECT *
  FROM #tblTemporaria


SELECT B.ENTIDADE AS cod_cliente, 
	   B.NOME AS nome_cliente,
	   SUM( VENDA_LIQUIDA ) AS total_vendido
  INTO #tblClientesVenda
  FROM VENDAS_ANALITICAS A
  JOIN ENTIDADES         B ON A.CLIENTE = B.ENTIDADE
 GROUP 
    BY B.ENTIDADE, B.NOME

SELECT *
  FROM #tblClientesVenda