# -*- coding: utf-8 -*-

from comunes import Base, DBSession
from palabras import EsEtiquetable
from rastreable import EsRastreable, RastreableAsociacion, Rastreable
from sqlalchemy import *
from sqlalchemy.ext.associationproxy import association_proxy
from sqlalchemy.ext.declarative import declared_attr
from sqlalchemy.orm import relationship, backref

class InterlocutorAsociacion(Base):
    __tablename__ = 'interlocutor_asociacion'

    # Columnas
    interlocutor_asociacion_id = Column(
        Integer, primary_key=True, autoincrement=True
    )
    discriminante = Column(String(45))

    # Propiedades
    @property
    def padre(self):
        return getattr(self, "{}_padre".format(self.discriminante))

    # Funciones
    @classmethod
    def creador(cls, discriminante):
        return lambda interlocutor:InterlocutorAsociacion(
            interlocutor=interlocutor, discriminante=discriminante
        )

class Interlocutor(Base):
    __tablename__ = 'interlocutor'
    
    # Columnas
    interlocutor_id = Column(Integer, primary_key=True, autoincrement=True)
    asociacion_id = Column(
        Integer, 
        ForeignKey('interlocutor_asociacion.interlocutor_asociacion_id')
    )

    # Propiedades
    asociacion = relationship(
        'InterlocutorAsociacion', backref=backref('interlocutor', uselist=False)
    )
    padre = association_proxy('asociacion', 'padre')

class EsInterlocutor(object):
    @declared_attr
    def interlocutor_asociacion_id(cls):
        return Column(
            Integer, 
            ForeignKey("interlocutor_asociacion.interlocutor_asociacion_id")
        )

    @declared_attr
    def interlocutor_asociacion(cls):
        discriminante = cls.__tablename__
        cls.interlocutor = association_proxy(
            'interlocutor_asociacion', 'interlocutor', 
            creator=InterlocutorAsociacion.creador(discriminante)
        )
        return relationship(
            'InterlocutorAsociacion', backref=backref(
                "{}_padre".format(discriminante), uselist=False
            )
        )

    def __init__(self, *args, **kwargs):
        # Aqui la explicacion de por que tengo que llamar a super desde este
        # constructor para que esta clase sea inicializada en la cadena de
        # inicializacion:
        # http://stackoverflow.com/questions/9575409/python-calling-parent-class-init-with-multiple-inheritance-whats-the-righ
        # http://rhettinger.wordpress.com/2011/05/26/super-considered-super/
        super(EsInterlocutor, self).__init__(*args, **kwargs)
        self.interlocutor = Interlocutor()

class Mensaje(EsRastreable, EsEtiquetable, Base):
    __tablename__ = 'mensaje'
    
    # Columnas
    mensaje_id = Column(Integer, primary_key=True, autoincrement=True)
    remitente_id = Column(
        Integer, ForeignKey('interlocutor.interlocutor_id'), nullable=False
    )
    destinatario_id = Column(
        Integer, ForeignKey('interlocutor.interlocutor_id'), nullable=False
    )
    contenido = Column(Text, nullable=False)

    # Propiedades
    remitente = relationship(
        "Interlocutor", backref="mensajes_enviados",
        primaryjoin="Mensaje.remitente_id == Interlocutor.interlocutor_id"
    )
    destinatario = relationship(
        "Interlocutor", backref="mensajes_recibidos",
        primaryjoin="Mensaje.destinatario_id == Interlocutor.interlocutor_id"
    )

    def __init__(self, remitente=None, destinatario=None, contenido='',
                 *args, **kwargs):
        # Yo creia que debia hacer algo como esto para poder acceder a 
        # 'remitente_x':
        # http://techspot.zzzeek.org/2007/05/29/polymorphic-associations-with-sqlalchemy/
        # Sin embargo, me di cuenta que con relaciones simples bastaba y sobraba
        super(Mensaje, self).__init__(
            creador=remitente.padre.rastreable.rastreable_id, *args, **kwargs
        )
        self.remitente = remitente
        self.destinatario = destinatario
        self.contenido = contenido
