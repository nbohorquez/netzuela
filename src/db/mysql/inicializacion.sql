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
INSERT INTO idioma VALUES("Mandarin");

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
INSERT INTO grado_de_instruccion VALUES("Primaria", 1);
INSERT INTO grado_de_instruccion VALUES("Secundaria", 2);
INSERT INTO grado_de_instruccion VALUES("Tecnico Medio", 3);
INSERT INTO grado_de_instruccion VALUES("Tecnico Superior", 4);
INSERT INTO grado_de_instruccion VALUES("Universitaria", 5);
INSERT INTO grado_de_instruccion VALUES("Especializacion", 6);
INSERT INTO grado_de_instruccion VALUES("Maestria", 7);
INSERT INTO grado_de_instruccion VALUES("Doctorado", 8);

SELECT 'visibilidad';
INSERT INTO visibilidad VALUES("Ninguno visible");
INSERT INTO visibilidad VALUES("Cantidad visible");
INSERT INTO visibilidad VALUES("Precio visible");
INSERT INTO visibilidad VALUES("Ambos visibles");

SELECT 'accion';
INSERT INTO accion VALUES("Insertar");
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
INSERT INTO dia VALUES("Lunes", 1);
INSERT INTO dia VALUES("Martes", 2);
INSERT INTO dia VALUES("Miercoles", 3);
INSERT INTO dia VALUES("Jueves", 4);
INSERT INTO dia VALUES("Viernes", 5);
INSERT INTO dia VALUES("Sabado", 6);
INSERT INTO dia VALUES("Domingo", 7);

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
SELECT InsertarEtiquetable() INTO @Etiquetable_P;
SELECT '0.00.00.00.00.00' INTO @Cat_0000;
INSERT INTO categoria VALUES (@Etiquetable_P, '0.00.00.00.00.00', 'Inicio', '0.00.00.00.00.00');

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

/* Contraseña = 1asdXzp91 */
SELECT InsertarAdministrador (
    1, NULL,
    'admin@netzuela.com', 
    '$2a$12$MOM8uMGo9XmH1BDYPrTns.k/WLl6vt45qeKEXn5ZqoiBsQeBMfTQG',
    'Activo', 
    'Todos', 
    'Nestor',
    'Bohorquez'
) INTO @Creador;

/*
*********************************************************
*                                                     	*
*						TERRITORIOS						*
*														*
*********************************************************
*/

/* 
   Se crean solo los terriotorios del estado Zulia
*/

/* Insertamos al planeta Tierra primero */
SELECT 'mundo';
SELECT InsertarDibujable() INTO @Dibujable_P;
SELECT InsertarRastreable(@Creador) INTO @Rastreable_P;
SELECT '0.00.00.00.00.00' INTO @Mundo;
INSERT INTO territorio VALUES (@Rastreable_P, @Dibujable_P, @Mundo, 'La Tierra', 0,	'Mandarin',	0, @Mundo, 0, 0, NULL, '', 0);

SELECT InsertarTiendasConsumidores(@Mundo, 0, 0);

/* Esta tabla la vamos a usar para colocar temporalmente los puntos de los poligonos/croquis */
DROP TEMPORARY TABLE IF EXISTS puntos;
CREATE TEMPORARY TABLE puntos (
	`latitud` DECIMAL(9,6) NOT NULL,
	`longitud` DECIMAL(9,6) NOT NULL
) ENGINE=MyISAM;

SELECT 'paises';
SELECT InsertarPais (
	@Creador, 
	'Venezuela', 
    0,
	'Espanol',
	'', 
	326498000000
) INTO @pyVenezuela;

SELECT t.dibujable_p
FROM territorio AS t
WHERE t.territorio_id = @pyVenezuela COLLATE latin1_spanish_ci
INTO @VenezuelaDibujable;
SELECT InsertarCroquis(@Creador, @VenezuelaDibujable) INTO @VenezuelaCroquis;

