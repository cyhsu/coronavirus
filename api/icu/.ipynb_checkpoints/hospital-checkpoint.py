import os
import numpy as np
import requests as r
from glob import glob
from bs4 import BeautifulSoup
from datetime import datetime

fids = glob('*.geojson')
latest_file = max(fids, key=os.path.getctime)

def check_update(latest_file):
	url = 'https://services7.arcgis.com/LXCny1HyhQCUSueu/ArcGIS/rest/services/Definitive_Healthcare_USA_Hospital_Beds/FeatureServer/0'
	info = BeautifulSoup(urlopen(url))
	LastUpdate = [l for l in [l for l in info.get_text().split('\n') if l] if 'Last' in l][0].split(': ')[1]
	LastUpdate = datetime.strptime(LastUpdate,'%m/%d/%Y %I:%M:%S %p')
	PrevUpdate = datetime.strptime(latest_file[:-4],'%Y-%m-%d_%H:%M:%S')
	return False if PrevUpdate <= LastUpdate else LastUpdate.strftime('%Y-%m-%d_%H:%M:%S')

LastUpdate = check_update(latest_file)
if LastUpdate:
	url = 'https://services7.arcgis.com/LXCny1HyhQCUSueu/ArcGIS/rest/' + \
			'services/Definitive_Healthcare_USA_Hospital_Beds/FeatureServer/0/query?where=0=0&outFields=*&f=pgeojson'
	html= r.get(fid)
	html.encoding='utf-8'
	outfid = '{}.geojson'.format(LastUpdate)
	with open(outfid,'w') as f:
		json.dump(html.json(), incident=3, f)

	print('Record Updates: {}'.format(datetime.today().strftime('%Y-%m-%d %H:%M:%S')))
