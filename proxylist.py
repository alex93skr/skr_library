#!/usr/bin/python3
# -*- coding: utf-8 -*-

import json
import random
import time
import bs4
import requests
from fake_headers import Headers
from bs4 import BeautifulSoup

def fake_headers1():
    return Headers(headers=True).generate()

###############################################################


def proxy_https_makearr(url, total=1000):
    print('PARSING proxy_https_makearr for:', url)
    proxy_arr = []
    proxy = requests.get(url)
    # print(proxy.text)
    count = 0
    https = 0
    if proxy.ok == True:
        proxy = BeautifulSoup(proxy.text, "html.parser")
        try:
            for i in range(1000):
                count += 1
                print(proxy.tbody('td')[i * 8].text + ':' + proxy.tbody('td')[i * 8 + 1].text, end='')

                if proxy.tbody('td')[i * 8 + 6].text == 'yes':
                    url = proxy.tbody('td')[i * 8].text + ':' + proxy.tbody('td')[i * 8 + 1].text
                    print(' add')
                    proxy_arr.append(url)
                    https += 1
                    if https == total:
                        raise Exception
                else:
                    print()
        except:
            pass
    print('proxy checked:', count)
    print('added to the list:', len(proxy_arr))
    return proxy_arr

# proxy_https_makearr('https://free-proxy-list.net', 50)


def proxy_check_bot_arr(arr):
    boturl = 'https://api.telegram.org/bot865331134:AAGCsknZ2dZ-lP3JdqHBdISUD4pHJHvej7c/getMe'

    print('proxy_check_bot_arr START')
    print('len(arr):', len(arr))
    proxy_check = []
    count = 0
    for i in arr:
        count += 1
        proxy1 = {'https': 'https://' + i}
        # print(proxy1)
        try:
            test = requests.get(boturl, proxies=proxy1, timeout=3)
            # print(test.text)
            if test.json()['ok']:
                print(f' {count:<3} {i:22} ok')
                proxy_check.append(i)
        except Exception as err:
            print(f' {count:<3} {i:22} err: {err}')
    print('good proxy:', len(proxy_check))
    print('proxy =', proxy_check)
    return proxy_check


# arr = proxy_https_makearr('https://free-proxy-list.net', 50)
# print()
# proxy_check_bot_arr(arr)

# good_proxy_to_tlg_api = ['103.221.254.2:59905', '202.57.47.202:56840', '193.242.177.105:53281']


# boturl = 'https://api.telegram.org/bot865331134:AAGCsknZ2dZ-lP3JdqHBdISUD4pHJHvej7c/getMe'
# test = requests.get(boturl, proxies={'https': 'https://66.7.113.39:3128'}, timeout=5)
# print(test.text)
# print(test.json()['ok'])

###############################################################


def proxy_make_arr():
    proxy_fin = []
    while True:
        try:
            proxy = requests.get('https://www.us-proxy.org/')
            if proxy.ok == True:
                proxy_html = bs4.BeautifulSoup(proxy.text, "html.parser")
                for f in range(100):
                    url = proxy_html.tbody('td')[f * 8].text + ':' + proxy_html.tbody('td')[f * 8 + 1].text
                    print(url)
                    proxy_fin.append(url)
                break
        except Exception:
            time.sleep(10)
    print('proxy_make_arr:', len(proxy_fin))
    # return random.choice(proxy_fin)
    return proxy_fin


def proxy_check_arr(arr, time=3):
    url = 'https://yandex.ru/images/'
    print('proxy_check_arr START', url)
    print('len(arr):', len(arr))
    proxy_check = []
    count = 0
    for i in arr:
        count += 1
        proxy1 = {'https': 'https://' + i}
        # print(proxy1)
        try:
            test = requests.get(url, proxies=proxy1, headers=fake_headers1(), timeout=time)
            if test.ok:
                print(f' {count:<3} {i:22} ok')
                proxy_check.append(i)
        except Exception as err:
            print(f' {count:<3} {i:22} err: {err}')
    print('good proxy:', len(proxy_check))
    print('proxy =', proxy_check)
    return proxy_check


