import json
import os

import xmltodict


class Appdata:
    names = []
    data = {}

    @staticmethod
    def add(pars_data):
        if Appdata.data == {}:
            Appdata.data = pars_data
        else:
            Appdata.data.update(pars_data)


def collect_xml2dict(root, filename):
    xml_file = os.path.join(root, filename)

    if filename in Appdata.names:
        raise Exception('names duble')

    Appdata.names.append(filename)

    print(xml_file)

    with open(xml_file, encoding='utf-8') as fd:
        doc = xmltodict.parse(fd.read())

        # print(doc)
        # pp = pprint.PrettyPrinter(indent=4)
        # pp.pprint(json.dumps(doc))
        # pprint(dict(doc), indent=1)

        output_dict = json.loads(json.dumps(doc))
        # output_dict = json.dumps(doc)

        output_dict['vehicle'].pop('i3dMappings', print('err i3dMappings', xml_file))
        output_dict['vehicle'].pop('animations', print('err animations', xml_file))
        output_dict['vehicle'].pop('movingParts', print('err animations', xml_file))
        output_dict['vehicle'].pop('animationNodes', print('err animationNodes', xml_file))

        output_dict = {filename[:-4]: output_dict['vehicle']}

        # pprint(output_dict, sort_dicts=False)

        Appdata.add(output_dict)


def xml2dict():
    for root, dirs, files in os.walk("D:\\Games\\FarmingSimulator19\\data\\vehicles"):
        for filename in files:
            if filename.endswith(".xml"):
                try:
                    collect_xml2dict(root, filename)
                except:
                    print('err', root, filename)

    with open("data_file.json", "w") as write_file:
        json.dump(Appdata.data, write_file, sort_keys=False, indent=1)

    # sorted_tuple = sorted(Appdata.storeData.items(), key=lambda x: x[1], reverse=True)
    # pprint(sorted_tuple)


def date_science():
    with open("data_file.json", "r") as read_file:
        data = json.load(read_file)

    for vehicle in data:

        # print(vehicle)

        if 'locomotive' in vehicle:
            continue

        # if vehicle == 'fastrac4220':

        category = data[vehicle]['storeData']['category']
        if category == 'tractorsS':

            # print(vehicle)
            # print(data[vehicle]['motorized'].get('motorConfigurations'))

            power = data[vehicle]['storeData']['specs']['power']
            maxSpeed = data[vehicle]['storeData']['specs']['maxSpeed']
            price = data[vehicle]['storeData']['price']

            # print(vehicle, ', ', , ', ',)
            # print(vehicle, ', ', '-', ', ', motor['@hp'], ', ', motor['@price'])

            # тачка, цена, скорость, двигло, лошади,  за двигло

            if isinstance(data[vehicle]['motorized']['motorConfigurations']['motorConfiguration'], list):

                for motor in data[vehicle]['motorized']['motorConfigurations']['motorConfiguration']:
                    # print(motor['@name'])
                    # print(motor['@hp'])
                    # print(motor['@price'])

                    # print(vehicle, ', ', motor['@name'], ', ',motor['@hp'], ', ',motor['@price'])

                    print(', '.join(
                        [vehicle, price, maxSpeed, motor['@name'], motor['@hp'], motor['@price']]
                    ))
            else:
                print(','.join(
                    [vehicle, price, maxSpeed, 'STOCK', power, '0']
                ))

# xml2dict()
# date_science()