DELETE FROM puntos;
INSERT INTO puntos VALUES
(5.178482,-60.688477), (4.937724,-60.578613), (4.67498,-60.864258), (4.499762,-60.974121), (4.54357,-61.303711), (4.455951,-61.259766),
(4.390229,-61.501465), (4.258768,-61.743164), (4.127285,-61.918945), (4.105369,-62.116699), (4.171115,-62.468262), (4.017699,-62.709961),
(3.710782,-62.731934), (3.623071,-62.973633), (3.93002,-63.215332), (3.973861,-63.413086), (3.864255,-63.479004), (3.93002,-63.632812),
(3.951941,-63.830566), (3.842332,-63.984375), (4.105369,-64.116211), (4.127285,-64.555664), (4.258768,-64.819336), (3.776559,-64.489746),
(3.623071,-64.182129), (3.469557,-64.248047), (3.184394,-64.204102), (2.723583,-63.984375), (2.482133,-64.072266), (2.416276,-63.391113),
(2.196727,-63.369141), (1.955187,-63.984375), (1.647722,-64.072266), (1.428075,-64.379883), (1.493971,-64.401855), (1.252342,-64.709473),
(1.120534,-65.01709), (1.120534,-65.148926), (0.900842,-65.214844), (0.922812,-65.324707), (0.659165,-65.522461), (0.98872,-65.522461),
(0.966751,-65.786133), (0.812961,-66.027832), (0.747049,-66.269531), (1.186439,-66.84082), (2.262595,-67.192383), (2.767478,-67.587891),
(2.855263,-67.851562), (3.316018,-67.346191), (3.754634,-67.478027), (3.732708,-67.565918), (4.236856,-67.785645), (4.412137,-67.763672),
(4.54357,-67.82959), (4.981505,-67.785645), (5.266008,-67.851562), (5.50664,-67.609863), (5.747174,-67.631836), (6.009459,-67.368164),
(6.227934,-67.5), (6.293459,-67.82959), (6.184246,-67.983398),  (6.118708,-68.532715), (6.20609,-69.060059), (6.053161,-69.257812),
(6.09686,-69.411621), (6.926427,-70.070801), (6.904614,-70.268555), (7.057282,-70.576172), (7.057282,-70.905762), (6.948239,-71.015625),
(7.013668,-72.004395), (7.340675,-72.158203), (7.427837,-72.443848), (7.993957,-72.443848), (8.015716,-72.355957), (8.363693,-72.37793),
(8.602747,-72.641602), (9.123792,-72.773437), (9.264779,-73.037109), (9.18887,-73.344727), (9.838979,-72.927246), (9.903921,-72.971191),
(10.401378,-72.905273), (11.070603,-72.487793), (11.135287,-72.251587), (11.641476,-71.971436), (11.840471,-71.328735), (11.732924,-71.367187),
(11.593051,-71.954956), (11.275387,-71.905518), (10.984335,-71.586914), (10.984335,-71.773682), (10.736175,-71.641846), (10.660608,-71.575928),
(10.466206,-71.619873), (10.09867,-71.905518), (9.828154,-72.125244), (9.665738,-72.015381), (9.503244,-71.993408), (9.373193,-71.71875),
(9.058702,-71.71875), (9.134639,-71.268311), (9.351513,-71.05957), (9.838979,-71.092529), (10.325728,-71.466064), (10.790141,-71.5979),
(10.822515,-71.444092), (10.898042,-71.422119), (10.941192,-71.520996), (11.18918,-70.85083), (11.501557,-70.070801), (11.415418,-69.807129),
(11.480025,-69.719238), (11.673755,-69.807129), (11.587669,-70.202637), (11.845847,-70.3125), (12.082296,-70.224609), (12.189704,-70.026855),
(12.103781,-69.873047), (11.759815,-69.763184), (11.480025,-69.631348), (11.523088,-69.23584), (11.415418,-68.840332), (11.156845,-68.422852),
(10.876465,-68.203125), (10.790141,-68.291016), (10.509417,-68.126221), (10.617418,-67.016602), (10.617418,-66.335449), (10.649811,-66.236572),
(10.563422,-66.027832), (10.509417,-66.115723), (10.077037,-65.192871), (10.141932,-64.6875), (10.401378,-64.182129), (10.466206,-63.676758),
(10.574222,-64.27002), (10.660608,-63.808594), (10.682201,-63.215332), (10.746969,-62.753906), (10.682201,-62.270508), (10.703792,-61.896973),
(10.552622,-62.248535), (10.53102,-62.819824), (9.925566,-62.358398), (10.033767,-62.226562), (9.838979,-61.611328), (9.449062,-60.820312), 
(9.18887,-60.776367), (8.581021,-60.600586), (8.581021,-60.073242), (8.320212,-59.853516), (7.798079,-60.46875), (7.493196,-60.688477), 
(7.144499,-60.512695), (7.144499,-60.292969), (6.926427,-60.292969), (6.664608,-61.12793), (6.489983,-61.12793), (6.271618,-61.12793),
(5.922045,-61.347656), (5.178482,-60.688477);
CALL InsertarPuntos(@VenezuelaCroquis);
/*
SOURCE ~/netzuela/spuria/src/db/mysql/mapas/division.sql
SOURCE ~/netzuela/spuria/src/db/mysql/mapas/poligonos.sql
*/
