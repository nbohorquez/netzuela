SELECT 'Inicializacion.sql';
USE spuria;

/*
*************************************************************
*							  			                    *
*					  TABLAS DE BUSQUEDA				    *
*										                    *
*************************************************************
*/

SELECT 'CodigoDeError';
/* Estos codigos son inventados... todavia no se ha fijado su utilidad */
INSERT INTO CodigoDeError VALUES('OK');
INSERT INTO CodigoDeError VALUES('Privilegios insuficientes');
INSERT INTO CodigoDeError VALUES('Accion imposible');

SELECT 'Privilegios';
/* Estos codigos son inventados... todavia no se ha fijado su utilidad */
INSERT INTO Privilegios VALUES('Todos');
INSERT INTO Privilegios VALUES('Ninguno');

SELECT 'Idioma';
INSERT INTO Idioma VALUES('Espanol');
INSERT INTO Idioma VALUES('English');
INSERT INTO Idioma VALUES('Francais');
INSERT INTO Idioma VALUES('Deutsch');

SELECT 'TipoDeCodigo';
/* Hay que considerar tambien otros codigos que no contempla GS-1 como los automotrices */
INSERT INTO TipoDeCodigo VALUES('GTIN-13');
INSERT INTO TipoDeCodigo VALUES('GTIN-8');
INSERT INTO TipoDeCodigo VALUES('GTIN-14');
INSERT INTO TipoDeCodigo VALUES('GS1-128');
INSERT INTO TipoDeCodigo VALUES('Otro');

SELECT 'Sexo';
INSERT INTO Sexo VALUES('Hombre');
INSERT INTO Sexo VALUES('Mujer');

SELECT 'GradoDeInstruccion';
INSERT INTO GradoDeInstruccion VALUES('Primaria');
INSERT INTO GradoDeInstruccion VALUES('Secundia');
INSERT INTO GradoDeInstruccion VALUES('Tecnico Medio');
INSERT INTO GradoDeInstruccion VALUES('Tecnico Superior');
INSERT INTO GradoDeInstruccion VALUES('Universitaria');
INSERT INTO GradoDeInstruccion VALUES('Especializacion');
INSERT INTO GradoDeInstruccion VALUES('Maestria');
INSERT INTO GradoDeInstruccion VALUES('Doctorado');

SELECT 'Visibilidad';
INSERT INTO Visibilidad VALUES('Ninguno visible');
INSERT INTO Visibilidad VALUES('Cantidad visible');
INSERT INTO Visibilidad VALUES('Precio visible');
INSERT INTO Visibilidad VALUES('Ambos visibles');

SELECT 'Accion';
INSERT INTO Accion VALUES('Crear');
INSERT INTO Accion VALUES('Abrir');
INSERT INTO Accion VALUES('Actualizar');
INSERT INTO Accion VALUES('Eliminar');
INSERT INTO Accion VALUES('Bloquear');
INSERT INTO Accion VALUES('Abrir sesion');
INSERT INTO Accion VALUES('Cerrar sesion');

SELECT 'Calificacion';
INSERT INTO Calificacion VALUES('Bien');
INSERT INTO Calificacion VALUES('Mal');

SELECT 'GrupoDeEdad';
INSERT INTO GrupoDeEdad VALUES('Adolescentes');
INSERT INTO GrupoDeEdad VALUES('Adultos jovenes');
INSERT INTO GrupoDeEdad VALUES('Adultos maduros');
INSERT INTO GrupoDeEdad VALUES('Adultos mayores');
INSERT INTO GrupoDeEdad VALUES('Tercera edad');

SELECT 'Estatus';
INSERT INTO Estatus VALUES('Activo');
INSERT INTO Estatus VALUES('Bloqueado');
INSERT INTO Estatus VALUES('Eliminado');

SELECT 'Dia';
INSERT INTO Dia VALUES('Lunes');
INSERT INTO Dia VALUES('Martes');
INSERT INTO Dia VALUES('Miercoles');
INSERT INTO Dia VALUES('Jueves');
INSERT INTO Dia VALUES('Viernes');
INSERT INTO Dia VALUES('Sabado');
INSERT INTO Dia VALUES('Domingo');