# arr = proxy_https_makearr('https://free-proxy-list.net', 50)
# arr = proxy_https_makearr('https://www.us-proxy.org', 50)
# arr = proxy_https_makearr('https://free-proxy-list.net/uk-proxy.html', 50)

print()

proxy = ['167.86.89.108:3128', '116.71.132.53:8080', '163.172.171.125:80', '45.79.161.206:3128', '186.103.175.158:3128', '92.46.112.10:8080', '31.220.51.173:8080', '202.166.207.58:60050', '67.75.2.39:3128', '37.187.127.216:8080', '212.237.124.15:61599', '51.158.113.142:8811', '186.103.148.204:3128', '170.210.236.1:43943', '185.144.159.148:8080', '165.22.134.199:3128', '118.140.150.74:3128', '165.22.236.64:8080', '5.23.102.194:52803', '51.15.193.253:3128', '51.15.229.180:80', '96.118.254.95:8080', '103.76.253.155:3128', '47.254.197.25:3128', '67.205.172.239:3128', '163.172.16.202:3128', '35.235.75.244:3128', '165.22.164.22:8080', '198.50.147.158:3128', '208.72.119.2:60099', '1.228.244.47:443']


proxy_check_arr(proxy, time=3)

# free-proxy-list proxy = ['118.140.150.74:3128', '5.23.102.194:52803', '165.22.164.22:8080', '45.79.161.206:3128', '54.183.3.44:3128', '35.235.75.244:3128', '96.118.254.95:8080', '67.205.172.239:3128', '104.248.117.3:8080']
# us-proxy proxy = ['165.22.164.22:8080', '45.79.161.206:3128', '54.183.3.44:3128', '35.235.75.244:3128', '96.118.254.95:8080', '67.205.172.239:3128', '104.248.117.3:8080']
# http://spys.me/proxy.txt    ([0-9]{1,3}[\.]){3}[0-9]{1,3}:\d{1,}
# spys.me proxy = ['51.15.229.180:80', '130.61.35.199:3128', '134.236.255.6:52208', '202.65.171.67:8080', '41.204.87.90:8080', '200.111.182.6:443', '163.172.16.202:3128', '197.232.69.137:42603', '81.190.208.52:38348', '186.103.175.158:3128', '109.75.47.248:55274', '185.103.88.103:61259', '51.15.193.253:3128', '165.22.164.22:8080', '193.86.25.225:43533', '104.222.110.66:23500', '208.72.119.2:60099', '92.46.112.10:8080', '188.165.199.101:3128', '109.175.11.24:8080', '1.228.244.47:443', '31.220.51.173:8080', '36.67.212.187:3128', '103.76.253.155:3128', '198.50.147.158:3128', '20.41.41.145:3128', '47.254.197.25:3128', '180.94.64.114:8080', '142.93.130.169:8118', '67.75.2.39:3128', '165.22.134.199:3128', '212.237.124.15:61599', '37.187.127.216:8080', '116.71.132.53:8080', '186.103.148.204:3128', '190.104.179.210:8080', '198.229.231.13:8080', '45.231.30.151:8080', '125.26.165.17:44185', '95.65.27.171:47377', '202.166.207.58:60050', '42.115.221.58:3128', '106.104.151.142:58198', '91.187.112.173:37750', '165.22.236.64:8080', '51.158.113.142:8811', '167.86.89.108:3128', '185.144.159.148:8080', '105.28.121.209:40638', '118.174.219.34:8080', '163.172.171.125:80', '197.148.64.194:8080', '170.210.236.1:43943', '183.89.116.47:8080']




###############################################################


# headers1 = {
#     'User-Agent': 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.11 (KHTML, like Gecko) Chrome/23.0.1271.64 Safari/537.11',
#     'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8',
#     'Accept-Charset': 'ISO-8859-1,utf-8;q=0.7,*;q=0.3',
#     'Accept-Encoding': 'none',
#     'Accept-Language': 'en-US,en;q=0.8',
#     'Connection': 'keep-alive'
# }


