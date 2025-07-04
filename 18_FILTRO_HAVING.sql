
-- HAVING

SELECT	PRODUTO,
		CLIENTE,
		SUM(QUANTIDADE) AS TOTAL_QUANTIDADE,
		COUNT(PRODUTO) AS QUANTIDADE_VENDAS
  FROM	VENDAS_ANALITICAS
 WHERE	PRODUTO = 3159
 GROUP
    BY	PRODUTO, CLIENTE
HAVING	COUNT(PRODUTO) >= 10
 ORDER
    BY	QUANTIDADE_VENDAS