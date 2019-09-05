#!/usr/bin/python3
# -*- coding: utf-8 -*-

# epic wars simulator

######################################################

import random


######################################################


class Warrior:
    def __init__(self, name):
        self.name = name
        self.hp = random.randint(hp_limit[0], hp_limit[1])
        self.attack = random.randint(15, 30)

    def hp_after_strike(self, newhp):
        self.hp = newhp


class Army:
    def __init__(self, name):
        self.name = name
        self.warriors = {}


def name_gen():
    ascii_lowercase = 'abcdefghijklmnopqrstuvwxyz'
    return f'{random.choice(ascii_lowercase).upper()}{"".join(random.choice(ascii_lowercase) for i in range(random.randint(3, 5)))}'


# print(name_gen())


def war(army1, army2):
    if random.getrandbits(1):
        army_att = army1
    else:
        army_att = army2

    print(army_att.name)

    while True:
        if army_att is army1:
            army_att = army2
            army_def = army1
        else:
            army_att = army1
            army_def = army2

        war_attack = army_att.warriors[random.choice(list(army_att.warriors.keys()))]
        war_def = army_def.warriors[random.choice(list(army_def.warriors.keys()))]

        hp_after_hit = war_def.hp - war_attack.attack

        str_att = f'{war_attack.name} [{army_att.name[0]}]'
        str_def = f'{war_def.name} [{army_def.name[0]}]'
        str_total = f'{war_def.hp} - {war_attack.attack} = {hp_after_hit}'

        war_def.hp_after_strike(hp_after_hit)

        print(f'{str_att:12} -> {str_def:12} : {str_total}', end='')

        if hp_after_hit <= 0:
            print(' KILL')
            army_def.warriors.pop(war_def.name)
        else:
            print()

        if not army_def.warriors:
            print()
            print(army_att.name, 'WIN:\n')
            postroenie(army_att)
            return


def priziv(army):
    for i in range(random.randint(priziv_limit[0], priziv_limit[1])):
        name = name_gen()
        army.warriors.update({name: Warrior(name)})


def postroenie(army):
    print(army.name, len(army.warriors))
    for i in army.warriors.keys():
        print(i, army.warriors[i].hp, army.warriors[i].attack)


######################################################

def main():
    army_red = Army('Крассные')
    army_blue = Army('Синие')

    print('\nMAKE ARMYS\n============\n')

    priziv(army_red)
    postroenie(army_red)
    print()

    priziv(army_blue)
    postroenie(army_blue)
    print()

    print('\nFIGHT\n============\n')

    war(army_red, army_blue)


######################################################

if __name__ == '__main__':

    priziv_limit = (100000, 100001)
    hp_limit = (80, 100)

    main()
