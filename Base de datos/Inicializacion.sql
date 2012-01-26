/*
*************************************************************
*							  			*
*			TABLAS DE BUSQUEDA				*
*										*
*************************************************************
*/

/* Estos codigos son inventados... todavia no se ha fijado su utilidad */
INSERT INTO CodigoDeError VALUES("OK");
INSERT INTO CodigoDeError VALUES("Privilegios insuficientes");
INSERT INTO CodigoDeError VALUES("Accion imposible");

/* Estos codigos son inventados... todavia no se ha fijado su utilidad */
INSERT INTO Privilegios VALUES("Todos");
INSERT INTO Privilegios VALUES("Ninguno");

INSERT INTO Idioma VALUES("Español");
INSERT INTO Idioma VALUES("English");
INSERT INTO Idioma VALUES("Français");
INSERT INTO Idioma VALUES("Deutsch");

/* Hay que considerar tambien otros codigos que no contempla GS-1 como los automotrices */
INSERT INTO TipoDeCodigoUniversal VALUES("GTIN-13");
INSERT INTO TipoDeCodigoUniversal VALUES("GTIN-8");
INSERT INTO TipoDeCodigoUniversal VALUES("GTIN-14");
INSERT INTO TipoDeCodigoUniversal VALUES("GS1-128");
INSERT INTO TipoDeCodigoUniversal VALUES("Desconocido");

INSERT INTO Sexo VALUES("Hombre");
INSERT INTO Sexo VALUES("Mujer");

INSERT INTO GradoDeInstruccion VALUES("Primaria");
INSERT INTO GradoDeInstruccion VALUES("Secundia");
INSERT INTO GradoDeInstruccion VALUES("Tecnico Medio");
INSERT INTO GradoDeInstruccion VALUES("Tecnico Superior");
INSERT INTO GradoDeInstruccion VALUES("Universitaria");
INSERT INTO GradoDeInstruccion VALUES("Especializacion");
INSERT INTO GradoDeInstruccion VALUES("Maestria");
INSERT INTO GradoDeInstruccion VALUES("Doctorado");

INSERT INTO Visibilidad VALUES("Ninguno visible");
INSERT INTO Visibilidad VALUES("Cantidad visible");
INSERT INTO Visibilidad VALUES("Precio visible");
INSERT INTO Visibilidad VALUES("Ambos visibles");

INSERT INTO Accion VALUES("Crear");
INSERT INTO Accion VALUES("Abrir");
INSERT INTO Accion VALUES("Modificar");
INSERT INTO Accion VALUES("Eliminar");
INSERT INTO Accion VALUES("Bloquear");
INSERT INTO Accion VALUES("Abrir sesion");
INSERT INTO Accion VALUES("Cerrar sesion");

INSERT INTO Calificacion VALUES("Bien");
INSERT INTO Calificacion VALUES("Mal");

INSERT INTO GrupoDeEdad VALUES("Adolescentes");
INSERT INTO GrupoDeEdad VALUES("Adultos jovenes");
INSERT INTO GrupoDeEdad VALUES("Adultos maduros");
INSERT INTO GrupoDeEdad VALUES("Adultos mayores");
INSERT INTO GrupoDeEdad VALUES("Tercera edad");

INSERT INTO Estatus VALUES("Activo");
INSERT INTO Estatus VALUES("Bloqueado");
INSERT INTO Estatus VALUES("Eliminado");

INSERT INTO Dia VALUES("Lunes");
INSERT INTO Dia VALUES("Martes");
INSERT INTO Dia VALUES("Miercoles");
INSERT INTO Dia VALUES("Jueves");
INSERT INTO Dia VALUES("Viernes");
INSERT INTO Dia VALUES("Sabado");
INSERT INTO Dia VALUES("Domingo");

INSERT INTO HusoHorario VALUES("-12:00");
INSERT INTO HusoHorario VALUES("-11:00");
INSERT INTO HusoHorario VALUES("-10:00");
INSERT INTO HusoHorario VALUES("-09:30");
INSERT INTO HusoHorario VALUES("-09:00");
INSERT INTO HusoHorario VALUES("-08:00");
INSERT INTO HusoHorario VALUES("-07:00");
INSERT INTO HusoHorario VALUES("-06:00");
INSERT INTO HusoHorario VALUES("-05:00");
INSERT INTO HusoHorario VALUES("-04:30");
INSERT INTO HusoHorario VALUES("-04:00");
INSERT INTO HusoHorario VALUES("-03:30");
INSERT INTO HusoHorario VALUES("-03:00");
INSERT INTO HusoHorario VALUES("-02:00");
INSERT INTO HusoHorario VALUES("-01:00");
INSERT INTO HusoHorario VALUES("00:00");
INSERT INTO HusoHorario VALUES("01:00");
INSERT INTO HusoHorario VALUES("02:00");
INSERT INTO HusoHorario VALUES("03:00");
INSERT INTO HusoHorario VALUES("03:30");
INSERT INTO HusoHorario VALUES("04:00");
INSERT INTO HusoHorario VALUES("04:30");
INSERT INTO HusoHorario VALUES("05:00");
INSERT INTO HusoHorario VALUES("05:30");
INSERT INTO HusoHorario VALUES("05:45");
INSERT INTO HusoHorario VALUES("06:00");
INSERT INTO HusoHorario VALUES("06:30");
INSERT INTO HusoHorario VALUES("07:00");
INSERT INTO HusoHorario VALUES("08:00");
INSERT INTO HusoHorario VALUES("08:45");
INSERT INTO HusoHorario VALUES("09:00");
INSERT INTO HusoHorario VALUES("09:30");
INSERT INTO HusoHorario VALUES("10:00");
INSERT INTO HusoHorario VALUES("10:30");
INSERT INTO HusoHorario VALUES("11:00");
INSERT INTO HusoHorario VALUES("11:30");
INSERT INTO HusoHorario VALUES("12:00");
INSERT INTO HusoHorario VALUES("12:45");
INSERT INTO HusoHorario VALUES("13:00");
INSERT INTO HusoHorario VALUES("14:00");

