import os
import sys
import wikipediaapi
import logging
import pandas as pd
from tqdm import tqdm
import wikipedia
import requests
import json
import sys


WIKI_REQUEST = 'http://ru.wikipedia.org/w/api.php?action=query&prop=pageimages&format=json&piprop=original&titles='

def get_wiki_image(search_term):
    try:
        result = wikipedia.search(search_term, results = 1)
        wikipedia.set_lang('ru')
        wkpage = wikipedia.WikipediaPage(title = result[0])
        title = wkpage.title
        response  = requests.get(WIKI_REQUEST+title)
        json_data = json.loads(response.text)
        img_link = list(json_data['query']['pages'].values())[0]['original']['source']
        return img_link        
    except:
        return 0

if __name__ == '__main__':
    img_query = ""
    try:
        img_query= os.sys.argv[1]
    except IndexError:
        print('Specify query')
        sys.exit()

    print(f'searching for {img_query}')

    img_url = get_wiki_image(img_query)


    if img_url == '':
        print('Not found!')
    else:
        print(img_url)
        os.system(f'curl {img_url} --output ../data/images/{img_query}.png')