SELECT 'HusoHorario';
/*
INSERT INTO HusoHorario VALUES(m2ss.maketime(-12,0,0));
INSERT INTO HusoHorario VALUES(m2ss.maketime(-11,0,0));
INSERT INTO HusoHorario VALUES(m2ss.maketime(-10,0,0));
INSERT INTO HusoHorario VALUES(m2ss.maketime(-9,30,0));
INSERT INTO HusoHorario VALUES(m2ss.maketime(-9,0,0));
INSERT INTO HusoHorario VALUES(m2ss.maketime(-8,0,0));
INSERT INTO HusoHorario VALUES(m2ss.maketime(-7,0,0));
INSERT INTO HusoHorario VALUES(m2ss.maketime(-6,0,0));
INSERT INTO HusoHorario VALUES(m2ss.maketime(-5,0,0));
INSERT INTO HusoHorario VALUES(m2ss.maketime(-4,30,0));
INSERT INTO HusoHorario VALUES(m2ss.maketime(-4,0,0));
INSERT INTO HusoHorario VALUES(m2ss.maketime(-3,30,0));
INSERT INTO HusoHorario VALUES(m2ss.maketime(-3,0,0));
INSERT INTO HusoHorario VALUES(m2ss.maketime(-2,0,0));
INSERT INTO HusoHorario VALUES(m2ss.maketime(-1,0,0));
*/
INSERT INTO HusoHorario VALUES(m2ss.maketime(0,0,0));
INSERT INTO HusoHorario VALUES(m2ss.maketime(1,0,0));
INSERT INTO HusoHorario VALUES(m2ss.maketime(2,0,0));
INSERT INTO HusoHorario VALUES(m2ss.maketime(3,0,0));
INSERT INTO HusoHorario VALUES(m2ss.maketime(3,30,0));
INSERT INTO HusoHorario VALUES(m2ss.maketime(4,0,0));
INSERT INTO HusoHorario VALUES(m2ss.maketime(4,30,0));
INSERT INTO HusoHorario VALUES(m2ss.maketime(5,0,0));
INSERT INTO HusoHorario VALUES(m2ss.maketime(5,30,0));
INSERT INTO HusoHorario VALUES(m2ss.maketime(5,45,0));
INSERT INTO HusoHorario VALUES(m2ss.maketime(6,0,0));
INSERT INTO HusoHorario VALUES(m2ss.maketime(6,30,0));
INSERT INTO HusoHorario VALUES(m2ss.maketime(7,0,0));
INSERT INTO HusoHorario VALUES(m2ss.maketime(8,0,0));
INSERT INTO HusoHorario VALUES(m2ss.maketime(8,45,0));
INSERT INTO HusoHorario VALUES(m2ss.maketime(9,0,0));
INSERT INTO HusoHorario VALUES(m2ss.maketime(9,30,0));
INSERT INTO HusoHorario VALUES(m2ss.maketime(10,0,0));
INSERT INTO HusoHorario VALUES(m2ss.maketime(10,30,0));
INSERT INTO HusoHorario VALUES(m2ss.maketime(11,0,0));
INSERT INTO HusoHorario VALUES(m2ss.maketime(11,30,0));
INSERT INTO HusoHorario VALUES(m2ss.maketime(12,0,0));
INSERT INTO HusoHorario VALUES(m2ss.maketime(12,45,0));
INSERT INTO HusoHorario VALUES(m2ss.maketime(13,0,0));
INSERT INTO HusoHorario VALUES(m2ss.maketime(14,0,0));

