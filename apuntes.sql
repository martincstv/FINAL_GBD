SELECT C.ID_CLI,
C.CED_CLI,
C.NOM_CLI,
C.APE_CLI,
CI.NOM_CIU,
C.DIR_CLI,
C.COR_CLI,
C.TEL_CLI 
FROM CLIENTES C INNER JOIN CIUDADES CI ON C.CIU_CLI = CI.ID_CIU
ORDER BY C.ID_CLI ASC;


SELECT ID_CIU
FROM CIUDADES
WHERE NOM_CIU = 'AMBATO';