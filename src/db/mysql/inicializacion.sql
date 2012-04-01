SELECT 'inicializacion.sql';
USE `spuria`;

/*
*************************************************************
*							  			                    *
*						TABLAS DE BUSQUEDA					*
*										                    *
*************************************************************
*/

SELECT 'codigo_de_error';
/* Estos codigos son inventados... todavia no se ha fijado su utilidad */
INSERT INTO codigo_de_error VALUES("OK");
INSERT INTO codigo_de_error VALUES("Privilegios insuficientes");
INSERT INTO codigo_de_error VALUES("Accion imposible");

SELECT 'privilegios';
/* Estos codigos son inventados... todavia no se ha fijado su utilidad */
INSERT INTO privilegios VALUES("Todos");
INSERT INTO privilegios VALUES("Ninguno");

SELECT 'idioma';
INSERT INTO idioma VALUES("Espanol");
INSERT INTO idioma VALUES("English");
INSERT INTO idioma VALUES("Francais");
INSERT INTO idioma VALUES("Deutsch");

SELECT 'tipo_de_codigo';
/* Hay que considerar tambien otros codigos que no contempla GS-1 como los automotrices */
INSERT INTO tipo_de_codigo VALUES("GTIN-13");
INSERT INTO tipo_de_codigo VALUES("GTIN-8");
INSERT INTO tipo_de_codigo VALUES("GTIN-14");
INSERT INTO tipo_de_codigo VALUES("GS1-128");
INSERT INTO tipo_de_codigo VALUES("Otro");

SELECT 'sexo';
INSERT INTO sexo VALUES("Hombre");
INSERT INTO sexo VALUES("Mujer");

SELECT 'grado_de_instruccion';
INSERT INTO grado_de_instruccion VALUES("Primaria");
INSERT INTO grado_de_instruccion VALUES("Secundaria");
INSERT INTO grado_de_instruccion VALUES("Tecnico Medio");
INSERT INTO grado_de_instruccion VALUES("Tecnico Superior");
INSERT INTO grado_de_instruccion VALUES("Universitaria");
INSERT INTO grado_de_instruccion VALUES("Especializacion");
INSERT INTO grado_de_instruccion VALUES("Maestria");
INSERT INTO grado_de_instruccion VALUES("Doctorado");

SELECT 'visibilidad';
INSERT INTO visibilidad VALUES("Ninguno visible");
INSERT INTO visibilidad VALUES("Cantidad visible");
INSERT INTO visibilidad VALUES("Precio visible");
INSERT INTO visibilidad VALUES("Ambos visibles");

SELECT 'accion';
INSERT INTO accion VALUES("Crear");
INSERT INTO accion VALUES("Abrir");
INSERT INTO accion VALUES("Actualizar");
INSERT INTO accion VALUES("Eliminar");
INSERT INTO accion VALUES("Bloquear");
INSERT INTO accion VALUES("Abrir sesion");
INSERT INTO accion VALUES("Cerrar sesion");

SELECT 'calificacion';
INSERT INTO calificacion VALUES("Bien");
INSERT INTO calificacion VALUES("Mal");

SELECT 'grupo_de_edad';
INSERT INTO grupo_de_edad VALUES("Adolescentes");
INSERT INTO grupo_de_edad VALUES("Adultos jovenes");
INSERT INTO grupo_de_edad VALUES("Adultos maduros");
INSERT INTO grupo_de_edad VALUES("Adultos mayores");
INSERT INTO grupo_de_edad VALUES("Tercera edad");

SELECT 'estatus';
INSERT INTO estatus VALUES("Activo");
INSERT INTO estatus VALUES("Bloqueado");
INSERT INTO estatus VALUES("Eliminado");

SELECT 'dia';
INSERT INTO dia VALUES("Lunes");
INSERT INTO dia VALUES("Martes");
INSERT INTO dia VALUES("Miercoles");
INSERT INTO dia VALUES("Jueves");
INSERT INTO dia VALUES("Viernes");
INSERT INTO dia VALUES("Sabado");
INSERT INTO dia VALUES("Domingo");