/*
INSERT INTO HusoHorario VALUES('-12:00:00');
INSERT INTO HusoHorario VALUES('-11:00:00'm2ss.maketime(-11,0,0));
INSERT INTO HusoHorario VALUES('-10:00:00'm2ss.maketime(-10,0,0));
INSERT INTO HusoHorario VALUES('-09:30:00'm2ss.maketime(-9,30,0));
INSERT INTO HusoHorario VALUES('-09:00:00'm2ss.maketime(-9,0,0));
INSERT INTO HusoHorario VALUES('-08:00:00'm2ss.maketime(-8,0,0));
INSERT INTO HusoHorario VALUES('-07:00:00'm2ss.maketime(-7,0,0));
INSERT INTO HusoHorario VALUES('-06:00:00'm2ss.maketime(-6,0,0));
INSERT INTO HusoHorario VALUES('-05:00:00'm2ss.maketime(-5,0,0));
INSERT INTO HusoHorario VALUES('-04:30:00'm2ss.maketime(-4,30,0));
INSERT INTO HusoHorario VALUES('-04:00:00'm2ss.maketime(-4,0,0));
INSERT INTO HusoHorario VALUES('-03:30:00'm2ss.maketime(-3,30,0));
INSERT INTO HusoHorario VALUES('-03:00:00'm2ss.maketime(-3,0,0));
INSERT INTO HusoHorario VALUES('-02:00:00'm2ss.maketime(-2,0,0));
INSERT INTO HusoHorario VALUES('-01:00:00'm2ss.maketime(-1,0,0));
INSERT INTO HusoHorario VALUES('00:00:00'm2ss.maketime(0,0,0));
INSERT INTO HusoHorario VALUES('01:00:00'm2ss.maketime(1,0,0));
INSERT INTO HusoHorario VALUES('02:00:00'm2ss.maketime(2,0,0));
INSERT INTO HusoHorario VALUES('03:00:00'm2ss.maketime(3,0,0));
INSERT INTO HusoHorario VALUES('03:30:00'm2ss.maketime(3,30,0));
INSERT INTO HusoHorario VALUES('04:00:00'm2ss.maketime(4,0,0));
INSERT INTO HusoHorario VALUES('04:30:00'm2ss.maketime(4,30,0));
INSERT INTO HusoHorario VALUES('05:00:00'm2ss.maketime(5,0,0));
INSERT INTO HusoHorario VALUES('05:30:00'm2ss.maketime(5,30,0));
INSERT INTO HusoHorario VALUES('04:45:00'm2ss.maketime(5,45,0));
INSERT INTO HusoHorario VALUES('06:00:00'm2ss.maketime(6,0,0));
INSERT INTO HusoHorario VALUES('06:30:00'm2ss.maketime(6,30,0));
INSERT INTO HusoHorario VALUES('07:00:00'm2ss.maketime(7,0,0));
INSERT INTO HusoHorario VALUES('08:00:00'm2ss.maketime(8,0,0));
INSERT INTO HusoHorario VALUES('08:45:00'm2ss.maketime(8,45,0));
INSERT INTO HusoHorario VALUES('09:00:00'm2ss.maketime(9,0,0));
INSERT INTO HusoHorario VALUES('09:30:00'm2ss.maketime(9,30,0));
INSERT INTO HusoHorario VALUES('10:00:00'm2ss.maketime(10,0,0));
INSERT INTO HusoHorario VALUES('10:30:00'm2ss.maketime(10,30,0));
INSERT INTO HusoHorario VALUES('11:00:00'm2ss.maketime(11,0,0));
INSERT INTO HusoHorario VALUES('11:30:00'm2ss.maketime(11,30,0));
INSERT INTO HusoHorario VALUES('12:00:00'm2ss.maketime(12,0,0));
INSERT INTO HusoHorario VALUES('12:45:00');
INSERT INTO HusoHorario VALUES('13:00:00');
INSERT INTO HusoHorario VALUES('14:00:00');
*/
/*
*******************************************************
*							  		                  *
*				        CATEGORIAS 				      *
*									                  *
*******************************************************
*/

SELECT 'Categorias';

EXEC sp_msforeachtable "ALTER TABLE ? NOCHECK CONSTRAINT all";

/* La categoria 'Inicio' es hija de ella misma */
DECLARE	@CategoriaRaiz int

