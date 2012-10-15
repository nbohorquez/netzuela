# -*- coding: utf-8 -*-

from comunes import Base, DBSession
from sqlalchemy import Column, Integer, Text, ForeignKey
from sqlalchemy.orm import relationship, backref

class Interlocutor(Base):
    __tablename__ = 'interlocutor'
    __mapper_args__ = {'polymorphic_on': tipo}
    
    # Columnas
    interlocutor_id = Column(Integer, primary_key=True, autoincrement=True)
    tipo = Column(String(45), nullable=False)

class Mensaje(Rastreable, Etiquetable):
    __tablename__ = 'mensaje'
    __mapper_args__ = {'polymorphic_identity': 'mensaje'}
    
    # Columnas
    rastreable_p = Column(
        Integer, nullable=False, unique=True, index=True
        ForeignKey('rastreable.rastreable_id')
    )
    etiquetable_p = Column(
        Integer, nullable=False, unique=True, index=True
        ForeignKey('etiquetable.etiquetable_id')
    )
    mensaje_id = Column(Integer, primary_key=True, autoincrement=True)
    remitente = Column(
        Integer, ForeignKey('interlocutor.interlocutor_id'), nullable=False
    )
    destinatario = Column(
        Integer, ForeignKey('interlocutor.interlocutor_id'), nullable=False
    )
    contenido = Column(Text, nullable=False)

    # Propiedades
    remitente_x = relationship(
        "Interlocutor", backref="mensajes_enviados",
        primaryjoin="Mensaje.remitente == Interlocutor.interlocutor_id"
    )
    destinatario_x = relationship(
        "Interlocutor", backref="mensajes_recibidos",
        primaryjoin="Mensaje.destinatario == Interlocutor.interlocutor_id"
        
    )

    def __init__(self, remitente=None, destinatario=None, contenido='', 
                 *args, **kwargs):
        # Yo creia que debia hacer algo como esto para poder acceder a 
        # 'remitente_x':
        # http://techspot.zzzeek.org/2007/05/29/polymorphic-associations-with-sqlalchemy/
        # Sin embargo, me di cuenta que con relaciones simples bastaba y sobraba
        super(Mensaje, self).__init__(
            creador=remitente_x.rastreable_p, *args, **kwargs
        )
        self.remitente = remitente
        self.destinatario = destinatario
        self.contenido = contenido
