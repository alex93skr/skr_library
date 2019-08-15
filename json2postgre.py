#!/usr/bin/python3
# -*- coding: utf-8 -*-

#############################################################
#            __
#    ______ |  | __ _______
#   /  ___/ |  |/ / \_  __ \
#   \___ \  |    <   |  | \/
#  /____  > |__|_ \  |__|
#       \/       \/
#
#
# - анализ и работа с многоуровневым джейсоном
# - загрузка одноуровневого джейсона в простгрес
#
#############################################################


import json
import pprint
import psycopg2


#############################################################


def open_json(file):
    with open(file, "r") as read_file:
        datajson = json.load(read_file)
    return datajson


# print(datajson[0])
# pprint.pprint(i)


#############################################################
# структура джейсона по глубине с отступами depth

def json_structure(data, pref='', depth=0):
    for i in data:
        # print(i, data[i])

        if type(data[i]) == dict:
            # print(''.rjust(space), i)
            json_structure(data[i], pref=pref + '_' + i, depth=depth + 4)
        else:
            if pref == '':
                print(''.rjust(depth), pref + i)
            else:
                print(''.rjust(depth), pref + '_' + i)


# print(type(datajson), len(datajson))
# print(datajson)
# json_structure(datajson[0])

#############################################################
# список ключей в джейсоне на всю глубину +"_" к родителю

def make_key_list(data, pref='', depth=0):
    print_value = False
    keys_arr = []
    for i in data:
        # print(i, data[i])
        if type(data[i]) == dict:
            # print(''.rjust(space), i)
            make_key_list(data[i], pref=pref + '_' + i, depth=depth + 4)
        else:
            if pref == '':
                tmp = pref + str(i)
                if print_value:
                    print(''.rjust(depth), tmp)
                if tmp not in keys_arr:
                    keys_arr.append(tmp)
            else:
                tmp = pref + '_' + str(i)
                if print_value:
                    print(''.rjust(depth), tmp)
                if tmp not in keys_arr:
                    keys_arr.append(tmp)
    pprint.pprint(keys_arr)

#
# for i in datajson:
#     make_key_list(i)
#     print()
#

# ['id', 'group_id', 'class', 'rating', 'price', 'weapon_mode', 'missile_type', 'name', 'belongs_to', 'ed_id', 'ed_symbol', 'game_context_id', 'ship', '_group_id', '_group_category_id', '_group_name', '_group_category', 'mass', 'dps', 'power', 'damage', 'ammo', 'range_km', 'efficiency', 'power_produced', 'duration', 'cells', 'recharge_rating', 'capacity', 'count', 'range_ls', 'rate', 'bins', 'additional_armour', 'vehicle_count']


#############################################################
# типы значений для всех ключей на всю глубину

def make_type_key_list(data, pref='', depth=0):
    keys_arr = {}
    for i in data:
        # print(i, data[i], type(data[i]))
        if type(data[i]) == dict:
            # print(''.rjust(space), i)
            make_type_key_list(data[i], pref=pref + '_' + i, depth=depth + 4)
        else:
            if pref == '':
                tmp = str(i)
                print(''.rjust(depth), tmp)
                if tmp not in keys_arr:
                    keys_arr.update({tmp: []})

                tmptype = type(data[i])
                if tmptype not in keys_arr[tmp]:
                    keys_arr[tmp].append(tmptype)
            else:
                tmp = pref + '_' + str(i)
                print(''.rjust(depth), tmp)
                if tmp not in keys_arr:
                    keys_arr.update({tmp: []})
                    # print(keys_arr)

                tmptype = type(data[i])
                if tmptype not in keys_arr[tmp]:
                    keys_arr[tmp].append(tmptype)
    print()
    pprint.pprint(keys_arr)

# keys_arr = {}
# #
# for i in datajson:
#     make_type_key_list(i)
#     print()


# make_type_key_list(datajson[0])


# print(keys_arr)
#
# print()

# for i in keys_arr:
#     print(i, keys_arr[i])

# pprint.pprint(datajson)

# {'id': [<class 'int'>], 'group_id': [<class 'int'>], 'class': [<class 'int'>], 'rating': [<class 'str'>], 'price': [<class 'NoneType'>, <class 'int'>], 'weapon_mode': [<class 'NoneType'>, <class 'str'>], 'missile_type': [<class 'NoneType'>, <class 'int'>], 'name': [<class 'NoneType'>, <class 'str'>], 'belongs_to': [<class 'NoneType'>, <class 'int'>], 'ed_id': [<class 'int'>, <class 'NoneType'>], 'ed_symbol': [<class 'str'>, <class 'NoneType'>], 'game_context_id': [<class 'NoneType'>, <class 'int'>], 'ship': [<class 'str'>, <class 'NoneType'>], '_group_id': [<class 'int'>], '_group_category_id': [<class 'int'>], '_group_name': [<class 'str'>], '_group_category': [<class 'str'>], 'mass': [<class 'int'>, <class 'float'>], 'dps': [<class 'int'>], 'power': [<class 'float'>, <class 'int'>], 'damage': [<class 'int'>], 'ammo': [<class 'int'>], 'range_km': [<class 'int'>, <class 'float'>], 'efficiency': [<class 'str'>], 'power_produced': [<class 'float'>, <class 'int'>], 'duration': [<class 'int'>], 'cells': [<class 'int'>], 'recharge_rating': [<class 'str'>], 'capacity': [<class 'int'>], 'count': [<class 'int'>], 'range_ls': [<class 'int'>], 'rate': [<class 'int'>], 'bins': [<class 'int'>], 'additional_armour': [<class 'int'>], 'vehicle_count': [<class 'int'>]}

#############################################################
# создание одноуровневого джейсона +'_' к родителю

def depth_level_json(key, val, pref=''):
    # print(key, val)
    global tempdict

    if type(val) == dict:
        for i in val:
            depth_level_json(i, val[i], pref='_' + str(key) + '_' + pref)
    else:
        tempdict.update({pref + str(key): val})

    # print(tempdict)
    # return tempdict


def zero_lvl_json(data):
    for i in data:
        # print(i, data[i])
        depth_level_json(i, data[i])


# print(datajson[0])
# print()
#
# tempdict = {}
#
# zero_lvl_json(datajson[0])
#
# print()
#
# for i in tempdict:
#     print(i, tempdict[i])


#############################################################
# загрузка одноуровневого джейсона в простгресс

def load_data_to_bd(data):
    conn = psycopg2.connect(
        dbname='elite',
        user='postgres',
        password='123',
        host='localhost')

    datajson = open_json('modules.json')

    for i in datajson:
        tempdict = {}
        zero_lvl_json(i)
        # for i in tempdict:
        #     print(i, tempdict[i])
        print(tempdict)

        # print('INSERT INTO modules (', ', '.join(list(tempdict.keys())) , ') VALUES (',', '.join(['%s' for i in range(len(list(tempdict.values())))]),')')

        modules = ', '.join(list(tempdict.keys()))
        prval = ', '.join(['%s' for i in range(len(list(tempdict.values())))])

        execline = 'INSERT INTO modules (' + modules + ') VALUES (' + prval + ')'

        print(execline)
        print(list(tempdict.values()))

        with conn.cursor() as cursor:
            cursor.execute(execline, list(tempdict.values()))
            conn.commit()

        print()

    conn.close()

#############################################################