EXEC dbo.InsertarCategoria$IMPL
	 @a_Nombre = N'Inicio',
	 @a_HijoDeCategoria = -1,
	 @returnvalue = @CategoriaRaiz OUTPUT;

UPDATE Categoria 
SET HijoDeCategoria = @CategoriaRaiz 
WHERE CategoriaID = @CategoriaRaiz;

EXEC sp_msforeachtable @command1="ALTER TABLE ? WITH CHECK CHECK CONSTRAINT all";

DECLARE	@bobo int

/* Hay que agregarle las subdivisiones (mas adelante) */

EXEC dbo.InsertarCategoria$IMPL @a_Nombre = N'Libros', @a_HijoDeCategoria = @CategoriaRaiz, @returnvalue = @bobo OUTPUT;
EXEC dbo.InsertarCategoria$IMPL @a_Nombre = N'Computadoras', @a_HijoDeCategoria = @CategoriaRaiz, @returnvalue = @bobo OUTPUT;
EXEC dbo.InsertarCategoria$IMPL @a_Nombre = N'Electronica', @a_HijoDeCategoria = @CategoriaRaiz, @returnvalue = @bobo OUTPUT;
EXEC dbo.InsertarCategoria$IMPL @a_Nombre = N'Salud y farmacia', @a_HijoDeCategoria = @CategoriaRaiz, @returnvalue = @bobo OUTPUT;
EXEC dbo.InsertarCategoria$IMPL @a_Nombre = N'Juguetes y ninos', @a_HijoDeCategoria = @CategoriaRaiz, @returnvalue = @bobo OUTPUT;
EXEC dbo.InsertarCategoria$IMPL @a_Nombre = N'Ropa y calzado', @a_HijoDeCategoria = @CategoriaRaiz, @returnvalue = @bobo OUTPUT;
EXEC dbo.InsertarCategoria$IMPL @a_Nombre = N'Joyas', @a_HijoDeCategoria = @CategoriaRaiz, @returnvalue = @bobo OUTPUT;
EXEC dbo.InsertarCategoria$IMPL @a_Nombre = N'Deportes y entretenimiento', @a_HijoDeCategoria = @CategoriaRaiz, @returnvalue = @bobo OUTPUT;
EXEC dbo.InsertarCategoria$IMPL @a_Nombre = N'Ferreterias y materiales', @a_HijoDeCategoria = @CategoriaRaiz, @returnvalue = @bobo OUTPUT;
EXEC dbo.InsertarCategoria$IMPL @a_Nombre = N'Automotriz e industrial', @a_HijoDeCategoria = @CategoriaRaiz, @returnvalue = @bobo OUTPUT;
EXEC dbo.InsertarCategoria$IMPL @a_Nombre = N'No asignada', @a_HijoDeCategoria = @CategoriaRaiz, @returnvalue = @bobo OUTPUT;

/*
*************************************************************
*							  			                    *
*				        ADMINISTRADOR				        *
*										                    *
*************************************************************
*/

SELECT 'Administrador';
/* Las condiciones de borde (el primero y el ultimo) siempre joden. En este caso, el primer administrador... */
DECLARE @Creador int

EXEC dbo.InsertarAdministrador$IMPL @a_Creador = 1, 
	@a_Parroquia = NULL, 
	@a_CorreoElectronico = 'admin@netzuela.com',
	@a_Contrasena = '1asdXzp91',
	@a_Estatus = 'Activo',
	@a_Privilegios = 'Todos',
	@a_Nombre = 'Nestor',
	@a_Apellido =  'Bohorquez', 
	@returnvalue = @bobo OUTPUT;
	
SET @Creador =
(
	SELECT Rastreable_P
	FROM Administrador
	WHERE AdministradorID = @bobo
);

/*
*******************************************************
*                                                     *
*			        REGIONES GEOGRAFICAS 			  *
*									                  *
*******************************************************
*/

/* 
   Se crean solo las regiones geograficas necesarias para representar 
   completamente a las parroquias de Cabimas
*/

SELECT 'Continentes';
DECLARE @AmericaID int

