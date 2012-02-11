SELECT 'Inicializacion.sql';
USE `Spuria`;

/*
*************************************************************
*							  			                                      *
*			                TABLAS DE BUSQUEDA				            *
*										                                        *
*************************************************************
*/

SELECT 'CodigoDeError';
/* Estos codigos son inventados... todavia no se ha fijado su utilidad */
INSERT INTO CodigoDeError VALUES("OK");
INSERT INTO CodigoDeError VALUES("Privilegios insuficientes");
INSERT INTO CodigoDeError VALUES("Accion imposible");

SELECT 'Privilegios';
/* Estos codigos son inventados... todavia no se ha fijado su utilidad */
INSERT INTO Privilegios VALUES("Todos");
INSERT INTO Privilegios VALUES("Ninguno");

SELECT 'Idioma';
INSERT INTO Idioma VALUES("Espanol");
INSERT INTO Idioma VALUES("English");
INSERT INTO Idioma VALUES("Francais");
INSERT INTO Idioma VALUES("Deutsch");

SELECT 'TipoDeCodigo';
/* Hay que considerar tambien otros codigos que no contempla GS-1 como los automotrices */
INSERT INTO TipoDeCodigo VALUES("GTIN-13");
INSERT INTO TipoDeCodigo VALUES("GTIN-8");
INSERT INTO TipoDeCodigo VALUES("GTIN-14");
INSERT INTO TipoDeCodigo VALUES("GS1-128");
INSERT INTO TipoDeCodigo VALUES("Otro");

SELECT 'Sexo';
INSERT INTO Sexo VALUES("Hombre");
INSERT INTO Sexo VALUES("Mujer");

SELECT 'GradoDeInstruccion';
INSERT INTO GradoDeInstruccion VALUES("Primaria");
INSERT INTO GradoDeInstruccion VALUES("Secundia");
INSERT INTO GradoDeInstruccion VALUES("Tecnico Medio");
INSERT INTO GradoDeInstruccion VALUES("Tecnico Superior");
INSERT INTO GradoDeInstruccion VALUES("Universitaria");
INSERT INTO GradoDeInstruccion VALUES("Especializacion");
INSERT INTO GradoDeInstruccion VALUES("Maestria");
INSERT INTO GradoDeInstruccion VALUES("Doctorado");

SELECT 'Visibilidad';
INSERT INTO Visibilidad VALUES("Ninguno visible");
INSERT INTO Visibilidad VALUES("Cantidad visible");
INSERT INTO Visibilidad VALUES("Precio visible");
INSERT INTO Visibilidad VALUES("Ambos visibles");

SELECT 'Accion';
INSERT INTO Accion VALUES("Crear");
INSERT INTO Accion VALUES("Abrir");
INSERT INTO Accion VALUES("Actualizar");
INSERT INTO Accion VALUES("Eliminar");
INSERT INTO Accion VALUES("Bloquear");
INSERT INTO Accion VALUES("Abrir sesion");
INSERT INTO Accion VALUES("Cerrar sesion");

SELECT 'Calificacion';
INSERT INTO Calificacion VALUES("Bien");
INSERT INTO Calificacion VALUES("Mal");

SELECT 'GrupoDeEdad';
INSERT INTO GrupoDeEdad VALUES("Adolescentes");
INSERT INTO GrupoDeEdad VALUES("Adultos jovenes");
INSERT INTO GrupoDeEdad VALUES("Adultos maduros");
INSERT INTO GrupoDeEdad VALUES("Adultos mayores");
INSERT INTO GrupoDeEdad VALUES("Tercera edad");

SELECT 'Estatus';
INSERT INTO Estatus VALUES("Activo");
INSERT INTO Estatus VALUES("Bloqueado");
INSERT INTO Estatus VALUES("Eliminado");

SELECT 'Dia';
INSERT INTO Dia VALUES("Lunes");
INSERT INTO Dia VALUES("Martes");
INSERT INTO Dia VALUES("Miercoles");
INSERT INTO Dia VALUES("Jueves");
INSERT INTO Dia VALUES("Viernes");
INSERT INTO Dia VALUES("Sabado");
INSERT INTO Dia VALUES("Domingo");

