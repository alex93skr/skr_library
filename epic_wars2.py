# !/usr/bin/python3
# -*- coding: utf-8 -*-

##########################################################

import random
import time
from threading import Thread
from tkinter import *
import math


##########################################################


def name_gen():
    """генератор имени"""
    ascii_lowercase = 'abcdefghijklmnopqrstuvwxyz'
    n1 = random.choice(ascii_lowercase).upper()
    n2 = ''.join(random.choice(ascii_lowercase) for i in range(random.randint(2, 3)))
    return f'{n1}{n2}'


def collision(el, rect):
    """пересечение границ"""
    if (rect[0] <= el[0] <= rect[2] and rect[1] <= el[1] <= rect[3]) or (
            rect[0] <= el[0] <= rect[2] and rect[1] <= el[3] <= rect[3]) or (
            rect[0] <= el[2] <= rect[2] and rect[1] <= el[3] <= rect[3]) or (
            rect[0] <= el[2] <= rect[2] and rect[1] <= el[1] <= rect[3]):
        return True


class Fight_thread(Thread):
    '''новый поток - бой двух юнитов'''

    def __init__(self, attacker, defender):
        Thread.__init__(self)
        self.attacker = attacker
        self.defender = defender
        # self.threadname = f'{attacker.unitname} vs {defender.unitname}'

    def run(self):
        while True:
            if not self.attacker.alive:
                return
            if not self.defender.alive:
                self.attacker.move = True
                self.attacker.infight = False
                self.attacker.way_to_victory()
                return

            # print(self.attacker.unitname, 'hit', self.defender.unitname, ':', self.defender.hp, '-',
            #       self.attacker.attack, '=', self.defender.hp - self.attacker.attack)
            if self.defender.hp - self.attacker.attack < 0:
                self.defender.hp = 0
            else:
                self.defender.hp -= self.attacker.attack

            self.defender.reload_label()

            if self.defender.hp <= 0:
                print(self.defender.unitname, 'DEAD')
                self.defender.alive = False
                canvas.itemconfig(self.defender.figure, fill="white")
                self.attacker.move = True
                self.attacker.infight = False
                self.attacker.way_to_victory()
                return
            time.sleep(self.attacker.attack_speed)

    # def condition_check(self):


def fight(unit1, unit2):
    '''бой двух юнитов'''

    # print(unit1.armyname, unit1.unitname)
    # print(unit2.armyname, unit2.unitname)
    print('FIGHT', unit1.unitname, unit2.unitname)

    Fight_thread(unit1, unit2).start()
    Fight_thread(unit2, unit1).start()

    # print('FIGHT', unit1.unitname, unit2.unitname, 'END')

    # if random.getrandbits(1):
    #     q1 = Fight_thread(unit1, unit2).start()
    #     q2 = Fight_thread(unit2, unit1).start()
    #     print('1')
    # else:
    #     Fight_thread(unit2, unit1).start()
    #     Fight_thread(unit1, unit2).start()
    #     print('2')


##########################################################


