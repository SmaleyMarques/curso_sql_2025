/*
ATALHOS:

	CTRL + N => NOVA CONSULTA
	F5 => EXECUTA SCRIPT
*/

--Criando um novo Banco de Dados

CREATE DATABASE CURSO_SQL


USE CURSO_SQL 

CREATE TABLE 
	CLIENTES(
		ID_CLIENTE		INT			NOT NULL PRIMARY KEY IDENTITY(1,1),
		NOME			VARCHAR(60)	NOT NULL,
		TIPO_ENDERECO	VARCHAR(20)	NOT NULL,
		ENDERECO		VARCHAR(60) NOT NULL,
		NUMERO			NUMERIC(5)	NOT NULL,
		BAIRRO			VARCHAR(60) NOT NULL,
		COMPLEMENTO		VARCHAR(80)	NULL,
		CEP				CHAR(8)		NOT NULL
	)

DROP TABLE CLIENTES

INSERT INTO CLIENTES(NOME, CPF, DATA_NASCIMENTO)
VALUES('SMALEY MARQUES M. V. FERREIRA', '13813732754', '1992/05/20')

SELECT * FROM CLIENTES

SP_HELP CLIENTES