/*
*******************************************************
*							  		*
*				CATEGORIAS 				*
*									*
*******************************************************
*/

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';

/* La categoria 'Inicio' es hija de ella misma */
SELECT CategoriaCrear('Inicio', -1) INTO @CategoriaRaiz;
UPDATE Categoria SET HijoDeCategoria = @CategoriaRaiz WHERE CategoriaID = @CategoriaRaiz;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

/* Hay que agregarle las subdivisiones (mas adelante) */
SELECT CategoriaCrear('Libros', 				@CategoriaRaiz) INTO @bobo;
SELECT CategoriaCrear('Computadoras', 			@CategoriaRaiz) INTO @bobo;
SELECT CategoriaCrear('Electronica', 			@CategoriaRaiz) INTO @bobo;
SELECT CategoriaCrear('Salud y farmacia', 		@CategoriaRaiz) INTO @bobo;
SELECT CategoriaCrear('Juguetes y niños', 		@CategoriaRaiz) INTO @bobo;
SELECT CategoriaCrear('Ropa y calzado', 			@CategoriaRaiz) INTO @bobo;
SELECT CategoriaCrear('Joyas', 				@CategoriaRaiz) INTO @bobo;
SELECT CategoriaCrear('Deportes y entretenimiento', 	@CategoriaRaiz) INTO @bobo;
SELECT CategoriaCrear('Ferreterias y materiales', 	@CategoriaRaiz) INTO @bobo;
SELECT CategoriaCrear('Automotriz e industrial', 	@CategoriaRaiz) INTO @bobo;
SELECT CategoriaCrear('No asignada', 			@CategoriaRaiz) INTO @bobo;


/*
*************************************************************
*							  			*
*				ADMINISTRADOR				*
*										*
*************************************************************
*/

/* Las condiciones de borde (el primero y el ultimo) siempre joden. En este caso, el primer administrador... */

SELECT UsuarioCrear (
	NULL, 
	'admin@netzuela.com', 
	'1asdXzp91'
) INTO @UsuarioID;

INSERT INTO Rastreable VALUES (
	NULL,
	NOW(), 1,
	NOW(), 1,
	NULL, NULL,
	NOW(), 1
);

SELECT LAST_INSERT_ID() INTO @RastreableID;

INSERT INTO Administrador VALUES (
	@RastreableID,
	@UsuarioID,
	NULL,
	'Activo',
	'Todos',
	'Nestor',
	'Bohorquez'
);

SET @Creador = @RastreableID;

/*
*******************************************************
*							  		*
*			REGIONES GEOGRAFICAS 			*
*									*
*******************************************************
*/

/* 
   Se crean solo las regiones geograficas necesarias para representar 
   completamente a las parroquias de Cabimas
*/

/* Continentes del mundo */
SELECT ContinenteCrear(@Creador, 'Africa', 	1000000000) INTO @bobo;

SELECT ContinenteCrear(@Creador, 'America', 	910717000) INTO @AmericaID;
SELECT ContinenteCrear(@Creador, 'Asia', 		3879000000) INTO @bobo;
SELECT ContinenteCrear(@Creador, 'Europa', 	739000000) INTO @bobo;
SELECT ContinenteCrear(@Creador, 'Oceania', 	33000000) INTO @bobo;

/* Es necesario crear Caracas D.C. para poder definir a Venezuela */
SELECT CiudadCrear(@Creador, 'Caracas D.C.', 	2109166) INTO @CaracasID;
SELECT CiudadCrear(@Creador, 'Maracaibo', 	1897655) INTO @MaracaiboID;

SELECT PaisCrear (
	@Creador, 
	'Venezuela', 
	28892735, 
	@AmericaID, 
	@CaracasID, 
	'Español', 
	'Bolívar', 
	4.30, 326498000000
) INTO @VenezuelaID;

