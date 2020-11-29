SELECT
    DISTINCT CASE
        WHEN PA.EDAD <= 5 THEN 'Primera_Infancia'
        WHEN PA.EDAD <= 11 THEN 'Infancia'
        WHEN PA.EDAD <= 18 THEN 'Adolescencia'
        WHEN PA.EDAD <= 26 THEN 'Juventud'
        WHEN PA.EDAD <= 59 THEN 'Adultez'
        WHEN PA.EDAD >= 60 THEN 'Tercera_edad'
    END AS etapa,
    DIAG.NOMDIAGNOSTICO AS Diagnostico,
    DIAG.PRINCIPAL,
    CASE
        WHEN TI.IDTIPO = 1 THEN 'PRESUNTIVO'
        WHEN TI.IDTIPO = 2 THEN 'DEFINITIVO'
    END AS Tipo,
    CASE
        WHEN CLA.NOMCLASE = 'CONFIRMADO NUEVO' THEN 'CONFIRMADO_NUEVO'
        WHEN CLA.NOMCLASE = 'CONFIRMADO REPETIDO' THEN 'CONFIRMADO_REPETIDO'
        WHEN CLA.NOMCLASE = 'IMPRESION DIAGNOSTICA' THEN 'IMPRESION_DIAGNOSTICA'
    END AS Clase,
    CASE
        WHEN TO_CHAR(DIAG.FECHA, 'MM') BETWEEN 3
        AND 6 THEN 'Primavera'
        WHEN TO_CHAR(DIAG.FECHA, 'MM') BETWEEN 7
        AND 9 THEN 'Verano'
        WHEN TO_CHAR(DIAG.FECHA, 'MM') BETWEEN 10
        AND 11 THEN 'Otono'
        ELSE 'Invierno'
    END AS Temporada,
    MUN.nommun AS CIUDAD,
    DIAG.codigocie10,
    DIAG.FECHA
FROM
    paciente PA
    JOIN Diagnostico DIAG ON DIAG.idpaciente = PA.idpaciente
    JOIN CLASE CLA ON CLA.IDCLASE = DIAG.IDCLASE
    JOIN TIPO TI ON TI.IDTIPO = DIAG.IDTIPO
    JOIN barrio BA ON BA.IDBARRIO = DIAG.IDBARRIO
    JOIN MUNICIPIO MUN ON MUN.IDMUN = BA.IDMUN