/*
RESPALDOS
*/

CREATE TABLE BODEGUEROS (
    ID_BOD NUMBER PRIMARY KEY,
    CED_BOD VARCHAR(10) UNIQUE NOT NULL,
    NOM_BOD VARCHAR(15) NOT NULL,
    APE_BOD VARCHAR(15) NOT NULL,
    COR_BOD VARCHAR(50) NOT NULL,
    TEL_BOD VARCHAR(10) NOT NULL,
    SUE_BOD FLOAT NOT NULL
);

INSERT INTO BODEGUEROS VALUES (1,'1801','MARCELA','VASQUEZ','marcela@outlook.com','0987341934',800);

CREATE TABLE PEDIDOS (
    NUM_PED NUMBER PRIMARY KEY,
    FEC_HOR_PED DATE NOT NULL,
    CED_BOD_PED REFERENCES BODEGUEROS (CED_BOD),
    TOT_PED NUMBER NOT NULL,
    EST_PED VARCHAR(1) NOT NULL
);

CREATE TABLE RESPALDO_PEDIDOS (
    NUM_PED NUMBER PRIMARY KEY,
    FEC_HOR_PED DATE NOT NULL,
    CED_BOD_PED REFERENCES BODEGUEROS (CED_BOD),
    TOT_PED NUMBER NOT NULL,
    EST_PED VARCHAR(1) NOT NULL
);

INSERT INTO PEDIDOS VALUES (1,SYSDATE,'1801',700,'A');


CREATE OR REPLACE TRIGGER RESPALDO_PEDIDOS_INS
AFTER INSERT ON PEDIDOS
FOR EACH ROW
BEGIN
    INSERT INTO RESPALDO_PEDIDOS (NUM_PED,FEC_HOR_PED,CED_BOD_PED,TOT_PED,EST_PED)
    VALUES (:NEW.NUM_PED,:NEW.FEC_HOR_PED,:NEW.CED_BOD_PED,:NEW.TOT_PED,:NEW.EST_PED);
END RESPALDO_PEDIDOS_INS;
.
/

CREATE OR REPLACE TRIGGER RESPALDO_PEDIDOS_DEL
AFTER DELETE ON PEDIDOS
FOR EACH ROW
BEGIN
    DELETE FROM RESPALDO_PEDIDOS
    WHERE NUM_PED = :OLD.NUM_PED;
END RESPALDO_PEDIDOS_DEL;
.
/

CREATE OR REPLACE PROCEDURE VACIAR_RESPALDO
IS
BEGIN
DELETE RESPALDO_PEDIDOS;
END;
.
/

CREATE OR REPLACE PROCEDURE LLENAR_RESPALDO
IS
BEGIN
INSERT INTO RESPALDO_PEDIDOS
SELECT * FROM PEDIDOS;
END;
.
/

CREATE OR REPLACE TRIGGER RESPALDO_PEDIDOS_UPD
AFTER UPDATE ON PEDIDOS
BEGIN
    VACIAR_RESPALDO;
    LLENAR_RESPALDO;
END;
.
/

UPDATE PEDIDOS
SET TOT_PED = 50
WHERE NUM_PED = 1;