SELECT EstadoCrear(@Creador, 'Zulia', 3887171, @VenezuelaID, '-04:30', NULL) INTO @ZuliaID;

/* Municipios del Zulia */
SELECT MunicipioCrear(@Creador, 'Almirante Padilla', 		9030, 	@ZuliaID, 		NULL) 		INTO @bobo;
SELECT MunicipioCrear(@Creador, 'Baralt', 			80000, 	@ZuliaID, 		NULL) 		INTO @bobo;
SELECT MunicipioCrear(@Creador, 'Cabimas', 			273183, 	@ZuliaID, 		NULL) 		INTO @CabimasID;
SELECT MunicipioCrear(@Creador, 'Catatumbo', 			31780, 	@ZuliaID, 		NULL) 		INTO @bobo;
SELECT MunicipioCrear(@Creador, 'Colon', 				107821, 	@ZuliaID, 		NULL) 		INTO @bobo;
SELECT MunicipioCrear(@Creador, 'Francisco Javier Pulgar', 	29208, 	@ZuliaID, 		NULL) 		INTO @bobo;
SELECT MunicipioCrear(@Creador, 'Jesus Enrique Lossada', 	83458, 	@ZuliaID, 		NULL) 		INTO @bobo;
SELECT MunicipioCrear(@Creador, 'Jesus Maria Semprun', 	23972, 	@ZuliaID, 		NULL) 		INTO @bobo;
SELECT MunicipioCrear(@Creador, 'La Canada de Urdaneta', 	61527, 	@ZuliaID, 		NULL) 		INTO @bobo;
SELECT MunicipioCrear(@Creador, 'Lagunillas', 			169400, 	@ZuliaID, 		NULL) 		INTO @bobo;
SELECT MunicipioCrear(@Creador, 'Machiques de Perija', 	93154, 	@ZuliaID, 		NULL) 		INTO @bobo;
SELECT MunicipioCrear(@Creador, 'Mara', 				155918, 	@ZuliaID, 		NULL) 		INTO @bobo;
SELECT MunicipioCrear(@Creador, 'Maracaibo', 			1495199, 	@ZuliaID, 		@MaracaiboID) 	INTO @bobo;	/* <-- Forma parte de la ciudad de Maracaibo */
SELECT MunicipioCrear(@Creador, 'Miranda', 			82500, 	@ZuliaID, 		NULL) 		INTO @bobo;
SELECT MunicipioCrear(@Creador, 'Guajira', 			105000, 	@ZuliaID, 		NULL) 		INTO @bobo;
SELECT MunicipioCrear(@Creador, 'Rosario de Perija', 		67172, 	@ZuliaID, 		NULL) 		INTO @bobo;
SELECT MunicipioCrear(@Creador, 'San Francisco', 		424314, 	@ZuliaID, 		@MaracaiboID) 	INTO @bobo;	/* <-- Forma parte de la ciudad de Maracaibo */
SELECT MunicipioCrear(@Creador, 'Santa Rita', 			76304, 	@ZuliaID, 		NULL) 		INTO @bobo;
SELECT MunicipioCrear(@Creador, 'Simon Bolivar', 		50000, 	@ZuliaID, 		NULL) 		INTO @bobo;
SELECT MunicipioCrear(@Creador, 'Sucre', 				57396, 	@ZuliaID, 		NULL) 		INTO @bobo;
SELECT MunicipioCrear(@Creador, 'Valmore Rodriguez', 		55000, 	@ZuliaID, 		NULL) 		INTO @bobo;

/* Parroquias de Cabimas */
SELECT ParroquiaCrear(@Creador, 'Ambrosio', 			40768, 	@CabimasID, 	'4013') 		INTO @bobo;
SELECT ParroquiaCrear(@Creador, 'Aristides Calvani', 		40768, 	@CabimasID, 	'4013') 		INTO @bobo;
SELECT ParroquiaCrear(@Creador, 'Carmen Herrera', 		27194, 	@CabimasID, 	'4013') 		INTO @bobo;
SELECT ParroquiaCrear(@Creador, 'German Rios Linares', 	44155, 	@CabimasID, 	'4013') 		INTO @bobo;
SELECT ParroquiaCrear(@Creador, 'Jorge Hernandez', 		27559, 	@CabimasID, 	'4013') 		INTO @bobo;
SELECT ParroquiaCrear(@Creador, 'La Rosa', 			25128, 	@CabimasID, 	'4013') 		INTO @bobo;
SELECT ParroquiaCrear(@Creador, 'Punta Gorda', 			10224, 	@CabimasID, 	'4013') 		INTO @bobo;
SELECT ParroquiaCrear(@Creador, 'Romulo Betancourt', 		25225, 	@CabimasID, 	'4013') 		INTO @bobo;
SELECT ParroquiaCrear(@Creador, 'San Benito', 			51501, 	@CabimasID, 	'4013') 		INTO @bobo;