SELECT 'huso_horario';
INSERT INTO huso_horario VALUES("-12:00");
INSERT INTO huso_horario VALUES("-11:00");
INSERT INTO huso_horario VALUES("-10:00");
INSERT INTO huso_horario VALUES("-09:30");
INSERT INTO huso_horario VALUES("-09:00");
INSERT INTO huso_horario VALUES("-08:00");
INSERT INTO huso_horario VALUES("-07:00");
INSERT INTO huso_horario VALUES("-06:00");
INSERT INTO huso_horario VALUES("-05:00");
INSERT INTO huso_horario VALUES("-04:30");
INSERT INTO huso_horario VALUES("-04:00");
INSERT INTO huso_horario VALUES("-03:30");
INSERT INTO huso_horario VALUES("-03:00");
INSERT INTO huso_horario VALUES("-02:00");
INSERT INTO huso_horario VALUES("-01:00");
INSERT INTO huso_horario VALUES("00:00");
INSERT INTO huso_horario VALUES("01:00");
INSERT INTO huso_horario VALUES("02:00");
INSERT INTO huso_horario VALUES("03:00");
INSERT INTO huso_horario VALUES("03:30");
INSERT INTO huso_horario VALUES("04:00");
INSERT INTO huso_horario VALUES("04:30");
INSERT INTO huso_horario VALUES("05:00");
INSERT INTO huso_horario VALUES("05:30");
INSERT INTO huso_horario VALUES("05:45");
INSERT INTO huso_horario VALUES("06:00");
INSERT INTO huso_horario VALUES("06:30");
INSERT INTO huso_horario VALUES("07:00");
INSERT INTO huso_horario VALUES("08:00");
INSERT INTO huso_horario VALUES("08:45");
INSERT INTO huso_horario VALUES("09:00");
INSERT INTO huso_horario VALUES("09:30");
INSERT INTO huso_horario VALUES("10:00");
INSERT INTO huso_horario VALUES("10:30");
INSERT INTO huso_horario VALUES("11:00");
INSERT INTO huso_horario VALUES("11:30");
INSERT INTO huso_horario VALUES("12:00");
INSERT INTO huso_horario VALUES("12:45");
INSERT INTO huso_horario VALUES("13:00");
INSERT INTO huso_horario VALUES("14:00");

/*
*********************************************************
*														*
*						CATEGORIAS						*
*														*
*********************************************************
*/

SELECT 'categorias';

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';

/* La categoria 'Inicio' es hija de ella misma */
SELECT InsertarCategoria('Inicio', -1) INTO @Cat_0000;
UPDATE categoria SET hijo_de_categoria = @Cat_0000 WHERE categoria_id = @Cat_0000;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

/* Hay que agregarle las subdivisiones (mas adelante) */
SELECT InsertarCategoria('Libros', @Cat_0000) INTO @Cat_1000;
SELECT InsertarCategoria('Novelas', @Cat_1000) INTO @Cat_1100;
SELECT InsertarCategoria('Poesia', @Cat_1000) INTO @Cat_1200;
SELECT InsertarCategoria('Tecnicos', @Cat_1000) INTO @Cat_1300;
SELECT InsertarCategoria('Negocios', @Cat_1000) INTO @Cat_1400;
SELECT InsertarCategoria('Cocina', @Cat_1000) INTO @Cat_1500;

SELECT InsertarCategoria('Computacion - Electronica', @Cat_0000) INTO @Cat_2000;
SELECT InsertarCategoria('Instrumentos musicales', @Cat_2000) INTO @Cat_2100;
SELECT InsertarCategoria('Consolas de videojuegos', @Cat_2000) INTO @Cat_2200;
SELECT InsertarCategoria('Juegos de video', @Cat_2000) INTO @Cat_2300;
SELECT InsertarCategoria('Procesadores', @Cat_2000) INTO @Cat_2400;
SELECT InsertarCategoria('Tarjetas madres', @Cat_2000) INTO @Cat_2500;
SELECT InsertarCategoria('Memorias', @Cat_2000) INTO @Cat_2600;
SELECT InsertarCategoria('Discos duros', @Cat_2000) INTO @Cat_2700;
SELECT InsertarCategoria('Camaras fotograficas', @Cat_2000) INTO @Cat_2800;
SELECT InsertarCategoria('Camaras de video', @Cat_2000) INTO @Cat_2900;
SELECT InsertarCategoria('Telefonos celulares', @Cat_2000) INTO @Cat_2A00;
SELECT InsertarCategoria('Computadoras de escritorio', @Cat_2000) INTO @Cat_2B00;
SELECT InsertarCategoria('Computadoras portatiles', @Cat_2000) INTO @Cat_2C00;