/* Continentes del mundo */
EXEC dbo.InsertarContinente$IMPL @a_Creador = @Creador, @a_Nombre = 'Africa', @a_Poblacion = 1000000000, @returnvalue = @bobo OUTPUT;
EXEC dbo.InsertarContinente$IMPL @a_Creador = @Creador, @a_Nombre = 'America', @a_Poblacion = 910717000, @returnvalue = @AmericaID OUTPUT;
/*
EXEC dbo.InsertarContinente$IMPL @a_Creador = @Creador, @a_Nombre = 'Asia', @a_Poblacion = 3879000000, @returnvalue = @bobo OUTPUT;
*/
EXEC dbo.InsertarContinente$IMPL @a_Creador = @Creador, @a_Nombre = 'Europa', @a_Poblacion = 739000000, @returnvalue = @bobo OUTPUT;
EXEC dbo.InsertarContinente$IMPL @a_Creador = @Creador, @a_Nombre = 'Oceania', @a_Poblacion = 33000000, @returnvalue = @bobo OUTPUT;

SELECT 'Ciudades';
DECLARE @CaracasID int, @MaracaiboID int
		
/* Es necesario crear Caracas D.C. para poder definir a Venezuela */
EXEC dbo.InsertarCiudad$IMPL @a_Creador = @Creador, @a_Nombre = 'Caracas D.C.', @a_Poblacion = 2109166, @returnvalue = @CaracasID OUTPUT;
EXEC dbo.InsertarCiudad$IMPL @a_Creador = @Creador, @a_Nombre = 'Maracaibo', @a_Poblacion = 1897655, @returnvalue = @MaracaiboID OUTPUT;

SELECT 'Paises';
DECLARE @VenezuelaID int

EXEC dbo.InsertarPais$IMPL 
	@a_Creador = @Creador, 
	@a_Nombre = 'Venezuela', 
	@a_Poblacion = 28892735, 
	@a_Continente = @AmericaID,
	@a_Capital = @CaracasID, 
	@a_Idioma = 'Espanol', 
	@a_MonedaLocal = 'Bolivar', 
	@a_MonedaLocal_Dolar = 4.30, 
	@a_PIB = 326498000000, 
	@returnvalue = @VenezuelaID OUTPUT;

SELECT 'Estados';
DECLARE @ZuliaID int

EXEC dbo.InsertarEstado$IMPL  
	@a_Creador = @Creador, 
	@a_Nombre = 'Zulia', 
	@a_Poblacion = 3887171, 
	@a_Pais = @VenezuelaID,
	@a_HusoHorarioNormal = '04:30:00', 
	@a_HusoHorarioVerano = NULL, 
	@returnvalue = @ZuliaID OUTPUT;

SELECT 'Municipios';
DECLARE @CabimasID int

