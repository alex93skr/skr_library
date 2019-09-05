# !/usr/bin/python3
# -*- coding: utf-8 -*-

###############################################################

import random
import time

import psycopg2
import requests
from fake_headers import Headers

###############################################################

# 3913-hodor
# 10664-boobs-master

go_rate = 'plus'
news_id = '10664'
skin = 'Default'
user_hash = None

# var dle_login_hash = '7369c4ed65c449db20c2b57ac5819fb108d9023d';


# url = 'http://telegram.org.ru/3913-hodor.html'
url = 'http://telegram.org.ru/10664-boobs-master.html'

conn = psycopg2.connect(
    dbname='de2hks5oomsqov',
    user='sgtggvoxppwgbx',
    password='43e54ae9cc631e3a64eb030dcedc821c594077c5276d187fe1f567fb4d15c7b3',
    host='ec2-46-137-91-216.eu-west-1.compute.amazonaws.com',
    sslmode='require'
)


def random_proxy():
    with conn.cursor() as cursor:
        cursor.execute("select ip from proxy limit 1 offset floor(random() * (select count(*) from proxy));")
        conn.commit()
        proxy = cursor.fetchone()
    # print('  random_proxy', proxy[0])
    return {'http': 'http://' + proxy[0]}


# print(random_proxy())

def fake_head():
    return Headers(headers=True).generate()


def name_gen():
    """генератор имени"""
    case = 'abcdefghijklmnopqrstuvwxyz0123456789'
    # n1 = random.choice(ascii_lowercase).upper()
    name = ''.join(random.choice(case) for i in range(40))
    print(name)
    return name


# name_gen()

def dorate():
    random_proxy1 = random_proxy()

    print('random_proxy1', random_proxy1)

    fake_head1 = fake_head()

    print('fake_head1', fake_head1)

    html = requests.get(url, proxies=random_proxy1, headers=fake_head1, timeout=5)
    if html.ok:
        print('OK', url)
        html.encoding = 'utf-8'

        # print(html.text)

        start = html.text.find('dle_login_hash')
        # print(start)
        # print(html.text[start + 18 :start + 58])

        dle_login_hash = html.text[start + 18:start + 58]
        print('dle_login_hash', dle_login_hash)

        do_url = f'http://telegram.org.ru/engine/ajax/rating.php?go_rate={go_rate}&news_id={news_id}&skin={skin}&user_hash={dle_login_hash}'
        # do_url = f'http://telegram.org.ru/engine/ajax/rating.php?go_rate={go_rate}&news_id={news_id}&skin={skin}&user_hash={name_gen()}'

        print('do_url', do_url)

        print('sleep ...')

        time.sleep(random.randint(5, 10))

        req = requests.get(do_url, proxies=random_proxy1, headers=fake_head1, timeout=8)
        if req.ok:
            print('OK do_url')
            req.encoding = 'utf-8'
            if '"success":true' in req.text:
                print(req.text)
                return True
            else:
                print('res fail', req.text[:50])


# http://telegram.org.ru/engine/ajax/rating.php?go_rate=plus&news_id=3913&skin=Default&user_hash=c060de1ecc51386d0963a895937f48cfb24db7c1


def main():
    print('\nGO RATE UP!\n')
    count = 0
    good = 0
    err = 0

    # while n != 11:
    while True:
        count += 1
        print('\nSTART count', count, ', ok', good, ', err', err)
        try:
            if dorate():
                good += 1
        except:
            err += 1
        time.sleep(random.randint(5, 10))


# 7369c4ed65c449db20c2b57ac5819fb108d9023d
# 7369c4ed65c449db20c2b57ac5819fb108d9023d
# w4c3ei8ab3b7mbvpzsapmmadw54dyza9vj0xnrzl

###############################################################

if __name__ == '__main__':
    main()

###############################################################