SELECT InsertarCategoria('Alimentos - Hogar', @Cat_0000) INTO @Cat_3000;
SELECT InsertarCategoria('Canasta basica', @Cat_3000) INTO @Cat_3100;
SELECT InsertarCategoria('Limpieza', @Cat_3000) INTO @Cat_3200;
SELECT InsertarCategoria('Aseo personal', @Cat_3000) INTO @Cat_3300;
SELECT InsertarCategoria('Viveres', @Cat_3000) INTO @Cat_3400;
SELECT InsertarCategoria('Carnes', @Cat_3000) INTO @Cat_3500;
SELECT InsertarCategoria('Enlatados', @Cat_3000) INTO @Cat_3600;

SELECT InsertarCategoria('Juguetes - Ninos', @Cat_0000) INTO @Cat_4000;
SELECT InsertarCategoria('Peluches', @Cat_4000) INTO @Cat_4100;
SELECT InsertarCategoria('Figuras de accion', @Cat_4000) INTO @Cat_4200;
SELECT InsertarCategoria('Munecas', @Cat_4000) INTO @Cat_4300;
SELECT InsertarCategoria('Trenes', @Cat_4000) INTO @Cat_4400;
SELECT InsertarCategoria('Aviones', @Cat_4000) INTO @Cat_4500;

SELECT InsertarCategoria('Ropa - Calzado', @Cat_0000) INTO @Cat_5000;
SELECT InsertarCategoria('Ropa para damas', @Cat_5000) INTO @Cat_5100;
SELECT InsertarCategoria('Ropa para caballeros', @Cat_5000) INTO @Cat_5200;
SELECT InsertarCategoria('Calzado para damas', @Cat_5000) INTO @Cat_5300;
SELECT InsertarCategoria('Calzado para caballeros', @Cat_5000) INTO @Cat_5400;

SELECT InsertarCategoria('Deportes - Aire libre', @Cat_0000) INTO @Cat_6000;
SELECT InsertarCategoria('Futbol', @Cat_6000) INTO @Cat_6100;
SELECT InsertarCategoria('Baloncesto', @Cat_6000) INTO @Cat_6200;
SELECT InsertarCategoria('Tenis', @Cat_6000) INTO @Cat_6300;
SELECT InsertarCategoria('Rugby', @Cat_6000) INTO @Cat_6400;
SELECT InsertarCategoria('Beisbol', @Cat_6000) INTO @Cat_6500;
SELECT InsertarCategoria('Rapel', @Cat_6000) INTO @Cat_6600;
SELECT InsertarCategoria('Montanismo', @Cat_6000) INTO @Cat_6700;

SELECT InsertarCategoria('Ferreterias', @Cat_0000) INTO @Cat_7000;
SELECT InsertarCategoria('Herramientas electricas', @Cat_7000) INTO @Cat_7100;
SELECT InsertarCategoria('Construccion', @Cat_7000) INTO @Cat_7200;
SELECT InsertarCategoria('Herramientas manuales', @Cat_7000) INTO @Cat_7300;
SELECT InsertarCategoria('Pinturas', @Cat_7000) INTO @Cat_7400;
SELECT InsertarCategoria('Lamparas', @Cat_7000) INTO @Cat_7500;
SELECT InsertarCategoria('Electricidad', @Cat_7000) INTO @Cat_7600;

SELECT InsertarCategoria('Automotriz - Industrial', @Cat_0000) INTO @Cat_8000;
SELECT InsertarCategoria('Motores', @Cat_8000) INTO @Cat_8100;
SELECT InsertarCategoria('Alternadores', @Cat_8000) INTO @Cat_8200;
SELECT InsertarCategoria('Autoperiquitos', @Cat_8000) INTO @Cat_8300;
SELECT InsertarCategoria('Baterias', @Cat_8000) INTO @Cat_8400;

SELECT InsertarCategoria('No asignada', @Cat_0000) INTO @CategoriaNoAsignada;

/*
*************************************************************
*							  								*
*						ADMINISTRADOR		                *
*															*
*************************************************************
*/

SELECT 'administrador';

/* Las condiciones de borde (el primero y el ultimo) siempre joden. En este caso, el primer administrador... */

SELECT InsertarAdministrador (
    1, NULL,
    'admin@netzuela.com', 
    '1asdXzp91',
    'Activo', 
    'Todos', 
    'Nestor',
    'Bohorquez'
) INTO @Creador;

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

SELECT 'continentes';
/* Continentes del mundo */
SELECT InsertarContinente(@Creador, 'Africa', 1000000000);
SELECT InsertarContinente(@Creador, 'America', 910717000) INTO @AmericaID;
SELECT InsertarContinente(@Creador, 'Asia', 3879000000);
SELECT InsertarContinente(@Creador, 'Europa', 739000000);
SELECT InsertarContinente(@Creador, 'Oceania', 33000000);

