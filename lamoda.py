import json
import threading
import time

import requests
from bs4 import BeautifulSoup
from fake_headers import Headers


def fake_head():
    return Headers(headers=True).generate()


def save_html_file(html):
    name = f'{round(time.time())}.html'
    print('DEBUG_SAVE_HTML', name)
    with open(name, "w", encoding='utf-8') as file:
        file.write(html)


class Parser:
    def __init__(self):
        self.data = {}
        self.page_parser()

    def page_parser(self):
        pref_url = 'https://www.lamoda.ru/c/593/bags-muzhskie-sumki/'
        # pref_url = 'https://www.lamoda.ru/p/rtlacc201201/bags-tommyjeans-sumka/'

        for page in range(1, 11):
            # print(page)
            if page == 1:
                url = pref_url
            else:
                url = pref_url + '?page=' + str(page)
            print(url)

            r = requests.get(url, headers=fake_head())
            r.encoding = 'utf-8'

            soup = BeautifulSoup(r.text, 'html.parser')
            bags = soup.findAll('a', {'class': 'x-product-card__link x-product-card__hit-area'})
            # print(bags)

            threads = []

            for bag in bags:
                # print(bag)
                # _url = 'https://www.lamoda.ru' + self.bag_url
                bag_url = 'https://www.lamoda.ru' + bag.attrs['href']
                t = Parser_thread(self, bag_url)
                t.start()
                threads.append(t)

            for t in threads:
                t.join()

            print('PAGE DONE', page)

        with open("lamoda.json", "w") as write_file:
            # json.dump(self.data, write_file, ensure_ascii=True, sort_keys=True, indent=1)
            json.dump(self.data, write_file, ensure_ascii=True, indent=1)


class Parser_thread(threading.Thread):
    def __init__(self, parser, bag_url):
        self.parser = parser
        self.bag_url = bag_url
        threading.Thread.__init__(self)

    def run(self):
        # bag_url="/p/rtlacc201201/bags-tommyjeans-sumka/"
        # https://www.lamoda.ru/p/rtlaby557701/bags-boss-sumka/

        # _url = 'https://www.lamoda.ru' + self.bag_url
        r = requests.get(self.bag_url, headers=fake_head())
        r.encoding = 'utf-8'

        soup = BeautifulSoup(r.text, 'html.parser')
        # values = soup.findAll('span', {'class': 'x-premium-product-description-attribute__value'})

        values = soup.findAll('p', {'class': 'x-premium-product-description-attribute'})

        width, height, depth = None, None, None

        for value in values:
            if value.contents[0].contents[0].text == 'Ширина':
                width = value.contents[1].text

            if value.contents[0].contents[0].text == 'Высота':
                height = value.contents[1].text

            if value.contents[0].contents[0].text == 'Ширина дна':
                depth = value.contents[1].text

        # print(width, height, depth)

        # print(value.contents[0].contents[0].text, value.contents[1].text)

        # width = values[1].text
        # height = values[2].text
        # depth = values[3].text

        # print(self.bag_url, values[1].text, values[2].text, values[3].text)
        # print(self.bag_url, values[1].text, values[2].text, values[3].text)

        self.parser.data.update({
            self.bag_url: {
                'width': width,
                'height': height,
                'depth': depth
            }
        })


def data_science():
    with open("lamoda.json", "r") as read_file:
        data = json.load(read_file)

    print(len(data))

    count = 0

    for bag in data:
        # print(bag)
        # print(bag, data[bag])

        if data[bag].get('width'):
            if float(data[bag]['width']) < 21:
                continue

        if data[bag].get('height'):
            if float(data[bag]['height']) < 30:
                continue

        # print(bag, data[bag])
        print(count, bag)
        count += 1
        # width = values[1].text
        # height = values[2].text
        # depth = values[3].text

    print(f'{count=}')


if __name__ == "__main__":
    # Parser()
    data_science()
