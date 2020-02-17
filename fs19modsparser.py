# -*- coding: utf-8 -*-
#############################################################

import threading
import time
import requests
from bs4 import BeautifulSoup
from tabulate import tabulate


#############################################################


class Appdata:
    mods = []
    filter = 'map'
    maxpage = 1


class ParserPageCount:

    def __init__(self):
        url = f'https://www.farming-simulator.com/mods.php?lang=en&country=ru&title=fs2019&filter={Appdata.filter}&page=0'
        # print(url)
        r = requests.get(url)
        r.encoding = 'utf-8'
        html = BeautifulSoup(r.text, "html.parser")

        # ul = html.find('ul', class_='')
        ul = html.find('ul', {'class': 'pagination text-center clearfix'})

        # print(ul.contents[-2].text.strip())

        try:
            Appdata.maxpage = int(ul.contents[-2].text.strip())
        except:
            pass
        print(Appdata.maxpage)


class Parser(threading.Thread):

    def __init__(self, page):
        self.page = page
        threading.Thread.__init__(self)

    def run(self):
        url = f'https://www.farming-simulator.com/mods.php?lang=en&country=ru&title=fs2019&filter={Appdata.filter}&page={self.page}'
        print(url)
        r = requests.get(url)
        r.encoding = 'utf-8'
        # html = r.text
        # print(html)

        html = BeautifulSoup(r.text, "html.parser")

        # print(html.findAll('div', class_='mod-item__content'))

        for mod in html.findAll('div', {'class': 'mod-item__content'}):
            # print(mod)
            # print(mod.parent.contents[1].contents[3].attrs['href'])
            try:
                modurl = mod.parent.contents[1].contents[3].attrs['href']
            except:
                # modurl = ''
                modurl = mod.parent.contents[1].contents[1].attrs['href']

            # print(modurl)

            try:
                name = mod.contents[1].text
                tmp = mod.contents[7].text[:-1]

                tmp.find('(')
                tmp.find(')')

                rating = tmp[:tmp.find('(') - 1]
                votes = tmp[tmp.find('(') + 1:tmp.find(')')]

                # print(name, rating, votes, url)
                # print('-------------')

                modurlpref = 'https://www.farming-simulator.com/'
                Appdata.mods.append([name[:30], rating, int(votes), modurlpref + modurl])
            except:
                print(mod)
                print('-------------')

        # <div class="mod-item__content">
        # <h4>Seasons GEO: Georgia</h4>
        # <p><span>By: adub modding</span></p>
        # <div class="mods-rating clearfix">
        # <span class="icon-star"></span>
        # <span class="icon-star"></span>
        # <span class="icon-star"></span>
        # <span class="icon-star half"></span>
        # <span class="icon-star grey"></span>
        # </div>
        # <div class="mod-item__rating-num">3.7 (15)
        # </div>
        # </div>

        # print(html.findAll('div'))

        # html.findAll('div', class="mod-item__content")

        # div class="mod-item__content"

        # try:
        #     for i in range(1000):
        #         # print(proxy.tbody('td')[i * 8].text + ':' + proxy.tbody('td')[i * 8 + 1].text, end='')
        #
        #         if proxy.tbody('td')[i * 8 + 6].text == 'yes':
        #             ip = proxy.tbody('td')[i * 8].text + ':' + proxy.tbody('td')[i * 8 + 1].text
        #             # print(' add')
        #             proxy_arr.append(ip)
        #             https += 1
        #             if https == limit:
        #                 raise Exception
        #         else:
        #             pass
        #             # print()
        # except:
        #     pass


def main():
    ParserPageCount()

    threads = []

    for page in range(Appdata.maxpage):
        # for page in [4]:
        t = Parser(page)
        t.start()
        threads.append(t)

    for t in threads:
        t.join()

    # for mod in sorted(mods, key=lambda i: i[1], reverse=True):
    #     print([])

    print(tabulate(
        sorted(Appdata.mods, key=lambda i: i[2], reverse=True),
        # sorted(arr, key=lambda bids: bids[3], reverse=True)[:200],
        # arr,
        # header,
        # colalign=('left', 'left', 'center', 'right', 'right', 'right', 'right'),
        # tablefmt="html"
        tablefmt="simple"
    ))


#############################################################

if __name__ == "__main__":
    main()

#############################################################
