import json, os
import numpy as np
import requests as r
from glob import glob
from urllib.request import urlopen
from bs4 import BeautifulSoup
from datetime import datetime

fids = glob('*.dat')
latest_file = max(fids, key=os.path.getctime)

def download(LastUpdate):
    url = 'https://services7.arcgis.com/LXCny1HyhQCUSueu/ArcGIS/rest/services/' + \
          'Definitive_Healthcare_USA_Hospital_Beds/FeatureServer/0/query?where=0=0&outFields=*&f=pgeojson'
    html= r.get(url)
    html.encoding='utf-8'
    outfile = datetime.strftime(LastUpdate, '%Y-%m-%d_%H:%M:%S')
    with open(outfile+'.dat','w') as f:
        json.dump(html.json(),f)
    print(json.dumps(html.json(),indent=3))
        
def check_update(latest_file):
    url = 'https://services7.arcgis.com/LXCny1HyhQCUSueu/ArcGIS/rest/services/Definitive_Healthcare_USA_Hospital_Beds/FeatureServer/0'
    info = BeautifulSoup(urlopen(url),'html.parser')
    LastUpdate = [l for l in [l for l in info.get_text().split('\n') if l] if 'Last' in l][0].split(': ')[1]
    LastUpdate = datetime.strptime(LastUpdate,'%m/%d/%Y %I:%M:%S %p')
    PrevUpdate = datetime.strptime(latest_file[:-4],'%Y-%m-%d_%H:%M:%S')

    status = False if PrevUpdate == LastUpdate else LastUpdate.strftime('%Y-%m-%d_%H:%M:%S')
    if status:
        print('\n\n...New Update is processing...')
        print('...Date:{}...\n'.format(datetime.strftime(LastUpdate, '%Y-%m-%d_%H:%M:%S')))
        download(LastUpdate)


check_update(latest_file)


