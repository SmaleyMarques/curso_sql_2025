-- OPERADORES DE COMPARA��O

/*

= igual a
<> diferente de (P�dr�o ANSI)
!= diferente de
> maior que
>= maior igual a
< menor que
< menor igual a

*/

SELECT	*
FROM ENTIDADES
WHERE ENTIDADE > 3000
ORDER BY ENTIDADE

SELECT	*
FROM ENTIDADES
WHERE ENTIDADE > 3000 AND EMPRESA_NACIONAL = 'S'
ORDER BY ENTIDADE