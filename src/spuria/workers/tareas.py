from __future__ import absolute_import
from bs4 import BeautifulSoup, NavigableString
from spuria.workers import celery
import urllib2, sys  

@celery.celery.task
def crear_objeto(*args, **kwargs):

@celery.celery.task
def registrar_producto(upc):
    #http://yoopsie.com/query.php?query=0075678014345&locale=US&index=All

    sitio = 'http://yoopsie.com/query.php'
    query = upc
    locale = 'US'
    index = 'All'
    address = "{0}?query={1}&locale={2}&index={3}".format(
        sitio, query, locale, index
    )

    try:
        html = urllib2.urlopen(address).read()
    except HTTPError, e:
        return None
        #print "Error HTTP: %d" % e.code
    except URLError, e:
        return None
        #print "Error de red: %s" % e.reason.args[1]

    soup = BeautifulSoup(html)
    producto = {}
    producto['img'] = soup.find('td', attrs={'class': "info_image"}).\
    a.img['src']
    td_info = soup.find('td', attrs={'class': "info"}).table
    producto['info'] = td_info.tr.td.a.string
    producto['upc']  = td_info.find('td', attrs={'class': "upc"}).string
    return producto