SELECT 'ciudades';
/* Es necesario crear Caracas D.C. para poder definir a Venezuela */
SELECT InsertarCiudad(@Creador, 'Caracas D.C.', 2109166) INTO @CaracasID;
SELECT InsertarCiudad(@Creador, 'Maracaibo', 1897655) INTO @MaracaiboID;

SELECT 'paises';
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

SELECT 'estados';
SELECT InsertarEstado(@Creador, 'Zulia', 3887171, @VenezuelaID, '-04:30', NULL) INTO @ZuliaID;

SELECT 'municipios';
/* Municipios del Zulia */
SELECT InsertarMunicipio(@Creador, 'Almirante Padilla',         9030,       @ZuliaID, NULL);
SELECT InsertarMunicipio(@Creador, 'Baralt',                    80000,      @ZuliaID, NULL);
SELECT InsertarMunicipio(@Creador, 'Cabimas',                   273183,     @ZuliaID, NULL) INTO @CabimasID;
SELECT InsertarMunicipio(@Creador, 'Catatumbo',                 31780,      @ZuliaID, NULL);
SELECT InsertarMunicipio(@Creador, 'Colon',                     107821,     @ZuliaID, NULL);
SELECT InsertarMunicipio(@Creador, 'Francisco Javier Pulgar',   29208,      @ZuliaID, NULL);
SELECT InsertarMunicipio(@Creador, 'Jesus Enrique Lossada',     83458,      @ZuliaID, NULL);
SELECT InsertarMunicipio(@Creador, 'Jesus Maria Semprun', 	    23972,      @ZuliaID, NULL);
SELECT InsertarMunicipio(@Creador, 'La Canada de Urdaneta',     61527, 	    @ZuliaID, NULL);
SELECT InsertarMunicipio(@Creador, 'Lagunillas',                169400,     @ZuliaID, NULL);
SELECT InsertarMunicipio(@Creador, 'Machiques de Perija', 	    93154, 	    @ZuliaID, NULL);
SELECT InsertarMunicipio(@Creador, 'Mara',                      155918,     @ZuliaID, NULL);
SELECT InsertarMunicipio(@Creador, 'Maracaibo',                 1495199,    @ZuliaID, @MaracaiboID);	/* <-- Forma parte de la ciudad de Maracaibo */
SELECT InsertarMunicipio(@Creador, 'Miranda', 			            82500, 	    @ZuliaID, NULL);
SELECT InsertarMunicipio(@Creador, 'Guajira', 			            105000,     @ZuliaID, NULL);
SELECT InsertarMunicipio(@Creador, 'Rosario de Perija',         67172,      @ZuliaID, NULL);
SELECT InsertarMunicipio(@Creador, 'San Francisco',             424314,     @ZuliaID, @MaracaiboID);	/* <-- Forma parte de la ciudad de Maracaibo */
SELECT InsertarMunicipio(@Creador, 'Santa Rita',                76304,      @ZuliaID, NULL);
SELECT InsertarMunicipio(@Creador, 'Simon Bolivar',             50000,      @ZuliaID, NULL);
SELECT InsertarMunicipio(@Creador, 'Sucre',                     57396,      @ZuliaID, NULL);
SELECT InsertarMunicipio(@Creador, 'Valmore Rodriguez',         55000,      @ZuliaID, NULL);

SELECT 'parroquias';
/* Parroquias de Cabimas */
SELECT InsertarParroquia(@Creador, 'Ambrosio',              40768, @CabimasID, '4013') INTO @Ambrosio;

/* ¡El Administrador es de Ambrosio! */
UPDATE usuario
SET usuario.parroquia = @Ambrosio
WHERE usuario_id = 1;

SELECT InsertarParroquia(@Creador, 'Aristides Calvani', 		40768, @CabimasID, '4013');
SELECT InsertarParroquia(@Creador, 'Carmen Herrera',        27194, @CabimasID, '4013');
SELECT InsertarParroquia(@Creador, 'German Rios Linares', 	44155, @CabimasID, '4013');
SELECT InsertarParroquia(@Creador, 'Jorge Hernandez',       27559, @CabimasID, '4013');
SELECT InsertarParroquia(@Creador, 'La Rosa', 			        25128, @CabimasID, '4013');
SELECT InsertarParroquia(@Creador, 'Punta Gorda', 			    10224, @CabimasID, '4013');
SELECT InsertarParroquia(@Creador, 'Romulo Betancourt', 		25225, @CabimasID, '4013');
SELECT InsertarParroquia(@Creador, 'San Benito',            51501, @CabimasID, '4013');

