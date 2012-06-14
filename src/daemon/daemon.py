from bs4 import BeautifulSoup, NavigableString
import urllib2, sys  

#http://yoopsie.com/query.php?query=0075678014345&locale=US&index=All

if len(sys.argv) != 2:
	print 'Error: Numero incorrecto de argumentos.'
	print 'Uso: python daemon.py upc'
	print '	upc		Codigo UPC del producto'
	sys.exit()

sitio = 'http://yoopsie.com/query.php'
query = sys.argv[1]
locale = 'US'
index = 'All'
address = "{0}?query={1}&locale={2}&index={3}".format(sitio, query, locale, index)

try:
	html = urllib2.urlopen(address).read()
except HTTPError, e:
	print "Error HTTP: %d" % e.code
except URLError, e:
	print "Error de red: %s" % e.reason.args[1]

soup = BeautifulSoup(html)
producto = {}
producto['img'] = soup.find('td', attrs={'class': "info_image"}).a.img['src']
td_info = soup.find('td', attrs={'class': "info"}).table
producto['info'] = td_info.tr.td.a.string
producto['upc']  = td_info.find('td', attrs={'class': "upc"}).string

print producto['upc']
print producto['info']
print producto['img'] 