SELECT 'HusoHorario';
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
*							  		                                  *
*				                CATEGORIAS 				            *
*									                                    *
*******************************************************
*/

SELECT 'Categorias';

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';

/* La categoria 'Inicio' es hija de ella misma */
SELECT InsertarCategoria('Inicio', -1) INTO @CategoriaRaiz;
UPDATE Categoria SET HijoDeCategoria = @CategoriaRaiz WHERE CategoriaID = @CategoriaRaiz;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

/* Hay que agregarle las subdivisiones (mas adelante) */
SELECT InsertarCategoria('Libros', @CategoriaRaiz) INTO @bobo;
SELECT InsertarCategoria('Computadoras', @CategoriaRaiz) INTO @bobo;
SELECT InsertarCategoria('Electronica', @CategoriaRaiz) INTO @bobo;
SELECT InsertarCategoria('Salud y farmacia', @CategoriaRaiz) INTO @bobo;
SELECT InsertarCategoria('Juguetes y niños', @CategoriaRaiz) INTO @bobo;
SELECT InsertarCategoria('Ropa y calzado', @CategoriaRaiz) INTO @bobo;
SELECT InsertarCategoria('Joyas', @CategoriaRaiz) INTO @bobo;
SELECT InsertarCategoria('Deportes y entretenimiento', @CategoriaRaiz) INTO @bobo;
SELECT InsertarCategoria('Ferreterias y materiales', @CategoriaRaiz) INTO @bobo;
SELECT InsertarCategoria('Automotriz e industrial', @CategoriaRaiz) INTO @bobo;
SELECT InsertarCategoria('No asignada', @CategoriaRaiz) INTO @bobo;

/*
*************************************************************
*							  			                                      *
*				                ADMINISTRADOR				                *
*										                                        *
*************************************************************
*/

SELECT 'Administrador';

/* Las condiciones de borde (el primero y el ultimo) siempre joden. En este caso, el primer administrador... */

