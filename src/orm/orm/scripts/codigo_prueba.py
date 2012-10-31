# -*- coding: utf-8 -*-

from orm.scripts.cargar_constantes import hash_cat
from orm.busquedas import Busqueda, ResultadoDeBusqueda
from orm.comunes import DBSession
from orm.consumidores import Consumidor, Sexo, GrupoDeEdad, GradoDeInstruccion
from orm.territorios import Territorio
from orm.generales import Categoria
from orm.usuarios import Usuario
from orm.patrocinantes_publicidades import Patrocinante, Publicidad
from orm.calificaciones_resenas import CalificacionResena, Seguimiento
from orm.tiendas_productos import (
    Producto, 
    Tienda, 
    HorarioDeTrabajo, 
    Turno,
    Inventario
)
from orm.mensajes import Mensaje
from sqlalchemy import and_
from datetime import date, time
import transaction

def main():
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
            contrasena='$2a$12$1wugqI8R4mC8MHEVPimxgO60m9Zoj.8P1BLj1kSrDTOIOgoaiEe0i')

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
            contrasena='$2a$12$QWVsuxBClsziPjNwSbD9XOQ2dvpgUOeJrk0Yz73wQecCBMptqBPuC'
        )

        con2 = Consumidor(
            creador=1, nombre='Alejandro', apellido='Ocando', estatus='Activo', 
            sexo='Hombre', fecha_de_nacimiento=date(1992,2,20), 
            ubicacion=paSBenito, correo_electronico='tetero@dalepues.com', 
            grupo_de_edad='Adultos jovenes', 
            grado_de_instruccion='Universitaria',
            contrasena='$2a$12$xTWHSsODzmGI3l1unnlfCuFvErZRsUFtbcgVnn2Dn7CB5U1DT0Tlu'
        )

        con3 = Consumidor(
            creador=1, nombre='Alejandro', apellido='Maita', estatus='Activo', 
            sexo='Hombre', fecha_de_nacimiento=date(1987,5,28), 
            ubicacion=paAmbrosio, correo_electronico='cabeza@demonda.com', 
            grupo_de_edad='Adultos jovenes', 
            grado_de_instruccion='Universitaria',
            contrasena='$2a$12$l81W0FstK/79PIlJMCbk6ePY/98BkhHcMpRAh1/6R03QwtU/VkA3i'
        )

        con4 = Consumidor(
            creador=1, nombre='Snaillyn', apellido='Sosa', estatus='Activo', 
            sexo='Mujer', fecha_de_nacimiento=date(1987,9,14), 
            ubicacion=paLaRosa, correo_electronico='quefuecomo@estais.com',
            grupo_de_edad='Adultos jovenes', 
            grado_de_instruccion='Universitaria',
            contrasena='$2a$12$sNqgTN0xvMSWC6BulGjBV.JMdAs91MG4LKEQ/WclWvA/TAxpCdcUC'
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
            contrasena='$2a$12$IkgN0Mklv/fUgi.KbDBLku/yZhI.kbjMDObY7zdMnr03t7Aigx3z.')
        
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

        cal1 = CalificacionResena(
            calificable_seguible=cat2b00.productos[0].calificable_seguible, 
            consumidor=con1 , calificacion='Mal', resena='Sed ut perspiciatis,'
            ' unde omnis iste natus error sit voluptatem accusantium doloremque'            ' laudantium, totam rem aperiam eaque ipsa, quae ab illo inventore '
            'veritatis et quasi architecto beatae vitae dicta sunt, explicabo.'
        )
    
        DBSession.add(cal1)

        """
        SEGUIDOR
        """
    
        seg1 = Seguimiento(
            calificable_seguible=pro4.calificable_seguible, 
            consumidor=con3, avisar_si='Lo ponen gratis'
        )

        DBSession.add(seg1)
    

if __name__ == '__main__':
    main()
