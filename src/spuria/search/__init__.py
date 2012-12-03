# -*- coding: utf-8 -*-

from comunes import SEConn
from pyelasticsearch.downtime import DowntimePronePool
import ConfigParser

def inicializar(archivo, **kwargs):
    if archivo is not None:
        config = ConfigParser.ConfigParser()
        with open(archivo) as fp:
    	    config.readfp(fp)
        urls = config.get('buscador', 'elasticsearch.url')
    elif kwargs is not None and 'elasticsearch.url' in kwargs:
        urls = kwargs['elasticsearch.url']
    else:
        raise Exception('No hay ninguna URL especificada para el buscador')

    if isinstance(urls, basestring):
        urls = [urls]
    urls = [u.rstrip('/') for u in urls]
    SEConn.servers = DowntimePronePool(urls, 300)
