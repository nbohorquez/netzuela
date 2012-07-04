"""
from pykml.factory import KML_ElementMaker as KML
from lxml import etree

pm1 = KML.Placemark(
	KML.name("Hello World"),
	KML.Point(KML.coordinates("-64.5253,18.4607"))
)
pm2 = KML.Placemark(
	KML.name("A second placemark"),
	KML.Point(KML.coordinates("-64.5358,18.4486"))
)

fld = KML.Folder(pm1, pm2)
print etree.tostring(fld, pretty_print=True)
"""
from pykml import parser
from os import path

def analizar_poligono(poligono):
	for coordenadas in poligono.outerBoundaryIs.LinearRing.coordinates.text.split(' '):
		coo = coordenadas.split(',')
		print "latitud = {0} longitud = {1}".format(coo[1], coo[0])

archivo = path.abspath('../../../map/kronick/simplificado/kml/venezuela_estados.kml')
with open(archivo) as a:
	doc = parser.parse(a).getroot()
	for pm in doc.Document.Folder.Placemark:
		if hasattr(pm, 'MultiGeometry'):
			pm = pm.MultiGeometry
		for poligono in pm.Polygon:
			analizar_poligono(pm.Polygon)
