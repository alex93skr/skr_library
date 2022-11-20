# -*- coding: utf-8 -*-
# QE-DungeonTips auto translator by skr
#############################################################
import json
import re
import requests
from googletrans import Translator

translator = Translator()


#############################################################

def do_translate_yandex(line):
    # https://translate.yandex.ru/developers/stat
    url = 'https://translate.yandex.net/api/v1.5/tr.json/translate'
    data = {
        'key': 'trnsl.1.1.20200404T083355Z.362330ca84186d73.de2e887f8a21ce7ff546af4a44ac421c678842ff',
        'text': line,
        'lang': 'en-ru'
    }
    r = requests.get(url, params=data)
    if r.ok:
        return r.json()['text'][0].replace('"', '')
    else:
        return line


def do_translate_goo(line):
    # Appdata.count += 1
    # if Appdata.count > 50:
    #     raise Appdata.count

    if line in Appdata.already_translated_update:
        print('from json')
        return Appdata.already_translated_update[line]
    else:
        rus = translator.translate(line, dest='ru', src='en').text.replace('"', '')
        Appdata.already_translated_update.update({line: rus})
        return rus

    # try:
    #     return translator.translate(line, dest='ru', src='en').text.replace('"', '')
    # except:
    #     return line


def do_upper(line):
    return line.upper()


def line_worker(line):
    # print(line)
    find_result = re.findall(r'\s".+?}', line)
    # print(find_result)
    if find_result == [' ""}'] or find_result == []:
        return line
    else:
        # print(result)
        for sub_str in find_result:
            sub_str = sub_str[2:-2]
            # print(sub_str)
            start = line.find(sub_str)
            end = start + len(sub_str)
            line = line[:start] + do_translate_goo(sub_str) + line[end:]
            # line = line[:start] + do_translate(sub_str) + line[end:]
            # line = line[:start] + do_upper(sub_str) + line[end:]
    return line


# def main():


class Appdata:
    count = 0
    already_translated = {}
    already_translated_update = {}


if __name__ == '__main__':

    # with open("data_file.json", 'r') as read_file:
    # already_translated = json.load(read_file)
    #
    # json.dump(q1, read_file)
    # already_translated = json.load(read_file)
    # print(already_translated)

    with open("QE-DungeonTips.json", "r") as read_file:
        Appdata.already_translated = json.load(read_file)
        Appdata.already_translated_update.update(Appdata.already_translated)

    with open('QE-DungeonTips BFA.lua', encoding='utf-8') as f:
        read_data = [line for line in f]

    write_data = []

    try:
        for read_line in read_data:
            write_line = line_worker(read_line)
            print(read_line[:-1])
            print(write_line[:-1])
            write_data.append(write_line)

        with open('RU-QE-DungeonTips BFA.lua', 'w', encoding='utf-8') as f:
            for line in write_data:
                f.write(line)
    except Exception as err:
        print('ERROR DETECTED in', err)

    if Appdata.already_translated != Appdata.already_translated_update:
        with open("QE-DungeonTips.json", 'w+', encoding='utf-8') as read_file:
            json.dump(Appdata.already_translated_update, read_file, indent=1, ensure_ascii=False)

    # main()

    # line = '	[137119] = {{"Important", "Drop the Plasma Discharge debuff out of the raid."}, {"Important", "Dodge: Boss charge (immediately follows Cudgel of Gore). Big hitbox."},'
    # line_worker(line)

#############################################################
