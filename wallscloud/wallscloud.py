import requests, argparse, time
import ctypes, os, random


def download_wallpaper():
    random_url = 'https://wallscloud.net/ru/api_app/wallpapers?&offset=0&limit=10&sort=random'
    random_request = requests.get(random_url)

    for i in random_request.json():
        if int(i['width']) >= 1920 and int(i['height']) >= 1080:
            print(i['id'], i['width'], i['height'])
            id_for_download = i['id']

    wallpaper_url = f'https://wallscloud.net/ru/api_app/wallpaper/{id_for_download}'
    wallpaper_request = requests.get(wallpaper_url)

    print(wallpaper_request.json()['page_Url'])

    download_url = f"{wallpaper_request.json()['page_Url']}/1920x1080/download"

    wallpaper_request = requests.get(download_url)
    with open('wallpaper.jpg', 'wb') as f:
        f.write(wallpaper_request.content)


def set_wallpaper():
    path = f'{os.getcwd()}\wallpaper.jpg'
    ctypes.windll.user32.SystemParametersInfoW(20, 0, path, 0)


# time.sleep(3)
download_wallpaper()
set_wallpaper()

# cd D:\Code\wallscloud
# pyinstaller --onefile --noconsole --icon=wall.ico wallscloud.py
