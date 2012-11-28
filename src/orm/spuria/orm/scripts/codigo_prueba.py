# -*- coding: utf-8 -*-

from comunes import ARCHIVO_CONFIG, ARCHIVO_IMAGENES
from datetime import date, time, datetime, timedelta
from decimal import Decimal
from spuria.orm import (
    Busqueda, ResultadoDeBusqueda, DBSession, Consumidor, Sexo, GrupoDeEdad, 
    GradoDeInstruccion, Territorio, Categoria, EstadisticasDeVisitas, 
    EstadisticasDePopularidad, EstadisticasDeInfluencia, Usuario, Palabra,
    Croquis, Punto, Descripcion, Foto, Patrocinante, Publicidad, 
    CalificacionResena, Seguimiento, Producto, Tienda, HorarioDeTrabajo, Turno,
    Inventario, Mensaje, Factura, ServicioVendido, inicializar
)
from sqlalchemy import and_
import ConfigParser, transaction

def main():
    inicializar(archivo=ARCHIVO_CONFIG)

    with transaction.manager:
        """
        PRODUCTOS
        """
        pyVenezuela = DBSession.query(Territorio).filter(
            and_(Territorio.nombre == 'Venezuela', Territorio.nivel == 1)
        ).first()

        pyChina = DBSession.query(Territorio).filter(
            and_(Territorio.nombre == 'China', Territorio.nivel == 1)
        ).first()

        cat2000 = DBSession.query(Categoria).filter_by(
            nombre='Computacion - Electronica'
        ).first()

        cat2b00 = DBSession.query(Categoria).filter_by(
            nombre='Computadoras de escritorio'
        ).first()

        cat2a00 = DBSession.query(Categoria).filter_by(
            nombre='Telefonos celulares'
        ).first()

        cat2100 = DBSession.query(Categoria).filter_by(
            nombre='Instrumentos musicales'
        ).first()

        cat2200 = DBSession.query(Categoria).filter_by(
            nombre='Consolas de videojuegos'
        ).first()

        cat5000 = DBSession.query(Categoria).filter_by(
            nombre='Ropa - Calzado'
        ).first()

        cat5100 = DBSession.query(Categoria).filter_by(
            nombre='Ropa para damas'
        ).first()

        cat5200 = DBSession.query(Categoria).filter_by(
            nombre='Ropa para caballeros'
        ).first()
        
        cat5300 = DBSession.query(Categoria).filter_by(
            nombre='Calzado para damas'
        ).first()

        cat5400 = DBSession.query(Categoria).filter_by(
            nombre='Calzado para caballeros'
        ).first()

        paCHerrera = DBSession.query(Territorio).\
        filter_by(nombre='Carmen Herrera').first()

        paLaRosa = DBSession.query(Territorio).\
        filter_by(nombre='La Rosa').first()

        paAmbrosio = DBSession.query(Territorio).\
        filter_by(nombre='Ambrosio').first()

        paSBenito = DBSession.query(Territorio).\
        filter_by(nombre='San Benito').first()

        paPtaGorda = DBSession.query(Territorio).\
        filter_by(nombre='Punta Gorda').first()

        productos = [
            (
                1, 'GTIN-13', '001', 'Activo', 'Blackberry', 'Curve 9300', 
                'Curve 9300', date(2010,8,15), 0.014, 0.060, 0.109, 0.104, 
                pyChina, cat2a00, ['bbcurve9300_1.jpg', 'bbcurve9300_2.jpg'],
                "Blackberry Curve 9300"
            ), (
                1, 'GTIN-13', '002', 'Activo', 'Blackberry', 'Bold 9650', 
                'Bold 3 9650', date(2010,4,15), 0.014, 0.062, 0.112, 0.136, 
                pyChina, cat2a00, ['bbbold9650_1.jpg', 'bbbold9650_2.jpg'],
                "Blackberry Bold 9650"
            ), (
                1, 'GTIN-13', '003', 'Activo', 'Blackberry', 'Bold 9000', 
                'Bold 1 9000', date(2008,5,15), 0.014, 0.066, 0.114, 0.133, 
                pyChina, cat2a00, ['bbbold9000_1.jpg', 'bbbold9000_2.jpg'],
                "Blackberry Bold 9000"
            ), (
                1, 'GTIN-13', '004', 'Activo', 'Blackberry', 'Bold 9700', 
                'Bold 2 9700', date(2009,10,15), 0.014, 0.060, 0.109, 0.120, 
                pyChina, cat2a00, ['bbbold9700_1.jpg', 'bbbold9700_2.jpg'],
                "Blackberry Bold 9700"
            ), (
                1, 'GTIN-13', '005', 'Activo', 'Blackberry', 'Curve 9320',
                'Curve 9320', date(2012,4,15), 0.0127, 0.060, 0.109, 0.136, 
                pyChina, cat2a00, ['bbcurve9320_1.png', 'bbcurve9320_2.png'],
                "Blackberry Curve 9320"
            ), (
                1, 'GTIN-13', '006', 'Activo', 'Blackberry', 'Bold 9900',
                'Bold 5 9900', date(2011,4,15), 0.0105, 0.066, 0.115, 0.130, 
                pyChina, cat2a00, ['bbbold9900_1.jpg', 'bbbold9900_2.jpg'],
                "Blackberry Bold 9900"
            ), (
                1, 'GTIN-13', '007', 'Activo', 'Blackberry', 'Curve 9380',
                'Curve 9380', date(2011,11,15), 0.0112, 0.060, 0.109, 0.098, 
                pyChina, cat2a00, ['bbcurve9380_1.jpg', 'bbcurve9380_2.jpg'],
                "Blackberry Curve 9380"
            ), (
                1, 'GTIN-13', '008', 'Activo', 'Blackberry', 'Curve 8900',
                'Curve 8900 Javelin', date(2008,11,15), 0.0135, 0.060, 0.109, 
                0.136, pyChina, cat2a00, [
                    'bbcurve8900_1.jpg','bbcurve8900_2.jpg'
                ], "Blackberry Curve 8900"
            ), (
                1, 'GTIN-13', '009', 'Activo', 'Blackberry', 'Curve 8320',
                'Curve 8320', date(2007,9,15), 0.0155, 0.060, 0.107, 0.111, 
                pyChina, cat2a00, ['bbcurve8320_1.jpg', 'bbcurve8320_2.jpg'],
                "Blackberry Curve 8320"
            ), (
                1, 'GTIN-13', '010', 'Activo', 'Blackberry', 'Pearl 8100',
                'Pearl 8100', date(2006,9,15), 0.0145, 0.050, 0.107, 0.0895, 
                pyChina, cat2a00, ['bbpearl8100_1.jpg', 'bbpearl8100_2.jpg'],
                "Blackberry Pearl 8100"
            ), (
                1, 'GTIN-13', '011', 'Activo', 'Blackberry', 'Torch 9850',
                'Torch 9850', date(2011,8,15), 0.0115, 0.062, 0.120, 0.135, 
                pyChina, cat2a00, ['bbtorch9850_1.jpg', 'bbtorch9850_2.jpg'],
                "Blackberry Torch 9850"
            ), (
                1, 'GTIN-13', '012', 'Activo', 'Blackberry', 'Torch 9860',
                'Torch 3 9860', date(2011,8,15), 0.0115, 0.062, 0.120, 0.135, 
                pyChina, cat2a00, ['bbtorch9860_1.jpg', 'bbtorch9860_2.jpg'],
                "Blackberry Torch 9860"
            ), (
                1, 'GTIN-13', '013', 'Activo', 'Apple', 'Iphone 4S',
                'Iphone 4S', date(2011,10,15), 0.0093, 0.0586, 0.1152, 0.140, 
                pyChina, cat2a00, ['iphone4s_1.jpg', 'iphone4s_2.png'],
                "Apple Iphone 4S"
            ), (
                1, 'GTIN-13', '014', 'Activo', 'Apple', 'Iphone 5',
                'Iphone 5', date(2012,9,15), 0.0076, 0.0585, 0.1238, 0.112, 
                pyChina, cat2a00, ['iphone5_1.jpg', 'iphone5_2.jpg'],
                "Apple Iphone 5"
            ), (
                1, 'GTIN-13', '015', 'Activo', 'Apple', 'Iphone 3G S',
                'Iphone 3G S', date(2009,6,15), 0.0123, 0.0621, 0.1155, 0.135, 
                pyChina, cat2a00, ['iphone3gs_1.jpg', 'iphone3gs_2.jpg'],
                "Apple Iphone 3G S"
            ), (
                1, 'GTIN-13', '016', 'Activo', 'Samsung', 'GT-I9300',
                'Galaxy S III', date(2012,5,29), 0.0086, 0.0706, 0.1366,
                0.133, pyChina, cat2a00, [
                    'samsung_galaxys3_9300_1.jpg',
                    'samsung_galaxys3_9300_2.jpg'
                ], "Samsung Galaxy S III"
            ), (
                1, 'GTIN-13', '017', 'Activo', 'Samsung', 'GT-S7500',
                'Galaxy Ace Plus', date(2012,1,15), 0.0112, 0.0625, 0.1145,
                0.115, pyChina, cat2a00, [
                    'samsung_galaxyaceplus_1.jpg', 
                    'samsung_galaxyaceplus_2.jpg'
                ], "Samsung Galaxy Ace Plus"
            ), (
                1, 'GTIN-13', '018', 'Activo', 'Samsung', 'GT-S5830',
                'Galaxy Ace', date(2011,1,15), 0.0115, 0.0599, 0.1124, 0.113, 
                pyChina, cat2a00, [
                    'samsung_galaxyace_1.jpg', 'samsung_galaxyace_2.jpg'
                ], "Samsung Galaxy Ace"
            ), (
                1, 'GTIN-13', '019', 'Activo', 'Samsung', 'GT-I9100',
                'Galaxy S II', date(2011,2,15), 0.0085, 0.0661, 0.1253, 0.116, 
                pyChina, cat2a00, [
                    'samsung_galaxys2_1.jpg', 'samsung_galaxys2_2.jpg'
                ], "Samsung Galaxy S II"
            ), (
                1, 'GTIN-13', '020', 'Activo', 'Sony', 'CECH-4000',
                'Playstation 3', date(2012,9,28), 0.290, 0.230, 0.060,
                2.1, pyChina, cat2200, [
                    'playstation3_1.jpg', 'playstation3_2.jpg'
                ], "Sony Playstation 3"
            ), (
                1, 'GTIN-13', '021', 'Activo', 'EA Sports', 'FIFA 13',
                'FIFA 13', date(2012,9,25), 0.014, 0.135, 0.172,
                0.120, pyChina, cat2200, ['fifa13_1.png', 'fifa13_2.jpg'],
                "EA Sports FIFA 13"
            ), (
                1, 'GTIN-13', '022', 'Activo', 'Microsoft', 'Xbox 360 S',
                'Xbox 360', date(2010,7,16), 0.264, 0.075, 0.270,
                2.9, pyChina, cat2200, ['xbox360_1.jpg', 'xbox360_2.jpg'],
                "Microsoft Xbox 360 S"
            )
        ]
    
        pro = []
        for p in productos:
            pro.append(Producto(
                creador=p[0], tipo_de_codigo=p[1], codigo=p[2], estatus=p[3],
                fabricante=p[4], modelo=p[5], nombre=p[6], 
                debut_en_el_mercado=p[7], largo=p[8], ancho=p[9], alto=p[10], 
                peso=p[11], pais_de_origen=p[12], categoria=p[13]
            ))
        
        DBSession.add_all(pro)
        print "Productos creados"

        usu1 = Usuario(
            creador=1, nombre='Nestor', apellido='Bohorquez', estatus='Activo',
            ubicacion=paCHerrera, correo_electronico='molleja@abc.com', 
            contrasena='$2a$12$1wugqI8R4mC8MHEVPimxgO60m9Zoj.8P1BLj1kSrDTOIOgoa'
            'iEe0i'
        )

        DBSession.add(usu1)
        DBSession.flush()
        print "Usuario Nestor Bohorquez creado"

        """
        TIENDAS
        """

        """
        Nelson Dupuy
        Alberto Piña
        Fausto Lo Giudice
        Marnie Petit
        Maria Spluga
        Silena Perozo
        Patrizia Bologna
        Gustavo Gonzalez
        Daniel Silva
        Oscar Diaz
        """

        tiendas = [
            (
                paAmbrosio, 'J001545126', usu1, cat2000, 'Activo', 
                'Inversiones Igualdad C.A.', 'La Boutique Electronica', 
                '0264-2415497', 'Igualdad', 'Ambrosio', 
                'http://www.facebook.com/laboutiqueelectronica', '',
                usu1.acceso.correo_electronico, Punto(10.408369,-71.469578),
                ['la_boutique_electronica.jpg'], "La Boutique Electronica"
            ), (
                paCHerrera, 'J500045840', usu1, cat2000, 'Activo',
                'Tecnoventas 2001 S.R.L.', 'Tecnoventas 2001',
                '0264-3715943', '2', 'Las Palmas' , '', '@tecnoventas2001',
                'tecnoventas2001@gmail.com', Punto(10.385606,-71.462594),
                ['tecnoventas_2001.jpg'], "Tecnoventas 2001"
            ), (
                paCHerrera, 'J123456789', usu1, cat2000, 'Activo',
                'Blackberrymania C.A.', 'Blackberrymania',
                '0264-2615497', 'Providencia', 'Casco Central',
                'http://www.facebook.com/bbmania', '@bbmania',
                'bbmania@hotmail.com', Punto(10.389487,-71.464241),
                ['blackberrymania.jpg'], "Blackberrymania"
            ), (
                paAmbrosio, 'J987654321', usu1, cat5400, 'Activo', 
                'Inversiones Petit C.A.', 'Calzados Continental',
                '0414-6493497', 'Miranda', 'Amparo',
                'http://www.facebook.com/calzados_continental', 
                '@calzados_continental', 'calzados_continental@yahoo.com',
                Punto(10.419754,-71.462258), ['calzados_continental.jpg'],
                "Calzados Continental"
            ), (
                paAmbrosio, 'J481526594', usu1, cat5100, 'Activo',
                'Perfumes y variedades 3Y C.A.', 'Glam & Chic',
                '0412-9341597', 'Argentina', 'Bello Monte',
                'http://www.facebook.com/glamchic', '@glam_chic',
                'glam_chic@msn.com', Punto(10.423273,-71.460059),
                ['glam_chic.jpg'], "Glam & Chic"
            ), (
                paAmbrosio, 'J100000694', usu1, cat2000, 'Activo',
                'SERTCECA', 'Macrocomputer', 
                '0264-9741842', 'Chile', 'Delicias Nuevas',
                '', '', 'macrocomputer_cabimas@gmail.com',
                Punto(10.411001,-71.454509), ['macrocomputer.jpg'],
                "Macrocomputer"
            ), (
                paAmbrosio, 'J100045129', usu1, cat2000, 'Activo',
                'La Milla de Oro C.A.', 'La Milla de Oro',
                '0264-7491659', 'Nuevo Mundo', 'La Mision',
                '', '@milladeoro_cabimas', 'milladeoro_cabimas@cantv.net',
                Punto(10.425339,-71.465930), ['la_milla_de_oro.jpg'],
                "La Milla de Oro"
            ), (
                paCHerrera, 'J100039421', usu1, cat2000, 'Activo',
                'Silicon Systems C.A.', 'Silicon Systems',
                '0424-4691013', 'Las Flores', 'Concordia',
                '', '@silicon_systems', 'silicon_systems@hotmail.com',
                Punto(10.392587,-71.448260), ['silicon_systems.jpg'],
                "Silicon Systems"
            ), (
                paAmbrosio, 'J566491415', usu1, cat5400, 'Activo',
                'Corporacion Calzadi C.A.', 'Calzadi Sport',
                '0264-4518994', 'Las Delicias', 'Delicias Nuevas',
                'http://www.facebook.com/calzadi_sport', '@calzadi_sport',
                'corporacion_calzadi@hotmail.com', Punto(10.409819,-71.458919),
                ['calzadi_sport.jpg'], "Calzadi Sport"
            ), (
                paLaRosa, 'J112348484', usu1, cat2000, 'Activo',
                'Masterweb C.A.', 'Masterweb',
                '0412-6184313', 'Los Choros', 'La Rosa Vieja',
                'http://www.facebook.com/masterweb_zulia', '@masterweb_zulia',
                'masterweb_zulia@gmail.com', Punto(10.366151,-71.437907),
                ['masterweb.jpg'], "Masterweb"
            )
        ]

        tie = []
        for t in tiendas:
            tie.append(Tienda(
                ubicacion=t[0], rif=t[1], propietario=t[2], categoria=t[3], 
                estatus=t[4], nombre_legal=t[5], nombre_comun=t[6], 
                telefono=t[7], calle=t[8], sector_urb_barrio=t[9],
                facebook=t[10], twitter=t[11], correo_electronico_publico=t[12]
            ))

            DBSession.add(tie[-1])

            tie[-1].horarios_de_trabajo.append(
                HorarioDeTrabajo('Lunes', True)
            )
            tie[-1].horarios_de_trabajo.append(
                HorarioDeTrabajo('Martes', True)
            )
            tie[-1].horarios_de_trabajo.append(
                HorarioDeTrabajo('Miercoles', True)
            )
            tie[-1].horarios_de_trabajo.append(
                HorarioDeTrabajo('Jueves', True)
            )
            tie[-1].horarios_de_trabajo.append(
                HorarioDeTrabajo('Viernes', True)
            )
            tie[-1].horarios_de_trabajo.append(
                HorarioDeTrabajo('Sabado', False)
            )
            tie[-1].horarios_de_trabajo.append(
                HorarioDeTrabajo('Domingo', False)
            )

            tie[-1].horarios_de_trabajo[0].turnos.append(
                Turno(time(8), time(16))
            )
            tie[-1].horarios_de_trabajo[1].turnos.append(
                Turno(time(8), time(16))
            )
            tie[-1].horarios_de_trabajo[2].turnos.append(
                Turno(time(8), time(16))
            )
            tie[-1].horarios_de_trabajo[3].turnos.append(
                Turno(time(8), time(16))
            )
            tie[-1].horarios_de_trabajo[4].turnos.append(
                Turno(time(8), time(16))
            )
            tie[-1].horarios_de_trabajo[5].turnos.append(
                Turno(time(0), time(0))
            )
            tie[-1].horarios_de_trabajo[6].turnos.append(
                Turno(time(0), time(0))
            )

        DBSession.flush()
        print "Tiendas creadas"

        """
        INVENTARIO
        """
    
        inventario = [
            (tie[2], '8017', 'Blackberry Curve 9300', 'Ambos visibles', pro[0], '3287,66055492628', 4),
            (tie[5], '794', 'Blackberry Curve 9300', 'Ambos visibles', pro[0], '3165,86214640522', 7),
            (tie[6], '9473', 'Blackberry Curve 9300', 'Ambos visibles', pro[0], '3117,33788339971', 1),
            (tie[7], '7872', 'Blackberry Curve 9300', 'Ambos visibles', pro[0], '3346,0096711549', 5),
            (tie[0], '4422', 'Blackberry Bold 9650', 'Ambos visibles', pro[1], '5205,83163391398', 9),
            (tie[2], '9474', 'Blackberry Bold 9650', 'Ambos visibles', pro[1], '5223,92966783145', 0),
            (tie[5], '8481', 'Blackberry Bold 9650', 'Ambos visibles', pro[1], '5101,06055643787', 5),
            (tie[7], '652', 'Blackberry Bold 9650', 'Ambos visibles', pro[1], '5201,53391514756', 1),
            (tie[2], '3450', 'Blackberry Bold 9000', 'Ambos visibles', pro[2], '2447,51387927681', 1),
            (tie[5], '5361', 'Blackberry Bold 9000', 'Ambos visibles', pro[2], '2522,22009538673', 4),
            (tie[6], '5742', 'Blackberry Bold 9000', 'Ambos visibles', pro[2], '2611,29844991956', 6),
            (tie[7], '8502', 'Blackberry Bold 9000', 'Ambos visibles', pro[2], '2528,96086592227', 9),
            (tie[2], '7454', 'Blackberry Bold 9700', 'Ambos visibles', pro[3], '3321,97611316061', 6),
            (tie[5], '2863', 'Blackberry Bold 9700', 'Ambos visibles', pro[3], '3282,32651158702', 8),
            (tie[1], '7500', 'Blackberry Curve 9320', 'Ambos visibles', pro[4], '3745,48410873055', 8),
            (tie[5], '9400', 'Blackberry Curve 9320', 'Ambos visibles', pro[4], '3907,03446223391', 5),
            (tie[6], '3241', 'Blackberry Curve 9320', 'Ambos visibles', pro[4], '3909,18537387671', 8),
            (tie[7], '4311', 'Blackberry Curve 9320', 'Ambos visibles', pro[4], '3694,81414707266', 0),
            (tie[9], '5242', 'Blackberry Curve 9320', 'Ambos visibles', pro[4], '3835,27664347314', 9),
            (tie[0], '5413', 'Blackberry Bold 9900', 'Ambos visibles', pro[5], '7677,29688847461', 0),
            (tie[1], '8374', 'Blackberry Bold 9900', 'Ambos visibles', pro[5], '7562,72955386061', 8),
            (tie[2], '6230', 'Blackberry Bold 9900', 'Ambos visibles', pro[5], '7783,8728161356', 6),
            (tie[5], '3893', 'Blackberry Bold 9900', 'Ambos visibles', pro[5], '7750,03938324312', 8),
            (tie[6], '8397', 'Blackberry Bold 9900', 'Ambos visibles', pro[5], '7610,85228937967', 3),
            (tie[9], '7401', 'Blackberry Bold 9900', 'Ambos visibles', pro[5], '7201,42482035258', 2),
            (tie[1], '4138', 'Blackberry Curve 9380', 'Ambos visibles', pro[6], '4880,10494697634', 2),
            (tie[9], '404', 'Blackberry Curve 9380', 'Ambos visibles', pro[6], '4488,65988857551', 4),
            (tie[0], '469', 'Blackberry Curve 8900', 'Ambos visibles', pro[7], '2922,2903545782', 3),
            (tie[1], '6869', 'Blackberry Curve 8900', 'Ambos visibles', pro[7], '3104,54019207903', 1),
            (tie[2], '4229', 'Blackberry Curve 8900', 'Ambos visibles', pro[7], '3073,62193129095', 8),
            (tie[5], '9999', 'Blackberry Curve 8900', 'Ambos visibles', pro[7], '2934,44506371575', 1),
            (tie[9], '4806', 'Blackberry Curve 8900', 'Ambos visibles', pro[7], '3148,80457581161', 0),
            (tie[0], '1634', 'Blackberry Curve 8320', 'Ambos visibles', pro[8], '1433,27148575694', 0),
            (tie[1], '5199', 'Blackberry Curve 8320', 'Ambos visibles', pro[8], '1494,97959612748', 6),
            (tie[2], '2993', 'Blackberry Curve 8320', 'Ambos visibles', pro[8], '1465,3973280075', 2),
            (tie[5], '4397', 'Blackberry Curve 8320', 'Ambos visibles', pro[8], '1500,22370713404', 8),
            (tie[7], '7539', 'Blackberry Curve 8320', 'Ambos visibles', pro[8], '1506,9455615615', 5),
            (tie[9], '3727', 'Blackberry Curve 8320', 'Ambos visibles', pro[8], '1471,83326222836', 7),
            (tie[1], '6194', 'Blackberry Pearl 8100', 'Ambos visibles', pro[9], '1334,65865941336', 4),
            (tie[5], '5864', 'Blackberry Pearl 8100', 'Ambos visibles', pro[9], '1319,67189948829', 5),
            (tie[1], '1003', 'Blackberry Torch 9850', 'Ambos visibles', pro[10], '6199,7099759616', 0),
            (tie[7], '925', 'Blackberry Torch 9850', 'Ambos visibles', pro[10], '6366,13304855302', 4),
            (tie[9], '7755', 'Blackberry Torch 9850', 'Ambos visibles', pro[10], '6279,55452729017', 1),
            (tie[0], '2701', 'Blackberry Torch 9860', 'Ambos visibles', pro[11], '7438,22903255699', 2),
            (tie[1], '9499', 'Blackberry Torch 9860', 'Ambos visibles', pro[11], '7612,23735666485', 5),
            (tie[7], '8138', 'Blackberry Torch 9860', 'Ambos visibles', pro[11], '7685,86349728983', 7),
            (tie[9], '4897', 'Blackberry Torch 9860', 'Ambos visibles', pro[11], '8005,13912728988', 0),
            (tie[0], '5039', 'Apple Iphone 4S', 'Ambos visibles', pro[12], '10867,998347002', 0),
            (tie[1], '7131', 'Apple Iphone 4S', 'Ambos visibles', pro[12], '10810,2934362314', 5),
            (tie[6], '3344', 'Apple Iphone 4S', 'Ambos visibles', pro[12], '10833,8679719311', 9),
            (tie[7], '7369', 'Apple Iphone 4S', 'Ambos visibles', pro[12], '11029,1339554321', 5),
            (tie[9], '4464', 'Apple Iphone 4S', 'Ambos visibles', pro[12], '10820,3991116588', 6),
            (tie[0], '789', 'Apple Iphone 5', 'Ambos visibles', pro[13], '16922,2482420245', 7),
            (tie[1], '9134', 'Apple Iphone 5', 'Ambos visibles', pro[13], '16781,0255295937', 2),
            (tie[2], '6040', 'Apple Iphone 5', 'Ambos visibles', pro[13], '17758,0942047571', 7),
            (tie[5], '7870', 'Apple Iphone 5', 'Ambos visibles', pro[13], '17004,8880242467', 3),
            (tie[6], '4573', 'Apple Iphone 5', 'Ambos visibles', pro[13], '16192,0899934159', 6),
            (tie[7], '3', 'Apple Iphone 5', 'Ambos visibles', pro[13], '16211,5175180701', 6),
            (tie[9], '613', 'Apple Iphone 5', 'Ambos visibles', pro[13], '17345,1355778527', 6),
            (tie[2], '8320', 'Apple Iphone 3G S', 'Ambos visibles', pro[14], '3914,4626869868', 9),
            (tie[9], '1859', 'Apple Iphone 3G S', 'Ambos visibles', pro[14], '4239,18419290949', 3),
            (tie[0], '8288', 'Samsung Galaxy S III', 'Ambos visibles', pro[15], '8872,71651980109', 5),
            (tie[5], '2589', 'Samsung Galaxy S III', 'Ambos visibles', pro[15], '9479,64387291041', 6),
            (tie[7], '381', 'Samsung Galaxy S III', 'Ambos visibles', pro[15], '9643,48638430792', 7),
            (tie[2], '7050', 'Samsung Galaxy Ace Plus', 'Ambos visibles', pro[16], '4024,99283284587', 3),
            (tie[6], '4964', 'Samsung Galaxy Ace Plus', 'Ambos visibles', pro[16], '4296,86481204811', 3),
            (tie[7], '3417', 'Samsung Galaxy Ace Plus', 'Ambos visibles', pro[16], '4294,61264873757', 5),
            (tie[0], '6210', 'Samsung Galaxy Ace', 'Ambos visibles', pro[17], '3264,20808673543', 3),
            (tie[2], '9086', 'Samsung Galaxy Ace', 'Ambos visibles', pro[17], '3449,96556816334', 6),
            (tie[7], '2599', 'Samsung Galaxy Ace', 'Ambos visibles', pro[17], '3436,18987851185', 1),
            (tie[0], '6387', 'Samsung Galaxy S II', 'Ambos visibles', pro[18], '8143,45345203909', 4),
            (tie[1], '3072', 'Samsung Galaxy S II', 'Ambos visibles', pro[18], '7821,0936335695', 9),
            (tie[2], '2562', 'Samsung Galaxy S II', 'Ambos visibles', pro[18], '7821,19593260991', 0),
            (tie[6], '5836', 'Samsung Galaxy S II', 'Ambos visibles', pro[18], '8367,11221291814', 9),
            (tie[0], '847', 'Sony Playstation 3', 'Ambos visibles', pro[19], '4835,52573351418', 0),
            (tie[1], '1071', 'Sony Playstation 3', 'Ambos visibles', pro[19], '4934,16417377819', 7),
            (tie[7], '3437', 'Sony Playstation 3', 'Ambos visibles', pro[19], '4840,73357004104', 7),
            (tie[9], '2198', 'Sony Playstation 3', 'Ambos visibles', pro[19], '5020,50838389238', 7),
            (tie[1], '4501', 'EA Sports FIFA 13', 'Ambos visibles', pro[20], '871,129434948601', 4),
            (tie[6], '4942', 'EA Sports FIFA 13', 'Ambos visibles', pro[20], '873,237180841016', 4),
            (tie[7], '76', 'EA Sports FIFA 13', 'Ambos visibles', pro[20], '880,079234468704', 1),
            (tie[9], '6442', 'EA Sports FIFA 13', 'Ambos visibles', pro[20], '854,200029109046', 8),
            (tie[1], '7708', 'Microsoft Xbox 360 S', 'Ambos visibles', pro[21], '4574,95251772106', 1),
            (tie[2], '3044', 'Microsoft Xbox 360 S', 'Ambos visibles', pro[21], '4711,89184337016', 1),
            (tie[6], '5802', 'Microsoft Xbox 360 S', 'Ambos visibles', pro[21], '4588,4530840674', 1),
            (tie[7], '7120', 'Microsoft Xbox 360 S', 'Ambos visibles', pro[21], '4541,59098148858', 1)
        ]

        for inv in inventario:
            inv[0].inventario.append(
                Inventario(
                    tienda=inv[0], codigo=inv[1], descripcion=inv[2],
                    visibilidad=inv[3], producto=inv[4], precio=Decimal(
                        inv[5].replace(',','.')
                    ), cantidad=inv[6]
                )
            )

        print "Inventarios agregados"
                
        """
        tie1.inventario.append(
            Inventario(
                tienda=tie1, codigo='TD-015SC', 
                descripcion='Computadora SGI 02', visibilidad="Ambos visibles", 
                producto=cat2b00.productos[0], precio=640.00, 
                cantidad=12
            )
        )   
        """

        """
        CONSUMIDOR
        """

        consumidores = [
            (
                1, 'Alberto', 'Atkins', 'Activo', 'Hombre', date(1988,6,9), 
                paPtaGorda, 'mandoca@merey.com', 'Adultos jovenes', 
                'Universitaria', 
                '$2a$12$QWVsuxBClsziPjNwSbD9XOQ2dvpgUOeJrk0Yz73wQecCBMptqBPuC',
                ['alberto_atkins.jpg']
            ), (
                1, 'Alejandro', 'Ocando', 'Activo', 'Hombre', date(1992,2,20), 
                paSBenito, 'tetero@dalepues.com', 'Adultos jovenes', 
                'Universitaria', 
                '$2a$12$xTWHSsODzmGI3l1unnlfCuFvErZRsUFtbcgVnn2Dn7CB5U1DT0Tlu',
                ['alejandro_ocando.jpg']
            ), (
                1, 'Alejandro', 'Maita', 'Activo', 'Hombre', date(1987,5,28), 
                paAmbrosio, 'cabeza@demonda.com', 'Adultos jovenes', 
                'Universitaria',
                '$2a$12$l81W0FstK/79PIlJMCbk6ePY/98BkhHcMpRAh1/6R03QwtU/VkA3i',
                ['alejandro_maita.jpg']
            ), (
                1, 'Snaillyn', 'Sosa', 'Activo', 'Mujer', date(1987,9,14), 
                paLaRosa, 'quefuecomo@estais.com', 'Adultos jovenes', 
                'Universitaria', 
                '$2a$12$sNqgTN0xvMSWC6BulGjBV.JMdAs91MG4LKEQ/WclWvA/TAxpCdcUC',
                ['snaillyn_sosa.jpg']
            )
        ]

        con = []
        for c in consumidores:
            con.append(Consumidor(
                creador=c[0], nombre=c[1], apellido=c[2], estatus=c[3], 
                sexo=c[4], fecha_de_nacimiento=c[5], ubicacion=c[6], 
                correo_electronico=c[7], grupo_de_edad=c[8], 
                grado_de_instruccion=c[9], contrasena=c[10]
            ))
        
        DBSession.add_all(con)
        DBSession.flush()

        print "Consumidores creados"

        """
        MENSAJE
        """
        
        men = Mensaje(
            remitente = con[1].interlocutor, destinatario = tie[0].interlocutor,
            contenido = 'El cielo resplancede a mi alrededor...'
        )
        
        DBSession.add(men)

        print "Mensaje creado"

        usu2 = Usuario(
            creador=1, nombre='Maria', apellido='Gonzalez', estatus='Activo',
            ubicacion=paAmbrosio, correo_electronico='hola@comoestais.com', 
            contrasena='$2a$12$IkgN0Mklv/fUgi.KbDBLku/yZhI.kbjMDObY7zdMnr03t7Ai'
            'gx3z.'
        )
        
        DBSession.add(usu2)
        DBSession.flush()

        print "Usuario Maria Gonzalez creado"

        """
        PATROCINANTE
        """

        pat1 = Patrocinante(
            propietario=usu2, ubicacion=paAmbrosio, 
            categoria=cat2000, rif='V195445890', estatus='Activo',
            nombre_legal='Yordonal C.A.', nombre_comun='Yordonal', 
            telefono='0264-2518490', calle='Igualdad', 
            sector_urb_barrio='Ambrosio', 
            facebook='http://www.facebook.com/yordonal',
            correo_electronico_publico=usu2.acceso.correo_electronico
        )

        DBSession.add(pat1)
        DBSession.flush()
        print "Patrocinante creado"

        """
        PUBLICIDAD
        """

        pat1.publicidades.append(
            Publicidad(
                patrocinante=pat1, nombre='Coca-Cola es inimitable y verga...'
            )
        )

        print "Publicidad creada"

        adultos_jovenes = DBSession.query(GrupoDeEdad).\
        filter_by(valor = 'Adultos jovenes').first()

        universitaria = DBSession.query(GradoDeInstruccion).\
        filter_by(valor = 'Universitaria').first()

        hombres = DBSession.query(Sexo).filter_by(valor = 'Hombre').first()

        pat1.publicidades[0].grupos_de_edades.append(adultos_jovenes)
        pat1.publicidades[0].grados_de_instruccion.append(universitaria)
        pat1.publicidades[0].territorios.append(paAmbrosio)
        pat1.publicidades[0].sexos.append(hombres)
        pat1.publicidades[0].consumidores.append(con[2])

        print "Publicidad configurada"

        """
        BUSCAR
        """

        bus1 = Busqueda(usuario=con[2], contenido='motor de aviones')
        DBSession.add(bus1)

        print "Busqueda creada"

        res1 = ResultadoDeBusqueda(
            busqueda=bus1, buscable=cat2a00.productos[0].buscable,
            relevancia=0.85, visitado=True
        )
        DBSession.add(res1)

        print "Resultado de busqueda creado"

        """
        CALIFICACION Y RESEÑA
        """

        cal = [0]*18

        cal[0] = CalificacionResena(
            pro[5].calificable_seguible, con[0] , 'Mal', 'Sed ut '
            'perspiciatis, unde omnis iste natus error sit voluptatem accusanti'
            'um doloremque laudantium, totam rem aperiam eaque ipsa, quae ab il'
            'lo inventore veritatis et quasi architecto beatae vitae dicta sunt'
            ', explicabo.'
        )
        cal[1] = CalificacionResena(
            pro[0].calificable_seguible, con[0], 'Mal', 'Sed ut perspiciatis, s'
            'omnis iste natus error sit voluptatem accusantium doloremque lauda'
            'ntium, totam rem aperiam eaque ipsa, quae ab illo inventore verita'
            'tis et quasi architecto beatae vitae dicta sunt, explicabo.'
        )
        cal[2] = CalificacionResena(
            pro[0].calificable_seguible, con[1], 'Bien', 'Deb'
            'et oporteat mel et. Mei eu modo referrentur dissentiunt, pri in vi'            
            'ris singulis, dicam ancillae sed ad.'
        )
        cal[3] = CalificacionResena(
            pro[1].calificable_seguible, con[2], 'Bien', 'Graecis periculis ex,'
            ' mel ridens persius et. In probatus reprehendunt duo, evertitur gl'
            'oriatur est ad.'
        )
        cal[4] = CalificacionResena(
            pro[2].calificable_seguible, con[3], 'Mal', 'Essent persecuti egent'
            'ur sea no, qui forensibus deseruisse concludaturque ad. Veniam pos'
            'sit eos cu. Te quo partem quidam detraxit. Illum numquam no duo. N'
            'ihil pericula prodesset ea his, in pri sint possim accusamus.'
        )
        cal[5] = CalificacionResena(
            pro[2].calificable_seguible, con[0], 'Bien', 'Graecis periculis am,'
            ' mel ridens persius et. In probatus reprehendunt duo, evertitur gl'
            'oriatur est ad.'
        )
        cal[6] = CalificacionResena(
            pro[3].calificable_seguible, con[1], 'Mal', 'Debet opat mel et. Mei'
            ' eu modo referrentur dissentiunt, pri in viris singulis, dicam anc'
            'illae sed ad.'
        )
        cal[7] = CalificacionResena(
            pro[3].calificable_seguible, con[2], 'Mal', 'Sed ut perspiciatis, s'
            'omnis iste natus error sit voluptatem accusantium doloremque lauda'
            'ntium, totam rem aperiam eaque ipsa, quae ab illo inventore verita'
            'tis et quasi architecto beatae vitae dicta sunt, explicabo.'
        )
        cal[8] = CalificacionResena(
            pro[4].calificable_seguible, con[3], 'Bien', 'Usu graeci scaevola, i'
            'us elitr verear no. Sed ex brute integre maiestatis. Per an admodu'
            'm recusabo, ne sit meis officiis aliquando.'
        )
        cal[9] = CalificacionResena(
            pro[4].calificable_seguible, con[0], 'Bien', 'An hinc scripserit, e'            
            'a omnis menandri referrentur usu.'
        )
        cal[10] = CalificacionResena(
            pro[5].calificable_seguible, con[1], 'Mal', 'Usu graeci vola in, iu'
            's elitr verear no. Sed ex brute integre maiestatis. Per an admodum'
            ' recusabo, ne sit meis officiis aliquando.'
        )
        cal[11] = CalificacionResena(
            pro[5].calificable_seguible, con[2], 'Bien', 'Essent ecuti neglegen'
            'tur sea no, qui forensibus deseruisse concludaturque ad. Veniam po'
            'ssit eos cu. Te quo partem quidam detraxit.'
        )
        cal[12] = CalificacionResena(
            tie[0].calificable_seguible, con[3], 'Mal', 
            'Simul singulis mea ei. Cum'
            ' ad saepe eruditi pericula, habeo maluisset cu per. Ut vide quas q'
            'ui, vim meis graece consequuntur ea, sit utinam laoreet habemus ea'
            '. At summo suscipit petentium est, dicit vidisse voluptua ei mei. '
            'Duo id aperiam menandri.'
        )
        cal[13] = CalificacionResena(
            tie[0].calificable_seguible, con[0], 'Bien', 
            'An hinc scripserit vel, e a omnis menandri referrentur usu.'
        )
        cal[14] = CalificacionResena(
            tie[0].calificable_seguible, con[1], 'Bien', 
            'Simul singulis mea ei. Cu'
            'm ad saepe eruditi pericula, habeo maluisset cu per. Ut vide quas '
            'qui, vim meis graece consequuntur ea, sit utinam laoreet habemus e'
            'a. At summo suscipit petentium est, dicit vidisse voluptua ei mei.'
            ' Duo id aperiam menandri.'
        )
        cal[15] = CalificacionResena(
            tie[1].calificable_seguible, con[2], 'Mal', 
            'Graecis periculis ex nam, '
            'mel ridens persius et. In probatus reprehendunt duo, evertitur glo'
            'riatur est ad.'
        )
        cal[16] = CalificacionResena(
            tie[1].calificable_seguible, con[3], 'Bien', 
            'Sed ut perspiciatis, unde'
            ' omnis iste natus error sit voluptatem accusantium doloremque laud'
            'antium, totam rem aperiam eaque ipsa, quae ab illo inventore verit'
            'atis et quasi architecto beatae vitae dicta sunt, explicabo.'
        )
        cal[17] = CalificacionResena(
            tie[1].calificable_seguible, con[0], 'Mal', 
            'Essent persecuti neglegent'
            'ur sea no, qui forensibus deseruisse concludaturque ad. Veniam pos'
            'sit eos cu. Te quo partem quidam detraxit. Illum numquam no duo. N'
            'ihil pericula prodesset ea his, in pri sint possim accusamus.'
        )

        DBSession.add_all(cal)
        print "Calificaciones y resenas creadas"

        """
        SEGUIDOR
        """
    
        seg1 = Seguimiento(
            calificable_seguible=pro[3].calificable_seguible, 
            consumidor=con[2], avisar_si='Lo ponen gratis'
        )

        DBSession.add(seg1)
        print "Seguidor creado"

        """
        DESCRIPCION
        """

        des = []
        for i, p in enumerate(productos):
            des.append(Descripcion(
                describible=pro[i].describible, contenido=p[15], creador=1
            ))

        for i, t in enumerate(tiendas):
            des.append(Descripcion(
                describible=tie[i].describible, contenido=t[15], 
                creador=tie[i].rastreable.rastreable_id
            ))

        DBSession.add_all(des)
        print "Descripciones creadas"
            
        """
        FOTOS
        """

        r2d2 = DBSession.query(Usuario).\
        filter(and_(Usuario.nombre=='R2', Usuario.apellido=='D2')).\
        first()

        config = ConfigParser.ConfigParser()
        with open(ARCHIVO_IMAGENES) as fp:
    	    config.readfp(fp)

        fot = []
        for i, p in enumerate(productos):
            for img in p[14]:
                archivos = config.get('imagenes', img).split(',')
                for a in archivos:
                    fot.append(Foto(pro[i].describible, a))

        for i, t in enumerate(tiendas):
            for img in t[14]:
                archivos = config.get('imagenes', img).split(',')
                for a in archivos:
                    fot.append(Foto(tie[i].describible, a))

        for i, c in enumerate(consumidores):
            for img in c[11]:
                archivos = config.get('imagenes', img).split(',')
                for a in archivos:
                    fot.append(Foto(con[i].describible, a))

        for a in config.get('imagenes', 'nestor_bohorquez.jpg').split(','):
            fot.append(Foto(usu1.describible, a))

        for a in config.get('imagenes', 'maria_gonzalez.jpg').split(','):
            fot.append(Foto(usu2.describible, a))

        for a in config.get('imagenes', 'r2d2.jpg').split(','):
            fot.append(Foto(r2d2.describible, a))

        DBSession.add_all(fot)
        print "Fotos creadas"

        """
        FACTURA
        """

        fac = Factura(pat1, datetime.now(), datetime.now() + timedelta(days=30))
        DBSession.add(fac)

        sev = ServicioVendido(fac, pat1.publicidades[0].cobrable, 45454)
        DBSession.add(sev)

        print "Facturas y servicios vendidos creados"

        """
        CROQUIS
        """
        
        for i, t in enumerate(tiendas):
            tie[i].dibujable.croquis.append(
                Croquis(creador=tie[i].rastreable.rastreable_id)
            )
            tie[i].dibujable.croquis[0].puntos.append(t[13])

        print "Croquis creados"

        """
        PALABRA
        """

        pal = Palabra('Avion')
        DBSession.add(pal)
        print "Palabra creada"

        """
        ESTADISTICAS
        """

        tie[1].buscable.estadisticas_de_visitas.append(
            EstadisticasDeVisitas(territorio=paAmbrosio)
        )
        pro[3].calificable_seguible.estadisticas_de_popularidad.append(
            EstadisticasDePopularidad(territorio=paAmbrosio)
        )
        pal.estadisticas_de_influencia.append(
            EstadisticasDeInfluencia(territorio=paAmbrosio)
        )
        print "Estadisticas creadas"

if __name__ == '__main__':
    main()