/* Municipios del Zulia */
EXEC dbo.InsertarMunicipio$IMPL @a_Creador = @Creador, @a_Nombre = 'Almirante Padilla', @a_Poblacion = 9030, @a_Estado = @ZuliaID, @a_Ciudad = NULL, @returnvalue = @bobo OUTPUT;
EXEC dbo.InsertarMunicipio$IMPL @a_Creador = @Creador, @a_Nombre = 'Baralt', @a_Poblacion = 80000, @a_Estado = @ZuliaID, @a_Ciudad = NULL, @returnvalue = @bobo OUTPUT;
EXEC dbo.InsertarMunicipio$IMPL @a_Creador = @Creador, @a_Nombre = 'Cabimas', @a_Poblacion = 273183, @a_Estado = @ZuliaID, @a_Ciudad = NULL, @returnvalue = @CabimasID OUTPUT;
EXEC dbo.InsertarMunicipio$IMPL @a_Creador = @Creador, @a_Nombre = 'Catatumbo', @a_Poblacion = 31780, @a_Estado = @ZuliaID, @a_Ciudad = NULL, @returnvalue = @bobo OUTPUT;
EXEC dbo.InsertarMunicipio$IMPL @a_Creador = @Creador, @a_Nombre = 'Colon', @a_Poblacion = 107821, @a_Estado = @ZuliaID, @a_Ciudad = NULL, @returnvalue = @bobo OUTPUT;
EXEC dbo.InsertarMunicipio$IMPL @a_Creador = @Creador, @a_Nombre = 'Francisco Javier Pulgar', @a_Poblacion = 29208, @a_Estado = @ZuliaID, @a_Ciudad = NULL, @returnvalue = @bobo OUTPUT;
EXEC dbo.InsertarMunicipio$IMPL @a_Creador = @Creador, @a_Nombre = 'Jesus Enrique Lossada', @a_Poblacion = 83458, @a_Estado = @ZuliaID, @a_Ciudad = NULL, @returnvalue = @bobo OUTPUT;
EXEC dbo.InsertarMunicipio$IMPL @a_Creador = @Creador, @a_Nombre = 'Jesus Maria Semprun', @a_Poblacion = 23972, @a_Estado = @ZuliaID, @a_Ciudad = NULL, @returnvalue = @bobo OUTPUT;
EXEC dbo.InsertarMunicipio$IMPL @a_Creador = @Creador, @a_Nombre = 'La Canada de Urdaneta', @a_Poblacion = 61527, @a_Estado = @ZuliaID, @a_Ciudad = NULL, @returnvalue = @bobo OUTPUT;
EXEC dbo.InsertarMunicipio$IMPL @a_Creador = @Creador, @a_Nombre = 'Lagunillas', @a_Poblacion = 169400, @a_Estado = @ZuliaID, @a_Ciudad = NULL, @returnvalue = @bobo OUTPUT;
EXEC dbo.InsertarMunicipio$IMPL @a_Creador = @Creador, @a_Nombre = 'Machiques de Perija', @a_Poblacion = 93154, @a_Estado = @ZuliaID, @a_Ciudad = NULL, @returnvalue = @bobo OUTPUT;
EXEC dbo.InsertarMunicipio$IMPL @a_Creador = @Creador, @a_Nombre = 'Mara', @a_Poblacion = 155918, @a_Estado = @ZuliaID, @a_Ciudad = NULL, @returnvalue = @bobo OUTPUT;
EXEC dbo.InsertarMunicipio$IMPL @a_Creador = @Creador, @a_Nombre = 'Maracaibo', @a_Poblacion = 1495199, @a_Estado = @ZuliaID, @a_Ciudad = @MaracaiboID, @returnvalue = @bobo OUTPUT;
EXEC dbo.InsertarMunicipio$IMPL @a_Creador = @Creador, @a_Nombre = 'Miranda', @a_Poblacion = 82500, @a_Estado = @ZuliaID, @a_Ciudad = NULL, @returnvalue = @bobo OUTPUT;
EXEC dbo.InsertarMunicipio$IMPL @a_Creador = @Creador, @a_Nombre = 'Guajira', @a_Poblacion = 105000, @a_Estado = @ZuliaID, @a_Ciudad = NULL, @returnvalue = @bobo OUTPUT;
EXEC dbo.InsertarMunicipio$IMPL @a_Creador = @Creador, @a_Nombre = 'Rosario de Perija', @a_Poblacion = 67172, @a_Estado = @ZuliaID, @a_Ciudad = NULL, @returnvalue = @bobo OUTPUT;
EXEC dbo.InsertarMunicipio$IMPL @a_Creador = @Creador, @a_Nombre = 'San Francisco', @a_Poblacion = 424314, @a_Estado = @ZuliaID, @a_Ciudad = @MaracaiboID, @returnvalue = @bobo OUTPUT;
EXEC dbo.InsertarMunicipio$IMPL @a_Creador = @Creador, @a_Nombre = 'Santa Rita', @a_Poblacion = 76304, @a_Estado = @ZuliaID, @a_Ciudad = NULL, @returnvalue = @bobo OUTPUT;
EXEC dbo.InsertarMunicipio$IMPL @a_Creador = @Creador, @a_Nombre = 'Simon Bolivar', @a_Poblacion = 50000, @a_Estado = @ZuliaID, @a_Ciudad = NULL, @returnvalue = @bobo OUTPUT;
EXEC dbo.InsertarMunicipio$IMPL @a_Creador = @Creador, @a_Nombre = 'Sucre', @a_Poblacion = 57396, @a_Estado = @ZuliaID, @a_Ciudad = NULL, @returnvalue = @bobo OUTPUT;
EXEC dbo.InsertarMunicipio$IMPL @a_Creador = @Creador, @a_Nombre = 'Valmore Rodriguez', @a_Poblacion = 55000, @a_Estado = @ZuliaID, @a_Ciudad = NULL, @returnvalue = @bobo OUTPUT;

