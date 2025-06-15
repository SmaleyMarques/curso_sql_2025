--SET DATEFORMAT DMY
--SET LANGUAGE Brazilian

CREATE FUNCTION FN_MONTAR_D_CALENDARIO
(
  @D_INI             DATE
, @D_FIM             DATE
, @INICIO_ANO_FISCAL INT
)

RETURNS @D_CALENDARIO TABLE
(
  [DATA] DATE PRIMARY KEY
, [ANO] INT
, [DATA_INI_ANO] DATE
, [DATA_FIM_ANO] DATE
, [MES] TINYINT
, [DATA_INI_MES] DATE
, [DATA_FIM_MES] DATE
, [DIAS_NO_MES] INT
, [ANO_MES] INT
, [DIA] TINYINT
, [NOME_DIA_SEMANA] VARCHAR(15)
, [NOME_DIA_SEMANA_SHORT] CHAR(3)
, [DIA_SEMANA] TINYINT
, [DIA_DO_ANO] INT
, [NOME_MES] VARCHAR(15)
, [NOME_MES_SHORT] CHAR(3)
, [TRIMESTRE] TINYINT
, [NOME_TRIMESTRE] VARCHAR(5)
, [SEMANA_DO_ANO] TINYINT
, [ANO_FISCAL] INT
)

AS

BEGIN



DECLARE @ANO_INI INT = YEAR( @D_INI )
DECLARE @ANO_FIM INT = YEAR( @D_FIM )

SET @D_INI = DATEFROMPARTS(@ANO_INI, 1, 1)
SET @D_FIM = DATEFROMPARTS(@ANO_FIM, 12, 31)

;WITH DATAS AS 
(
SELECT DATEADD( DAY, SEQUENCIA - 1, @D_INI) AS [DATA]
  FROM VEZES
 WHERE SEQUENCIA <= DATEDIFF(DAY, @D_INI, @D_FIM) + 1
)

INSERT INTO @D_CALENDARIO
(
  [DATA]
, [ANO]
, [DATA_INI_ANO]
, [DATA_FIM_ANO]
, [MES]
, [DATA_INI_MES]
, [DATA_FIM_MES]
, [DIAS_NO_MES]
, [ANO_MES]
, [DIA]
, [NOME_DIA_SEMANA]
, [NOME_DIA_SEMANA_SHORT]
, [DIA_SEMANA]
, [DIA_DO_ANO]
, [NOME_MES]
, [NOME_MES_SHORT]
, [TRIMESTRE]
, [NOME_TRIMESTRE]
, [SEMANA_DO_ANO]
, [ANO_FISCAL]
)

SELECT [DATA]                                            AS [DATA]
     , YEAR( [DATA] )                                    AS ANO --DATEPART( yy, [DATA] )
	 , DATEFROMPARTS(YEAR( [DATA] ), 1, 1)               AS DATA_INI_ANO
	 , DATEFROMPARTS(YEAR( [DATA] ), 12, 31)             AS DATA_FIM_ANO
	 , MONTH( [DATA] )                                   AS MES --DATEPART( mm, [DATA] )
     , DATEFROMPARTS(YEAR( [DATA] ), MONTH( [DATA] ), 1) AS DATA_INI_MES
	 , EOMONTH( [DATA] )                                 AS DATA_FIM_MES
	 , DAY( EOMONTH( [DATA] ) )                          AS DIAS_NO_MES --DATEPART( dd,  EOMONTH( [DATA] ) )
	 , CONCAT(
			YEAR( [DATA] ),
			CONCAT(
				REPLICATE( '0', 2 - LEN( MONTH( [DATA] ) ) ),
				 MONTH( [DATA] )
			)
	  )                                                  AS ANO_MES
	 , DAY( [DATA] )                                     AS DIA --DATEPART( dd, [DATA] )
	 , DATENAME( dw, [DATA] )                            AS NOME_DIA_SEMANA
	 , LEFT(DATENAME( dw, [DATA] ) , 3 )                 AS NOME_DIA_SEMANA_SHORT
	 , DATEPART( [weekday], [DATA] )                     AS DIA_SEMANA
	 , DATEPART( dy, [DATA] )                            AS DIA_DO_ANO
	 , DATENAME( mm, [DATA] )                            AS NOME_MES
	 , LEFT(DATENAME( mm, [DATA] ) , 3 )                 AS NOME_MES_SHORT
	 , DATEPART( qq, [DATA] )                            AS TRIMESTRE
	 , CONCAT('T ', DATEPART( qq, [DATA] ))              AS NOME_TRIMESTRE
	 , DATEPART( wk, [DATA] )                            AS SEMANA_DO_ANO
	 , CASE @INICIO_ANO_FISCAL
			WHEN 1 THEN YEAR( [DATA] )
			ELSE YEAR( [DATA] ) + CAST( ( MONTH( [DATA] ) + ( 13 - @INICIO_ANO_FISCAL ) ) / 13 AS INT )
	   END                                               AS ANO_FISCAL 
  FROM DATAS

  RETURN

END