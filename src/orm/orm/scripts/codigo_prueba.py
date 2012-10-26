# -*- coding: utf-8 -*-

from orm.scripts.cargar_constantes import hash_cat
from orm.comunes import DBSession
from orm.territorios import Territorio
from orm.generales import Categoria
from orm.usuarios import Usuario
from orm.tiendas_productos import Producto, Tienda
from sqlalchemy import and_
from datetime import date
import transaction

def main():
    with transaction.manager:
        pyVenezuela = DBSession.query(Territorio.territorio_id).filter(
            and_(Territorio.nombre == 'Venezuela', Territorio.nivel == 1)
        ).first()[0]

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

        paCHerrera = DBSession.query(Territorio.territorio_id).\
        filter_by(nombre='Carmen Herrera').first()[0]

        paLaRosa = DBSession.query(Territorio.territorio_id).\
        filter_by(nombre='La Rosa').first()[0]

        paAmbrosio = DBSession.query(Territorio.territorio_id).\
        filter_by(nombre='Ambrosio').first()[0]

        paSBenito = DBSession.query(Territorio.territorio_id).\
        filter_by(nombre='San Benito').first()[0]

        paPtaGorda = DBSession.query(Territorio.territorio_id).\
        filter_by(nombre='Punta Gorda').first()[0]

        cat2b00.productos.append(
            Producto(
                creador=1, tipo_de_codigo='GTIN-13', codigo='P-001', 
                estatus='Activo', fabricante='Silicon Graphics', 
                modelo='CMN B014ANT300', nombre='02', 
                debut_en_el_mercado=date(2001,2,20), largo=3.64, 
                ancho=2.18, alto=2.18, peso=3.94, pais_de_origen=pyVenezuela
            )
        )

        cat2a00.productos.append(
            Producto(
                creador=1, tipo_de_codigo='GTIN-13', codigo='P-002', 
                estatus='Activo', fabricante='Nokia', 
                modelo='N78', nombre='N78', 
                debut_en_el_mercado=date(1994,8,15), largo=3.64, 
                ancho=2.18, alto=2.18, peso=0.14, pais_de_origen=pyVenezuela
            )
        )

        cat2100.productos.append(
            Producto(
                creador=1, tipo_de_codigo='GTIN-13', codigo='P-004', 
                estatus='Activo', fabricante='Shure', 
                modelo='SM57', nombre='SM57', 
                debut_en_el_mercado=date(1996,9,23), largo=3.64, 
                ancho=2.18, alto=2.18, peso=0.45, pais_de_origen=pyVenezuela
            )
        )

        cat2200.productos.append(
            Producto(
                creador=1, tipo_de_codigo='GTIN-13', codigo='P-003', 
                estatus='Activo', fabricante='Nintendo', 
                modelo='NUS-001', nombre='Nintendo 64 Control', 
                debut_en_el_mercado=date(1996,9,23), largo=3.64, 
                ancho=2.18, alto=2.18, peso=0.21, pais_de_origen=pyVenezuela
            )
        )

        ursucorodorant = Usuario(
            creador=1, nombre='Ursula', apellido='Dorante', estatus='Activo',
            ubicacion_id=paCHerrera, correo_electronico='molleja@abc.com', 
            contrasena='$2a$12$1wugqI8R4mC8MHEVPimxgO60m9Zoj.8P1BLj1kSrDTOIOgoaiEe0i')
        DBSession.add(ursucorodorant)
        DBSession.flush()
        tie = Tienda(
            ubicacion_id=paAmbrosio, rif='V180638080', 
            propietario_id=ursucorodorant.usuario_id,
            categoria=cat2000.categoria_id, estatus='Activo', 
            nombre_legal='Inversiones 2500 C.A.', 
            nombre_comun='La Boutique Electronica', telefono='0264-2415497',
            calle='La Estrella con Jose Maria Vargas', 
            sector_urb_barrio='Bello Monte', 
            facebook='http://www.facebook.com/laboutiqueelectronica',
            correo_electronico_publico=ursucorodorant.acceso.\
            correo_electronico
        )
        DBSession.add(tie)

if __name__ == '__main__':
    main()
