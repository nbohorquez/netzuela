USE `Spuria`;

DECLARE Error_de_clave_externa CONDITION FOR 1452;
DECLARE Error_de_clave_duplicada CONDITION FOR 1052;
DECLARE Error_de_registro_no_encontrado CONDITION FOR 1329;

/**********************************************************/
DELIMITER ;
/**********************************************************/