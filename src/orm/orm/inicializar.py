# -*- coding: utf-8 -*-

from orm.comunes import Base, DBSession
from orm.constantes import (
    codigos_de_error,
    privilegios,
    idiomas,
    tipos_de_codigo,
    sexos,
    grados_de_instruccion,
    visibilidades,
    acciones,
    calificaciones,
    grupos_de_edades,
    estatus,
    dias,
    arbol_categorias,
    puntos_venezuela
)
from orm.busquedas import Buscable, ResultadoDeBusqueda, Busqueda
from orm.estadisticas import (
    Estadisticas,
    EstadisticasTemporales, 
    EstadisticasDePopularidad, 
    EstadisticasDeInfluencia, 
    EstadisticasDeVisitas, 
    ContadorDeExhibiciones
)
from orm.rastreable import Rastreable
from orm.generales import Estatus, Categoria
from orm.registros import Accion, CodigoDeError, Registro
from orm.territorios import (
    Territorio, 
    TiendasConsumidores, 
    Region, 
    RegionTerritorio, 
    Idioma
)
from orm.mensajes import Mensaje, Interlocutor
from orm.tiendas_productos import (
    TipoDeCodigo, 
    Producto, 
    Visibilidad, 
    PrecioCantidad, 
    Inventario, 
    Tamano, 
    Tienda, 
    Dia, 
    HorarioDeTrabajo, 
    Turno
)
from orm.croquis_puntos import Punto, Croquis, PuntoDeCroquis, Dibujable
from orm.palabras import Etiquetable, Etiqueta, Palabra, RelacionDePalabras
from orm.usuarios import Cliente, Usuario, Acceso, Administrador, Privilegios
from orm.descripciones_fotos import Describible, Foto, Descripcion
from orm.patrocinantes_publicidades import (
    Patrocinante, 
    Publicidad, 
    ConsumidorObjetivo, 
    GrupoDeEdadObjetivo, 
    GradoDeInstruccionObjetivo, 
    TerritorioObjetivo, 
    SexoObjetivo
)
from orm.ventas import Cobrable, ServicioVendido, Factura
from orm.calificaciones_resenas import (
    Calificacion, 
    CalificacionResena, 
    CalificableSeguible
)
from orm.consumidores import (
    Consumidor, 
    Sexo, 
    GrupoDeEdad, 
    GradoDeInstruccion
)
from sqlalchemy import create_engine
import os, sys, transaction

def parsear_arbol_categorias(padre, arbol=arbol_categorias):
    padre_id = padre.categoria_id
    for nodo in arbol:
        hijo = Categoria(nombre=nodo['nombre'], hijo_de_categoria=padre_id)
        #padre.hijos.append(hijo)
        DBSession.add(hijo)
    
        if len(nodo['hijos']) > 0:
            parsear_arbol_categorias(hijo, nodo['hijos'])

def constantes():
    with transaction.manager:
        DBSession.add_all(
            [CodigoDeError(error) for error in codigos_de_error]
            + [Privilegios(pri) for pri in privilegios]
            + [Idioma(idioma) for idioma in idiomas]
            + [TipoDeCodigo(tdc) for tdc in tipos_de_codigo]
            + [Sexo(sexo) for sexo in sexos]
            + [GradoDeInstruccion(valor=gdi['instruccion'], orden=gdi['grado'])
                for gdi in grados_de_instruccion]
            + [Visibilidad(vis) for vis in visibilidades]
            + [Accion(acc) for acc in acciones]
            + [Calificacion(cal) for cal in calificaciones]
            + [GrupoDeEdad(gde) for gde in grupos_de_edades]
            + [Estatus(est) for est in estatus]
            + [Dia(valor=dia['nombre'], orden=dia['orden']) for dia in dias]
        )
            
        cat0 = Categoria(
            raiz=True, categoria_id='0.00.00.00.00.00', nombre='Inicio', 
            hijo_de_categoria='0.00.00.00.00.00', nivel=0
        )
        DBSession.add(cat0)
        parsear_arbol_categorias(cat0)
        
        adm = Administrador(
            creador=1, ubicacion_id=None, nombre='Nestor', apellido='Bohorquez',
            privilegios='Todos', correo_electronico='admin@netzuela.com',
            contrasena='$2a$12$MOM8uMGo9XmH1BDYPrTns.k/WLl6vt45qeKEXn5ZqoiBsQeBMfTQG'
        )
        DBSession.add(adm)

        mun = Territorio(raiz=True, creador=1, nombre='La Tierra', poblacion=0, 
            territorio_id='0.00.00.00.00.00', idioma='Mandarin', 
            territorio_padre_id='0.00.00.00.00.00', codigo_postal='', 
            pib=0, nivel=0
        )
        DBSession.add(mun)

        ven = Territorio(creador=1, nombre='Venezuela', poblacion=0, 
            idioma='Espanol', territorio_padre_id=mun.territorio_id, 
            codigo_postal='', pib=0
        )
        DBSession.add(ven)
 
        ven.dibujable.croquis.append(Croquis(creador=1))
        for punto in puntos_venezuela:
            ven.dibujable.croquis[0].puntos.append(
                Punto(latitud=punto[0], longitud=[1])
            )
def main():
    motor = create_engine('mysql://chivo:#HK_@20MamA!pAPa13?#3864@localhost:3306/spuria?charset=utf8&use_unicode=0', echo=True)
    DBSession.configure(bind=motor)
    Base.metadata.create_all(motor)
    constantes()

if __name__ == '__main__':
    main()