class Warrior:
    '''Боевая единица'''

    def __init__(self, canvas, armyname, unitname):
        # параметры
        self.canvas = canvas
        self.armyname = armyname
        self.unitname = unitname
        self.alive = True
        self.move = True
        # self.direction = 'direct'
        self.direction = random.choice(('chaotic', 'direct'))
        self.step_x = None
        self.step_y = None
        self.infight = False

        self.hp = random.randint(80, 100)
        self.attack = random.randint(5, 15)
        self.attack_speed = random.randint(1, 3)

        # фигура, метка
        self.figure = canvas.create_rectangle(
            0, 0, FIGURE_SIZE, FIGURE_SIZE, outline="black", fill=self.armyname, width=2
        )

        self.label = canvas.create_text(
            (0, 0), text=f'{self.unitname} {self.hp}', anchor='center', font='sans 10'
        )

        # в рендомное место на поле
        self.canvas.move(
            self.figure,
            random.randint(5, WINDOW_SIZE - FIGURE_SIZE - 5),
            random.randint(5, WINDOW_SIZE - FIGURE_SIZE - 5)
        )
        self.coord = self.canvas.coords(self.figure)
        self.canvas.move(self.label, self.coord[0] + FIGURE_SIZE / 2, self.coord[1] + FIGURE_SIZE / 2)

        # self.way_to_victory()

    def reload_label(self):
        coord = self.canvas.coords(self.label)
        self.canvas.delete(self.label)
        self.label = canvas.create_text(
            coord[0], coord[1], text=f'{self.unitname} {self.hp}', anchor='center', font='sans 10')

    def way_to_victory(self):
        # self.label.update()

        '''двжение и поиск боя'''

        if self.alive and self.move and not self.infight:
            pass
        else:
            return

        # движение
        if self.direction == 'chaotic':
            new_coord = self.chaotic_movement()
        elif self.direction == 'direct':
            new_coord = self.direct_movement()

        self.canvas.move(self.figure, new_coord[0], new_coord[1])
        self.canvas.move(self.label, new_coord[0], new_coord[1])
        self.coord = self.canvas.coords(self.figure)

        # проверка на коллизию
        for arm in all_armys.keys():
            if arm != self.armyname:
                for unit in all_armys[arm].warriors.keys():
                    if all_armys[arm].warriors[unit].alive:
                        if collision(self.coord, all_armys[arm].warriors[unit].coord):
                            self.move = False
                            all_armys[arm].warriors[unit].move = False
                            self.infight = True
                            all_armys[arm].warriors[unit].infight = True
                            fight(all_armys[self.armyname].warriors[self.unitname], all_armys[arm].warriors[unit])

        self.canvas.after(AFTER_PAUSE, self.way_to_victory)

    def chaotic_movement(self):
        '''хаотичное движение'''
        x = random.randint(-REND_MOVE_LIMIT, REND_MOVE_LIMIT)
        y = random.randint(-REND_MOVE_LIMIT, REND_MOVE_LIMIT)

        if x + self.coord[0] < 0:
            x *= -1
        if y + self.coord[1] < 0:
            y *= -1
        if x + self.coord[2] > WINDOW_SIZE:
            x *= -1
        if y + self.coord[3] > WINDOW_SIZE:
            y *= -1

        return x, y

    def direct_movement(self):
        '''прямолинейное отраженное движение'''
        if self.step_x is None:
            x = random.randint(0, REND_MOVE_LIMIT)
            y = round(math.sqrt(REND_MOVE_LIMIT ** 2 - x ** 2))
            self.step_x = random.choice((-1, 1)) * x
            self.step_y = random.choice((-1, 1)) * y

        if self.step_x + self.coord[0] < 0:
            self.step_x *= -1
        if self.step_y + self.coord[1] < 0:
            self.step_y *= -1
        if self.step_x + self.coord[2] > WINDOW_SIZE:
            self.step_x *= -1
        if self.step_y + self.coord[3] > WINDOW_SIZE:
            self.step_y *= -1

        return self.step_x, self.step_y


class Army:
    def __init__(self, armyname):
        self.armyname = armyname
        self.warriors = {}


def priziv(armyname, count):
    # army = Army(army)
    all_armys.update({armyname: Army(armyname)})
    for i in range(count):
        unitname = name_gen()
        all_armys[armyname].warriors.update({unitname: Warrior(canvas, armyname, unitname)})
        all_armys[armyname].warriors[unitname].way_to_victory()


def main():
    # army = random.choice(["white", "red", "green", "blue", "cyan", "yellow", "magenta"])

    army = random.choice(["red", "green", "blue", "cyan", "yellow", "magenta"])
    priziv(army, 3)
    army = random.choice(["red", "green", "blue", "cyan", "yellow", "magenta"])
    priziv(army, 3)
    # army = random.choice(["red", "green", "blue", "cyan", "yellow", "magenta"])
    # priziv(army, 3)


##########################################################

if __name__ == '__main__':
    all_armys = {}

    WINDOW_SIZE = 400

    # PRIZIV_LIMIT = (1, 1)

    FIGURE_SIZE = 50

    # START_COORD_LIMIT = 100

    REND_MOVE_LIMIT = 2

    AFTER_PAUSE = 10  # ms

    root = Tk()
    canvas = Canvas(width=WINDOW_SIZE, height=WINDOW_SIZE, bg='white')
    canvas.pack()

    main()

    root.mainloop()
