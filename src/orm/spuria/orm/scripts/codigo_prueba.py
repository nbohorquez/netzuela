# -*- coding: utf-8 -*-

from comunes import ARCHIVO_CONFIG
from datetime import date, time, datetime, timedelta
from spuria.orm import (
    Busqueda, ResultadoDeBusqueda, DBSession, Consumidor, Sexo, GrupoDeEdad, 
    GradoDeInstruccion, Territorio, Categoria, EstadisticasDeVisitas, 
    EstadisticasDePopularidad, EstadisticasDeInfluencia, Usuario, Palabra,
    Croquis, Punto, Descripcion, Foto, Patrocinante, Publicidad, 
    CalificacionResena, Seguimiento, Producto, Tienda, HorarioDeTrabajo, Turno,
    Inventario, Mensaje, Factura, ServicioVendido, inicializar
)
from sqlalchemy import and_
import transaction

def main():
    inicializar(archivo=ARCHIVO_CONFIG)

    with transaction.manager:
        """
        PRODUCTOS
        """
        pyVenezuela = DBSession.query(Territorio).filter(
            and_(Territorio.nombre == 'Venezuela', Territorio.nivel == 1)
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

        cat3000 = DBSession.query(Categoria).filter_by(
            nombre='Alimentos - Hogar'
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

        pro1 = Producto(
            creador=1, tipo_de_codigo='GTIN-13', codigo='P-001', 
            estatus='Activo', fabricante='Silicon Graphics', 
            modelo='CMN B014ANT300', nombre='02', 
            debut_en_el_mercado=date(2001,2,20), largo=3.64, 
            ancho=2.18, alto=2.18, peso=3.94, pais_de_origen=pyVenezuela,
            categoria=cat2b00
        )

        pro2 = Producto(
            creador=1, tipo_de_codigo='GTIN-13', codigo='P-002', 
            estatus='Activo', fabricante='Nokia', 
            modelo='N78', nombre='N78', 
            debut_en_el_mercado=date(1994,8,15), largo=3.64, 
            ancho=2.18, alto=2.18, peso=0.14, pais_de_origen=pyVenezuela,
            categoria=cat2a00
        )

        pro3 = Producto(
            creador=1, tipo_de_codigo='GTIN-13', codigo='P-004', 
            estatus='Activo', fabricante='Shure', 
            modelo='SM57', nombre='SM57', 
            debut_en_el_mercado=date(1996,9,23), largo=3.64, 
            ancho=2.18, alto=2.18, peso=0.45, pais_de_origen=pyVenezuela,
            categoria=cat2100
        )

        pro4 = Producto(
            creador=1, tipo_de_codigo='GTIN-13', codigo='P-003', 
            estatus='Activo', fabricante='Nintendo', 
            modelo='NUS-001', nombre='Nintendo 64 Control', 
            debut_en_el_mercado=date(1996,9,23), largo=3.64, 
            ancho=2.18, alto=2.18, peso=0.21, pais_de_origen=pyVenezuela,
            categoria=cat2200
        )

        DBSession.add_all([pro1, pro2, pro3, pro4])

        usu1 = Usuario(
            creador=1, nombre='Ursula', apellido='Dorante', estatus='Activo',
            ubicacion=paCHerrera, correo_electronico='molleja@abc.com', 
            contrasena='$2a$12$1wugqI8R4mC8MHEVPimxgO60m9Zoj.8P1BLj1kSrDTOIOgoa'
            'iEe0i'
        )

        DBSession.add(usu1)
        #transaction.commit()
        DBSession.flush()
        """
        TIENDAS
        """
        tie1 = Tienda(
            ubicacion=paAmbrosio, rif='V180638080', 
            propietario=usu1, categoria=cat2000, estatus='Activo', 
            nombre_legal='Inversiones 2500 C.A.', 
            nombre_comun='La Boutique Electronica', telefono='0264-2415497',
            calle='La Estrella con Jose Maria Vargas', 
            sector_urb_barrio='Bello Monte', 
            facebook='http://www.facebook.com/laboutiqueelectronica',
            correo_electronico_publico=usu1.acceso.correo_electronico
        )

        DBSession.add(tie1)

        tie1.horarios_de_trabajo.append(HorarioDeTrabajo('Lunes', True))
        tie1.horarios_de_trabajo.append(HorarioDeTrabajo('Martes', True))
        tie1.horarios_de_trabajo.append(HorarioDeTrabajo('Miercoles', True))
        tie1.horarios_de_trabajo.append(HorarioDeTrabajo('Jueves', True))
        tie1.horarios_de_trabajo.append(HorarioDeTrabajo('Viernes', True))
        tie1.horarios_de_trabajo.append(HorarioDeTrabajo('Sabado', False))
        tie1.horarios_de_trabajo.append(HorarioDeTrabajo('Domingo', False))

        tie1.horarios_de_trabajo[0].turnos.append(Turno(time(8), time(16)))
        tie1.horarios_de_trabajo[1].turnos.append(Turno(time(8), time(16)))
        tie1.horarios_de_trabajo[2].turnos.append(Turno(time(8), time(16)))
        tie1.horarios_de_trabajo[3].turnos.append(Turno(time(8), time(16)))
        tie1.horarios_de_trabajo[4].turnos.append(Turno(time(8), time(16)))
        tie1.horarios_de_trabajo[5].turnos.append(Turno(time(0), time(0)))
        tie1.horarios_de_trabajo[6].turnos.append(Turno(time(0), time(0)))

        tie2 = Tienda(
            ubicacion=paAmbrosio, rif='J151545970', 
            propietario=usu1, categoria=cat2000, estatus='Activo', 
            nombre_legal='Fralneca C.A.', 
            nombre_comun='Planeta Virtual', telefono='0264-3711515',
            calle='Zulia', casa='3194', sector_urb_barrio='La Rosa', 
            facebook='http://www.facebook.com/laboutiqueelectronica',
            correo_electronico_publico='tca7410nb@hmail.com'
        )
        
        DBSession.add(tie2)

        tie2.horarios_de_trabajo.append(HorarioDeTrabajo('Lunes', True))
        tie2.horarios_de_trabajo.append(HorarioDeTrabajo('Martes', True))
        tie2.horarios_de_trabajo.append(HorarioDeTrabajo('Miercoles', True))
        tie2.horarios_de_trabajo.append(HorarioDeTrabajo('Jueves', True))
        tie2.horarios_de_trabajo.append(HorarioDeTrabajo('Viernes', True))
        tie2.horarios_de_trabajo.append(HorarioDeTrabajo('Sabado', True))
        tie2.horarios_de_trabajo.append(HorarioDeTrabajo('Domingo', True))

        tie2.horarios_de_trabajo[0].turnos.append(Turno(time(11), time(22)))
        tie2.horarios_de_trabajo[1].turnos.append(Turno(time(11), time(22)))
        tie2.horarios_de_trabajo[2].turnos.append(Turno(time(11), time(22)))
        tie2.horarios_de_trabajo[3].turnos.append(Turno(time(11), time(22)))
        tie2.horarios_de_trabajo[4].turnos.append(Turno(time(11), time(22,30)))
        tie2.horarios_de_trabajo[5].turnos.append(Turno(time(11), time(22,30)))
        tie2.horarios_de_trabajo[6].turnos.append(Turno(time(11), time(22)))

        """
        INVENTARIO
        """

        tie1.inventario.append(
            Inventario(
                tienda=tie1, codigo='TD-015SC', 
                descripcion='Computadora SGI 02', visibilidad="Ambos visibles", 
                producto=cat2b00.productos[0], precio=640.00, 
                cantidad=12
            )
        )   
            
        tie1.inventario.append(
            Inventario(
                tienda=tie1, codigo='TD-1841C', 
                descripcion='Celular N78 Ve', visibilidad="Ambos visibles", 
                producto=cat2a00.productos[0], precio=104.00, 
                cantidad=9
            )
        )   

        tie1.inventario.append(
            Inventario(
                tienda=tie1, codigo='TD-99410', 
                descripcion='Control N64 Gris', visibilidad="Ambos visibles", 
                producto=cat2200.productos[0], precio=324.48, 
                cantidad=2
            )
        )

        tie2.inventario.append(
            Inventario(
                tienda=tie2, codigo='PSDC-SC0', 
                descripcion='Silicon Graphics 02', visibilidad="Ambos visibles",
                producto=cat2b00.productos[0], precio=605.95, 
                cantidad=4
            )
        )

        tie2.inventario.append(
            Inventario(
                tienda=tie2, codigo='PSDC-41C', 
                descripcion='Microfono en vivo SM57 XLR', 
                visibilidad="Ambos visibles", 
                producto=cat2100.productos[0], precio=1500.00, 
                cantidad=4
            )
        )

        """
        CONSUMIDOR
        """

        con1 = Consumidor(
            creador=1, nombre='Alberto', apellido='Atkins', estatus='Activo', 
            sexo='Hombre', fecha_de_nacimiento=date(1988,6,9), 
            ubicacion=paPtaGorda, correo_electronico='mandoca@merey.com', 
            grupo_de_edad='Adultos jovenes', 
            grado_de_instruccion='Universitaria',
            contrasena='$2a$12$QWVsuxBClsziPjNwSbD9XOQ2dvpgUOeJrk0Yz73wQecCBMpt'
            'qBPuC'
        )

        con2 = Consumidor(
            creador=1, nombre='Alejandro', apellido='Ocando', estatus='Activo', 
            sexo='Hombre', fecha_de_nacimiento=date(1992,2,20), 
            ubicacion=paSBenito, correo_electronico='tetero@dalepues.com', 
            grupo_de_edad='Adultos jovenes', 
            grado_de_instruccion='Universitaria',
            contrasena='$2a$12$xTWHSsODzmGI3l1unnlfCuFvErZRsUFtbcgVnn2Dn7CB5U1D'
            'T0Tlu'
        )

        con3 = Consumidor(
            creador=1, nombre='Alejandro', apellido='Maita', estatus='Activo', 
            sexo='Hombre', fecha_de_nacimiento=date(1987,5,28), 
            ubicacion=paAmbrosio, correo_electronico='cabeza@demonda.com', 
            grupo_de_edad='Adultos jovenes', 
            grado_de_instruccion='Universitaria',
            contrasena='$2a$12$l81W0FstK/79PIlJMCbk6ePY/98BkhHcMpRAh1/6R03QwtU/'
            'VkA3i'
        )

        con4 = Consumidor(
            creador=1, nombre='Snaillyn', apellido='Sosa', estatus='Activo', 
            sexo='Mujer', fecha_de_nacimiento=date(1987,9,14), 
            ubicacion=paLaRosa, correo_electronico='quefuecomo@estais.com',
            grupo_de_edad='Adultos jovenes', 
            grado_de_instruccion='Universitaria',
            contrasena='$2a$12$sNqgTN0xvMSWC6BulGjBV.JMdAs91MG4LKEQ/WclWvA/TAxp'
            'CdcUC'
        )

        DBSession.add_all([con1, con2, con3, con4])
        #transaction.commit()
        DBSession.flush()

        """
        MENSAJE
        """
        
        men = Mensaje(
            remitente = con2.interlocutor, destinatario = tie1.interlocutor,
            contenido = 'El cielo resplancede a mi alrededor...'
        )
        
        DBSession.add(men)

        usu2 = Usuario(
            creador=1, nombre='Maria', apellido='Gonzalez', estatus='Activo',
            ubicacion=paAmbrosio, correo_electronico='hola@comoestais.com', 
            contrasena='$2a$12$IkgN0Mklv/fUgi.KbDBLku/yZhI.kbjMDObY7zdMnr03t7Ai'
            'gx3z.'
        )
        
        DBSession.add(usu2)
        #transaction.commit()
        DBSession.flush()

        """
        PATROCINANTE
        """

        pat1 = Patrocinante(
            propietario=usu2, ubicacion=paAmbrosio, 
            categoria=cat3000, rif='V195445890', estatus='Activo',
            nombre_legal='Yordonal C.A.', nombre_comun='Yordonal', 
            telefono='0264-2518490', calle='Igualdad', 
            sector_urb_barrio='Ambrosio', 
            facebook='http://www.facebook.com/yordonal',
            correo_electronico_publico=usu2.acceso.correo_electronico
        )

        DBSession.add(pat1)
        DBSession.flush()

        """
        PUBLICIDAD
        """

        pat1.publicidades.append(
            Publicidad(
                patrocinante=pat1, nombre='Coca-Cola es inimitable y verga...'
            )
        )

        adultos_jovenes = DBSession.query(GrupoDeEdad).\
        filter_by(valor = 'Adultos jovenes').first()

        universitaria = DBSession.query(GradoDeInstruccion).\
        filter_by(valor = 'Universitaria').first()

        ambrosio = DBSession.query(Territorio).\
        filter_by(territorio_id = paAmbrosio).first()

        hombres = DBSession.query(Sexo).filter_by(valor = 'Hombre').first()

        pat1.publicidades[0].grupos_de_edades.append(adultos_jovenes)
        pat1.publicidades[0].grados_de_instruccion.append(universitaria)
        pat1.publicidades[0].territorios.append(ambrosio)
        pat1.publicidades[0].sexos.append(hombres)
        pat1.publicidades[0].consumidores.append(con3)

        """
        BUSCAR
        """

        bus1 = Busqueda(usuario=con3, contenido='motor de aviones')

        DBSession.add(bus1)

        res1 = ResultadoDeBusqueda(
            busqueda=bus1, buscable=cat2a00.productos[0].buscable,
            relevancia=0.85, visitado=True
        )
        DBSession.add(res1)

        """
        CALIFICACION Y RESEÑA
        """

        cal = [0]*18

        cal[0] = CalificacionResena(
            cat2b00.productos[0].calificable_seguible, con1 , 'Mal', 'Sed ut '
            'perspiciatis, unde omnis iste natus error sit voluptatem accusanti'
            'um doloremque laudantium, totam rem aperiam eaque ipsa, quae ab il'
            'lo inventore veritatis et quasi architecto beatae vitae dicta sunt'
            ', explicabo.'
        )
        cal[1] = CalificacionResena(
            pro1.calificable_seguible, con3, 'Mal', 'Sed ut perspiciatis, unde '
            'omnis iste natus error sit voluptatem accusantium doloremque lauda'
            'ntium, totam rem aperiam eaque ipsa, quae ab illo inventore verita'
            'tis et quasi architecto beatae vitae dicta sunt, explicabo.'
        )
        cal[2] = CalificacionResena(
            pro1.calificable_seguible, con2, 'Bien', 'Deb'
            'et oporteat mel et. Mei eu modo referrentur dissentiunt, pri in vi'            'ris singulis, dicam ancillae sed ad.'
        )
        cal[3] = CalificacionResena(
            pro2.calificable_seguible, con4, 'Bien', 'Graecis periculis ex nam,'
            ' mel ridens persius et. In probatus reprehendunt duo, evertitur gl'
            'oriatur est ad.'
        )
        cal[4] = CalificacionResena(
            pro2.calificable_seguible, con1, 'Mal', 'Essent persecuti neglegent'
            'ur sea no, qui forensibus deseruisse concludaturque ad. Veniam pos'
            'sit eos cu. Te quo partem quidam detraxit. Illum numquam no duo. N'
            'ihil pericula prodesset ea his, in pri sint possim accusamus.'
        )
        cal[5] = CalificacionResena(
            pro2.calificable_seguible, con3, 'Bien', 'Graecis periculis ex nam,'
            ' mel ridens persius et. In probatus reprehendunt duo, evertitur gl'
            'oriatur est ad.'
        )
        cal[6] = CalificacionResena(
            pro3.calificable_seguible, con1, 'Mal', 'Debet oporteat mel et. Mei'
            ' eu modo referrentur dissentiunt, pri in viris singulis, dicam anc'
            'illae sed ad.'
        )
        cal[7] = CalificacionResena(
            pro3.calificable_seguible, con4, 'Mal', 'Sed ut perspiciatis, unde '
            'omnis iste natus error sit voluptatem accusantium doloremque lauda'
            'ntium, totam rem aperiam eaque ipsa, quae ab illo inventore verita'
            'tis et quasi architecto beatae vitae dicta sunt, explicabo.'
        )
        cal[8] = CalificacionResena(
            pro3.calificable_seguible, con2, 'Bien', 'Usu graeci scaevola in, i'
            'us elitr verear no. Sed ex brute integre maiestatis. Per an admodu'
            'm recusabo, ne sit meis officiis aliquando.'
        )
        cal[9] = CalificacionResena(
            pro4.calificable_seguible, con4, 'Bien', 'An hinc scripserit vel, e'            'a omnis menandri referrentur usu.'
        )
        cal[10] = CalificacionResena(
            pro4.calificable_seguible, con3, 'Mal', 'Usu graeci scaevola in, iu'
            's elitr verear no. Sed ex brute integre maiestatis. Per an admodum'
            ' recusabo, ne sit meis officiis aliquando.'
        )
        cal[11] = CalificacionResena(
            pro4.calificable_seguible, con1, 'Bien', 'Essent persecuti neglegen'
            'tur sea no, qui forensibus deseruisse concludaturque ad. Veniam po'
            'ssit eos cu. Te quo partem quidam detraxit.'
        )
        cal[12] = CalificacionResena(
            tie1.calificable_seguible, con4, 'Mal', 'Simul singulis mea ei. Cum'
            ' ad saepe eruditi pericula, habeo maluisset cu per. Ut vide quas q'
            'ui, vim meis graece consequuntur ea, sit utinam laoreet habemus ea'
            '. At summo suscipit petentium est, dicit vidisse voluptua ei mei. '
            'Duo id aperiam menandri.'
        )
        cal[13] = CalificacionResena(
            tie1.calificable_seguible, con3, 'Bien', 'An hinc scripserit vel, e'
            'a omnis menandri referrentur usu.'
        )
        cal[14] = CalificacionResena(
            tie1.calificable_seguible, con1, 'Bien', 'Simul singulis mea ei. Cu'
            'm ad saepe eruditi pericula, habeo maluisset cu per. Ut vide quas '
            'qui, vim meis graece consequuntur ea, sit utinam laoreet habemus e'
            'a. At summo suscipit petentium est, dicit vidisse voluptua ei mei.'
            ' Duo id aperiam menandri.'
        )
        cal[15] = CalificacionResena(
            tie2.calificable_seguible, con2, 'Mal', 'Graecis periculis ex nam, '
            'mel ridens persius et. In probatus reprehendunt duo, evertitur glo'
            'riatur est ad.'
        )
        cal[16] = CalificacionResena(
            tie2.calificable_seguible, con1, 'Bien', 'Sed ut perspiciatis, unde'
            ' omnis iste natus error sit voluptatem accusantium doloremque laud'
            'antium, totam rem aperiam eaque ipsa, quae ab illo inventore verit'
            'atis et quasi architecto beatae vitae dicta sunt, explicabo.'
        )
        cal[17] = CalificacionResena(
            tie2.calificable_seguible, con4, 'Mal', 'Essent persecuti neglegent'
            'ur sea no, qui forensibus deseruisse concludaturque ad. Veniam pos'
            'sit eos cu. Te quo partem quidam detraxit. Illum numquam no duo. N'
            'ihil pericula prodesset ea his, in pri sint possim accusamus.'
        )

        DBSession.add_all(cal)

        """
        SEGUIDOR
        """
    
        seg1 = Seguimiento(
            calificable_seguible=pro4.calificable_seguible, 
            consumidor=con3, avisar_si='Lo ponen gratis'
        )

        DBSession.add(seg1)

        """
        DESCRIPCION
        """

        des = [0]*6

        des[0] = Descripcion(
            describible=pro1.describible, contenido='Raw denim'
            'you probably haven\'t heard of them jean shorts Austin. Nesciunt t'
            'ofu stumptown aliqua, retro synth master cleanse. Mustache cliche '
            'tempor, williamsburg carles vegan helvetica. Reprehenderit butcher'
            ' retro keffiyeh dreamcatcher synth. Cosby sweater eu banh mi, qui '
            'irure terry richardson ex squid. Aliquip placeat salvia cillum iph'
            'one. Seitan aliquip quis cardigan american apparel, butcher volupt'
            'ate nisi qui.', creador=tie1.rastreable.rastreable_id
        )
        des[1] = Descripcion(
            describible=pro2.describible, contenido='Raw denim'
            ' you probably haven\'t heard of them jean shorts Austin. Nesciunt '
            'tofu stumptown aliqua, retro synth master cleanse. Mustache cliche'
            ' tempor, williamsburg carles vegan helvetica. Reprehenderit butche'
            'r retro keffiyeh dreamcatcher synth. Cosby sweater eu banh mi, qui'
            ' irure terry richardson ex squid. Aliquip placeat salvia cillum ip'
            'hone. Seitan aliquip quis cardigan american apparel, butcher volup'
            'tate nisi qui.', creador=tie1.rastreable.rastreable_id
        )
        des[2] = Descripcion(
            describible=pro3.describible, contenido='Raw denim'
            ' you probably haven\'t heard of them jean shorts Austin. Nesciunt '
            'tofu stumptown aliqua, retro synth master cleanse. Mustache cliche'
            ' tempor, williamsburg carles vegan helvetica. Reprehenderit butche'
            'r retro keffiyeh dreamcatcher synth. Cosby sweater eu banh mi, qui'
            ' irure terry richardson ex squid. Aliquip placeat salvia cillum ip'
            'hone. Seitan aliquip quis cardigan american apparel, butcher volup'
            'tate nisi qui.', creador=tie2.rastreable.rastreable_id
        )
        des[3] = Descripcion(
            describible=pro4.describible, contenido='Raw denim'
            ' you probably haven\'t heard of them jean shorts Austin. Nesciunt '
            'tofu stumptown aliqua, retro synth master cleanse. Mustache cliche'
            ' tempor, williamsburg carles vegan helvetica. Reprehenderit butche'
            'r retro keffiyeh dreamcatcher synth. Cosby sweater eu banh mi, qui'
            ' irure terry richardson ex squid. Aliquip placeat salvia cillum ip'
            'hone. Seitan aliquip quis cardigan american apparel, butcher volup'
            'tate nisi qui.', creador=tie2.rastreable.rastreable_id
        )
        des[4] = Descripcion(
            describible=tie1.describible, contenido='Raw denim'
            ' you probably haven\'t heard of them jean shorts Austin. Nesciunt '
            'tofu stumptown aliqua, retro synth master cleanse. Mustache cliche'
            ' tempor, williamsburg carles vegan helvetica. Reprehenderit butche'
            'r retro keffiyeh dreamcatcher synth. Cosby sweater eu banh mi, qui'
            ' irure terry richardson ex squid. Aliquip placeat salvia cillum ip'
            'hone. Seitan aliquip quis cardigan american apparel, butcher volup'
            'tate nisi qui.', creador=tie1.rastreable.rastreable_id
        )
        des[5] = Descripcion(
            describible=tie2.describible, contenido='Raw denim'
            ' you probably haven\'t heard of them jean shorts Austin. Nesciunt '
            'tofu stumptown aliqua, retro synth master cleanse. Mustache cliche'
            ' tempor, williamsburg carles vegan helvetica. Reprehenderit butche'
            'r retro keffiyeh dreamcatcher synth. Cosby sweater eu banh mi, qui'
            ' irure terry richardson ex squid. Aliquip placeat salvia cillum ip'
            'hone. Seitan aliquip quis cardigan american apparel, butcher volup'
            'tate nisi qui.', creador=tie2.rastreable.rastreable_id
        )
    
        DBSession.add_all(des)

        """
        FOTOS
        """

        adm = DBSession.query(Usuario).\
        filter(and_(Usuario.nombre=='Nestor', Usuario.apellido=='Bohorquez')).\
        first()

        fotos = [
            {'describible':adm.describible , 'rutas': [
                'img/grandes/0e/be/c63e852375da368b378c8651fe38fd5b5569.jpg',
                'img/medianas/0e/be/c63e852375da368b378c8651fe38fd5b5569.jpg', 
                'img/pequenas/0e/be/c63e852375da368b378c8651fe38fd5b5569.jpg', 
                'img/miniaturas/0e/be/c63e852375da368b378c8651fe38fd5b5569.jpg'
                ]
            },
            {'describible':con2.describible, 'rutas': [
                'img/grandes/5b/d7/d5972a4777b2fdd3729755908d1000238cde.jpg', 
                'img/medianas/5b/d7/d5972a4777b2fdd3729755908d1000238cde.jpg', 
                'img/pequenas/5b/d7/d5972a4777b2fdd3729755908d1000238cde.jpg', 
                'img/miniaturas/5b/d7/d5972a4777b2fdd3729755908d1000238cde.jpg'
                ]
            },
            {'describible':usu1.describible, 'rutas': [
                'img/grandes/52/a3/a3dc8ce14a9a3b86ee112a3f83fd264182a4.jpg', 
                'img/medianas/52/a3/a3dc8ce14a9a3b86ee112a3f83fd264182a4.jpg', 
                'img/pequenas/52/a3/a3dc8ce14a9a3b86ee112a3f83fd264182a4.jpg', 
                'img/miniaturas/52/a3/a3dc8ce14a9a3b86ee112a3f83fd264182a4.jpg'
                ]
            },
            {'describible':con4.describible, 'rutas': [
                'img/grandes/50/e3/207bdea8f8e99845c8a0130b2f0d4148d7bc.jpg', 
                'img/medianas/50/e3/207bdea8f8e99845c8a0130b2f0d4148d7bc.jpg', 
                'img/pequenas/50/e3/207bdea8f8e99845c8a0130b2f0d4148d7bc.jpg', 
                'img/miniaturas/50/e3/207bdea8f8e99845c8a0130b2f0d4148d7bc.jpg'
                ]
            },
            {'describible':con2.describible, 'rutas': [
                'img/grandes/35/2a/3e8e874b89c2f02b51008ea4392ac81452ad.jpg', 
                'img/medianas/35/2a/3e8e874b89c2f02b51008ea4392ac81452ad.jpg', 
                'img/pequenas/35/2a/3e8e874b89c2f02b51008ea4392ac81452ad.jpg', 
                'img/miniaturas/35/2a/3e8e874b89c2f02b51008ea4392ac81452ad.jpg'
                ]
            },
            {'describible':usu2.describible, 'rutas': [
                'img/grandes/a1/7e/e914e3995067d4bcd0684f655a9d974e6638.jpg', 
                'img/medianas/a1/7e/e914e3995067d4bcd0684f655a9d974e6638.jpg', 
                'img/pequenas/a1/7e/e914e3995067d4bcd0684f655a9d974e6638.jpg', 
                'img/miniaturas/a1/7e/e914e3995067d4bcd0684f655a9d974e6638.jpg'
                ]
            },
            {'describible':con1.describible, 'rutas': [
                'img/grandes/c7/2d/4e93387299a52c28394c8e522097782dcf47.jpg', 
                'img/medianas/c7/2d/4e93387299a52c28394c8e522097782dcf47.jpg', 
                'img/pequenas/c7/2d/4e93387299a52c28394c8e522097782dcf47.jpg', 
                'img/miniaturas/c7/2d/4e93387299a52c28394c8e522097782dcf47.jpg'
                ]
            },
            {'describible':pro1.describible, 'rutas': [
                'img/grandes/ca/b7/fedd1d4a20b1437e8c99e84afdbf5dba5975.jpg', 
                'img/medianas/ca/b7/fedd1d4a20b1437e8c99e84afdbf5dba5975.jpg', 
                'img/pequenas/ca/b7/fedd1d4a20b1437e8c99e84afdbf5dba5975.jpg', 
                'img/miniaturas/ca/b7/fedd1d4a20b1437e8c99e84afdbf5dba5975.jpg'
                ]
            },
            {'describible':pro2.describible, 'rutas': [
                'img/grandes/e4/71/0923ec6527e7546eccc6f1e984eae96d7d24.jpg', 
                'img/medianas/e4/71/0923ec6527e7546eccc6f1e984eae96d7d24.jpg',
                'img/pequenas/e4/71/0923ec6527e7546eccc6f1e984eae96d7d24.jpg', 
                'img/miniaturas/e4/71/0923ec6527e7546eccc6f1e984eae96d7d24.jpg'
                ]
            },
            {'describible':pro3.describible, 'rutas': [
                'img/grandes/fe/4f/84ca1019e0dbf638fe8589969ef6438841ec.jpg', 
                'img/medianas/fe/4f/84ca1019e0dbf638fe8589969ef6438841ec.jpg',
                'img/pequenas/fe/4f/84ca1019e0dbf638fe8589969ef6438841ec.jpg',
                'img/miniaturas/fe/4f/84ca1019e0dbf638fe8589969ef6438841ec.jpg'
                ]
            },
            {'describible':pro4.describible, 'rutas': [
                'img/grandes/bb/b9/5f60c4299607a49411be2d555ca21265186d.jpg', 
                'img/medianas/bb/b9/5f60c4299607a49411be2d555ca21265186d.jpg', 
                'img/pequenas/bb/b9/5f60c4299607a49411be2d555ca21265186d.jpg', 
                'img/miniaturas/bb/b9/5f60c4299607a49411be2d555ca21265186d.jpg'
                ]
            },
            {'describible':tie1.describible, 'rutas': [
                'img/grandes/7f/55/0ef228ae58fcf572fe099c2aaf75f40950c2.jpg', 
                'img/medianas/7f/55/0ef228ae58fcf572fe099c2aaf75f40950c2.jpg',
                'img/pequenas/7f/55/0ef228ae58fcf572fe099c2aaf75f40950c2.jpg',
                'img/miniaturas/7f/55/0ef228ae58fcf572fe099c2aaf75f40950c2.jpg',
                'img/grandes/5a/ae/c182e3c94f7c40774bbdc0d97ff4cfaa776a.jpg',
                'img/medianas/5a/ae/c182e3c94f7c40774bbdc0d97ff4cfaa776a.jpg',
                'img/pequenas/5a/ae/c182e3c94f7c40774bbdc0d97ff4cfaa776a.jpg',
                'img/miniaturas/5a/ae/c182e3c94f7c40774bbdc0d97ff4cfaa776a.jpg'
                ]
            },
            {'describible':tie2.describible, 'rutas': [
                'img/grandes/5a/ae/c182e3c94f7c40774bbdc0d97ff4cfaa776a.jpg', 
                'img/medianas/5a/ae/c182e3c94f7c40774bbdc0d97ff4cfaa776a.jpg',
                'img/pequenas/5a/ae/c182e3c94f7c40774bbdc0d97ff4cfaa776a.jpg',
                'img/miniaturas/5a/ae/c182e3c94f7c40774bbdc0d97ff4cfaa776a.jpg'
                ]
            }
        ]

        F = [Foto(foto['describible'], ruta) 
             for foto in fotos 
             for ruta in foto['rutas']]

        DBSession.add_all(F)

        """
        FACTURA
        """

        fac = Factura(pat1, datetime.now(), datetime.now() + timedelta(days=30))
        DBSession.add(fac)

        sev = ServicioVendido(fac, pat1.publicidades[0].cobrable, 45454)
        DBSession.add(sev)

        """
        CROQUIS
        """

        tie1.dibujable.croquis.append(
            Croquis(creador=tie1.rastreable.rastreable_id)
        )
        tie1.dibujable.croquis[0].puntos.append(Punto(10.420891, -71.461491))

        tie2.dibujable.croquis.append(
            Croquis(creador=tie2.rastreable.rastreable_id)
        )
        tie2.dibujable.croquis[0].puntos.append(Punto(10.401457, -71.470045))

        """
        PALABRA
        """

        pal = Palabra('Avion')
        DBSession.add(pal)

        """
        ESTADISTICAS
        """

        tie1.buscable.estadisticas_de_visitas.append(
            EstadisticasDeVisitas(territorio=paAmbrosio)
        )
        pro4.calificable_seguible.estadisticas_de_popularidad.append(
            EstadisticasDePopularidad(territorio=paAmbrosio)
        )
        pal.estadisticas_de_influencia.append(
            EstadisticasDeInfluencia(territorio=paAmbrosio)
        )

if __name__ == '__main__':
    main()
