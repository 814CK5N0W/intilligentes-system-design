from tqdm import tqdm
from PIL import Image
import traceback
import logging

# im1 = Image.open(r'path where the PNG is stored\file name.png')

data_path = 'data'


import os

def convert_and_save(im: Image,name: str, loc="data_jpg/"):
    im.save(f'{loc}{name}')

def listdir_nohidden(path):
    for f in os.listdir(path):
        if not f.startswith('.'):
            yield f

for folder in tqdm(listdir_nohidden(f'{data_path}')):
    name_prefix = folder
    for subfolder in tqdm(listdir_nohidden(f'{data_path}/{folder}')):
        second_name_prefix = subfolder
        counter = 0
        for image in tqdm(listdir_nohidden(f'{data_path}/{folder}/{subfolder}')):
            print(f'{name_prefix}_{second_name_prefix}_{counter}.jpg')
            name = f'{name_prefix}_{second_name_prefix}_{counter}.jpg'
            counter+=1
            im = Image.open(f'{data_path}/{folder}/{subfolder}/{image}')
            try:
                convert_and_save(im,name)
            except Exception as e:
                logging.error(traceback.format_exc())