SELECT InsertarUsuario (
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
*                                                     *
*			            REGIONES GEOGRAFICAS 			          *
*									                                    *
*******************************************************
*/

/* 
   Se crean solo las regiones geograficas necesarias para representar 
   completamente a las parroquias de Cabimas
*/

SELECT 'Continentes';
/* Continentes del mundo */
SELECT InsertarContinente(@Creador, 'Africa', 1000000000) INTO @bobo;
SELECT InsertarContinente(@Creador, 'America', 910717000) INTO @AmericaID;
SELECT InsertarContinente(@Creador, 'Asia', 3879000000) INTO @bobo;
SELECT InsertarContinente(@Creador, 'Europa', 739000000) INTO @bobo;
SELECT InsertarContinente(@Creador, 'Oceania', 33000000) INTO @bobo;

SELECT 'Ciudades';
/* Es necesario crear Caracas D.C. para poder definir a Venezuela */
SELECT InsertarCiudad(@Creador, 'Caracas D.C.', 2109166) INTO @CaracasID;
SELECT InsertarCiudad(@Creador, 'Maracaibo', 1897655) INTO @MaracaiboID;

SELECT 'Paises';
SELECT InsertarPais (
    @Creador, 
    'Venezuela', 
    28892735, 
    @AmericaID, 
    @CaracasID, 
    'Espanol', 
    'Bolivar', 
    4.30, 326498000000
) INTO @VenezuelaID;

SELECT 'Estados';
SELECT InsertarEstado(@Creador, 'Zulia', 3887171, @VenezuelaID, '-04:30', NULL) INTO @ZuliaID;

SELECT 'Municipios';
/* Municipios del Zulia */
SELECT InsertarMunicipio(@Creador, 'Almirante Padilla',         9030,       @ZuliaID, NULL) INTO @bobo;
SELECT InsertarMunicipio(@Creador, 'Baralt',                    80000,      @ZuliaID, NULL) INTO @bobo;
SELECT InsertarMunicipio(@Creador, 'Cabimas',                   273183,     @ZuliaID, NULL) INTO @CabimasID;
SELECT InsertarMunicipio(@Creador, 'Catatumbo',                 31780,      @ZuliaID, NULL) INTO @bobo;
SELECT InsertarMunicipio(@Creador, 'Colon',                     107821,     @ZuliaID, NULL) INTO @bobo;
SELECT InsertarMunicipio(@Creador, 'Francisco Javier Pulgar',   29208,      @ZuliaID, NULL) INTO @bobo;
SELECT InsertarMunicipio(@Creador, 'Jesus Enrique Lossada',     83458,      @ZuliaID, NULL) INTO @bobo;
SELECT InsertarMunicipio(@Creador, 'Jesus Maria Semprun', 	    23972,      @ZuliaID, NULL) INTO @bobo;
SELECT InsertarMunicipio(@Creador, 'La Canada de Urdaneta',     61527, 	    @ZuliaID, NULL) INTO @bobo;
SELECT InsertarMunicipio(@Creador, 'Lagunillas',                169400,     @ZuliaID, NULL) INTO @bobo;
SELECT InsertarMunicipio(@Creador, 'Machiques de Perija', 	    93154, 	    @ZuliaID, NULL) INTO @bobo;
SELECT InsertarMunicipio(@Creador, 'Mara',                      155918,     @ZuliaID, NULL) INTO @bobo;
SELECT InsertarMunicipio(@Creador, 'Maracaibo',                 1495199,    @ZuliaID, @MaracaiboID) INTO @bobo;	/* <-- Forma parte de la ciudad de Maracaibo */
SELECT InsertarMunicipio(@Creador, 'Miranda', 			            82500, 	    @ZuliaID, NULL) INTO @bobo;
SELECT InsertarMunicipio(@Creador, 'Guajira', 			            105000,     @ZuliaID, NULL) INTO @bobo;
SELECT InsertarMunicipio(@Creador, 'Rosario de Perija',         67172,      @ZuliaID, NULL) INTO @bobo;
SELECT InsertarMunicipio(@Creador, 'San Francisco',             424314,     @ZuliaID, @MaracaiboID) INTO @bobo;	/* <-- Forma parte de la ciudad de Maracaibo */
SELECT InsertarMunicipio(@Creador, 'Santa Rita',                76304,      @ZuliaID, NULL) INTO @bobo;
SELECT InsertarMunicipio(@Creador, 'Simon Bolivar',             50000,      @ZuliaID, NULL) INTO @bobo;
SELECT InsertarMunicipio(@Creador, 'Sucre',                     57396,      @ZuliaID, NULL) INTO @bobo;
SELECT InsertarMunicipio(@Creador, 'Valmore Rodriguez',         55000,      @ZuliaID, NULL) INTO @bobo;

SELECT 'Parroquias';
/* Parroquias de Cabimas */
SELECT InsertarParroquia(@Creador, 'Ambrosio',              40768, @CabimasID, '4013') INTO @bobo;
SELECT InsertarParroquia(@Creador, 'Aristides Calvani', 		40768, @CabimasID, '4013') INTO @bobo;
SELECT InsertarParroquia(@Creador, 'Carmen Herrera',        27194, @CabimasID, '4013') INTO @bobo;
SELECT InsertarParroquia(@Creador, 'German Rios Linares', 	44155, @CabimasID, '4013') INTO @bobo;
SELECT InsertarParroquia(@Creador, 'Jorge Hernandez',       27559, @CabimasID, '4013') INTO @bobo;
SELECT InsertarParroquia(@Creador, 'La Rosa', 			        25128, @CabimasID, '4013') INTO @bobo;
SELECT InsertarParroquia(@Creador, 'Punta Gorda', 			    10224, @CabimasID, '4013') INTO @bobo;
SELECT InsertarParroquia(@Creador, 'Romulo Betancourt', 		25225, @CabimasID, '4013') INTO @bobo;
SELECT InsertarParroquia(@Creador, 'San Benito',            51501, @CabimasID, '4013') INTO @bobo;