SELECT 'Parroquias';
DECLARE @AmbrosioID int

/* Parroquias de Cabimas */
EXEC dbo.InsertarParroquia$IMPL 
	@a_Creador = @Creador, 
	@a_Nombre = 'Ambrosio', 
	@a_Poblacion = 40768, 
	@a_Municipio = @CabimasID, 
	@a_CodigoPostal = '4013', 
	@returnvalue = @AmbrosioID OUTPUT;

/* ¡El Administrador es de Ambrosio! */
UPDATE Usuario
SET Usuario.Parroquia = @AmbrosioID
WHERE UsuarioID = 1;

EXEC dbo.InsertarParroquia$IMPL 
	@a_Creador = @Creador, 
	@a_Nombre = 'Aristides Calvani', 
	@a_Poblacion = 40768, 
	@a_Municipio = @CabimasID, 
	@a_CodigoPostal = '4013', 
	@returnvalue = @bobo OUTPUT;
	
EXEC dbo.InsertarParroquia$IMPL 
	@a_Creador = @Creador, 
	@a_Nombre = 'Carmen Herrera', 
	@a_Poblacion = 27194, 
	@a_Municipio = @CabimasID, 
	@a_CodigoPostal = '4013', 
	@returnvalue = @bobo OUTPUT;

EXEC dbo.InsertarParroquia$IMPL 
	@a_Creador = @Creador, 
	@a_Nombre = 'German Rios Linares', 
	@a_Poblacion = 44155, 
	@a_Municipio = @CabimasID, 
	@a_CodigoPostal = '4013', 
	@returnvalue = @bobo OUTPUT;
	
EXEC dbo.InsertarParroquia$IMPL 
	@a_Creador = @Creador, 
	@a_Nombre = 'Jorge Hernandez', 
	@a_Poblacion = 27559, 
	@a_Municipio = @CabimasID, 
	@a_CodigoPostal = '4013', 
	@returnvalue = @bobo OUTPUT;
	
EXEC dbo.InsertarParroquia$IMPL 
	@a_Creador = @Creador, 
	@a_Nombre = 'La Rosa', 
	@a_Poblacion = 25128, 
	@a_Municipio = @CabimasID, 
	@a_CodigoPostal = '4013', 
	@returnvalue = @bobo OUTPUT;
	
EXEC dbo.InsertarParroquia$IMPL 
	@a_Creador = @Creador, 
	@a_Nombre = 'Punta Gorda', 
	@a_Poblacion = 10224, 
	@a_Municipio = @CabimasID, 
	@a_CodigoPostal = '4013', 
	@returnvalue = @bobo OUTPUT;

EXEC dbo.InsertarParroquia$IMPL 
	@a_Creador = @Creador, 
	@a_Nombre = 'Romulo Betancourt', 
	@a_Poblacion = 25225, 
	@a_Municipio = @CabimasID, 
	@a_CodigoPostal = '4013', 
	@returnvalue = @bobo OUTPUT;

EXEC dbo.InsertarParroquia$IMPL 
	@a_Creador = @Creador, 
	@a_Nombre = 'San Benito', 
	@a_Poblacion = 51501, 
	@a_Municipio = @CabimasID, 
	@a_CodigoPostal = '4013', 
	@returnvalue = @bobo OUTPUT;

GO