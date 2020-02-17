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


def collision_coord(rect, el):
    """пересечение границ"""
    if (rect[0] <= el[0] <= rect[2] and rect[1] <= el[1] <= rect[3]) or (
            rect[0] <= el[0] <= rect[2] and rect[1] <= el[3] <= rect[3]) or (
            rect[0] <= el[2] <= rect[2] and rect[1] <= el[3] <= rect[3]) or (
            rect[0] <= el[2] <= rect[2] and rect[1] <= el[1] <= rect[3]):
        return True


##########################################################


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

    def __init__(self, **keywords):
        # параметры
        self.armyname = None
        self.unitname = None
        self.alive = True
        self.move = True
        self.move_x = random.randint(5, WINDOW_SIZE - FIGURE_SIZE - 5)
        self.move_y = random.randint(5, WINDOW_SIZE - FIGURE_SIZE - 5)

        self.infight = False
        self.hp = random.randint(80, 100)
        self.attack = random.randint(5, 15)
        self.attack_speed = random.randint(1, 3)

        for key in keywords:
            setattr(self, key, keywords[key])

        # фигура в рендомное место на поле
        # self.figure = canvas.create_rectangle(
        #     random.randint(5, WINDOW_SIZE - FIGURE_SIZE - 5),
        #     random.randint(5, WINDOW_SIZE - FIGURE_SIZE - 5),
        #     FIGURE_SIZE, FIGURE_SIZE, outline="black", fill=self.armyname, width=2
        # )

        self.figure = canvas.create_rectangle(
            0, 0, FIGURE_SIZE, FIGURE_SIZE,
            outline="black", fill=self.armyname, width=2
        )

        canvas.move(self.figure, self.move_x, self.move_y)

        self.label = canvas.create_text(
            0, 0,
            text=f'{self.unitname} {self.hp}',
            anchor='center', font='sans 10'
        )

        self.update_label()

    def update_label(self):
        canvas.move(self.label, self.move_x, self.move_y)


class Hunter(Warrior):

    def __init__(self, **keywords):
        self.tarrget = None
        super().__init__(**keywords)
        for key in keywords:
            setattr(self, key, keywords[key])
        self.line = None
        self.find_and_kill()

    def find_and_kill(self):
        if self.alive and self.move and not self.infight:
            pass
        else:
            return

        # new_coord = self.tracking()
        new_coord = self.OLD_tracking()
        canvas.move(self.figure, self.move_x, self.move_y)

        self.update_line()
        self.update_label()
        self.collision()

        canvas.after(AFTER_PAUSE, self.find_and_kill)

    def tracking(self):
        '''наводка с коэффициентным смещнием'''

        distance_x = canvas.coords(self.tarrget.figure)[0] - canvas.coords(self.figure)[0]
        distance_y = canvas.coords(self.tarrget.figure)[1] - canvas.coords(self.figure)[1]

        if distance_x != 0 or distance_y != 0:  # !!!!!
            if abs(distance_x) > abs(distance_y):
                coefficient = distance_x / distance_y
            else:
                coefficient = distance_y / distance_x

            print(abs(distance_x), abs(distance_y), coefficient)

            # canvas.coords(self.figure)
            # canvas.coords(self.tarrget.figure)

            arr = []
            for x in range(REND_MOVE_LIMIT):
                # x = random.randint(0, REND_MOVE_LIMIT)
                y = round(math.sqrt(REND_MOVE_LIMIT ** 2 - x ** 2))
                print(x, y, x / y)
                arr.append(x / y)

            self.get_nearest_value(coefficient, arr)

        self.move_x = 0
        self.move_y = 0

    def get_nearest_value(self, n_value, n_list):
        list_of_difs = [abs(n_value - x) for x in n_list]
        result_index = list_of_difs.index(min(list_of_difs))
        print('res:', n_list[result_index], result_index)
        return result_index

    def OLD_tracking(self):
        '''наводка с простым смещением на ось'''
        if canvas.coords(self.figure)[0] >= canvas.coords(self.tarrget.figure)[0]:
            x = -1 * random.randint(1, REND_MOVE_LIMIT)
        if canvas.coords(self.figure)[0] < canvas.coords(self.tarrget.figure)[0]:
            x = random.randint(1, REND_MOVE_LIMIT)

        if canvas.coords(self.figure)[1] >= canvas.coords(self.tarrget.figure)[1]:
            y = -1 * random.randint(1, REND_MOVE_LIMIT)
        if canvas.coords(self.figure)[1] < canvas.coords(self.tarrget.figure)[1]:
            y = random.randint(1, REND_MOVE_LIMIT)
        # return x, y
        self.move_x = x
        self.move_y = y

    def update_line(self):
        if not self.line is None:
            canvas.delete(self.line)
        self.line = canvas.create_line(
            canvas.coords(self.figure)[0] + FIGURE_SIZE / 2,
            canvas.coords(self.figure)[1] + FIGURE_SIZE / 2,
            canvas.coords(self.tarrget.figure)[0] + FIGURE_SIZE / 2,
            canvas.coords(self.tarrget.figure)[1] + FIGURE_SIZE / 2,
            fill='black', arrow=LAST, dash=(1, 1)
        )
        # canvas.create_line(100, 180, 100, 60, fill='green',
        #               width=5, arrow=LAST, dash=(10, 2),
        #               activefill='lightgreen',

    def collision(self):
        # проверка на коллизию
        if collision_coord(canvas.coords(self.figure), canvas.coords(self.tarrget.figure)):
            self.move = False
            self.tarrget.move = False
            self.infight = True
            self.tarrget.infight = True
            # fight(all_armys[self.armyname].warriors[self.unitname], all_armys[arm].warriors[unit])


class Victim(Warrior):
    def __init__(self, **keywords):
        super().__init__(**keywords)

        # self.direction = random.choice(['chaotic', 'direct'])
        self.direction = 'direct'
        self.start = False
        # self.step_x = None
        # self.step_y = None

        for key in keywords:
            setattr(self, key, keywords[key])

        self.save_your_life()

    def save_your_life(self):
        '''двжение и поиск боя'''

        if self.alive and self.move and not self.infight:
            pass
        else:
            return

        # движение
        if self.direction == 'chaotic':
            self.chaotic_movement()
        elif self.direction == 'direct':
            self.direct_movement()

        canvas.move(self.figure, self.move_x, self.move_y)
        self.update_label()

        canvas.after(AFTER_PAUSE, self.save_your_life)

    def chaotic_movement(self):
        '''хаотичное движение'''
        x = random.randint(-REND_MOVE_LIMIT, REND_MOVE_LIMIT)
        y = random.randint(-REND_MOVE_LIMIT, REND_MOVE_LIMIT)
        # рикошет от границ
        if x + canvas.coords(self.figure)[0] < 0:
            x *= -1
        if y + canvas.coords(self.figure)[1] < 0:
            y *= -1
        if x + canvas.coords(self.figure)[2] > WINDOW_SIZE:
            x *= -1
        if y + canvas.coords(self.figure)[3] > WINDOW_SIZE:
            y *= -1
        self.move_x = x
        self.move_y = y
        # return x, y

    def direct_movement(self):
        '''прямолинейное отраженное движение'''
        # TODO через угол !!!
        if not self.start:
            x = random.randint(0, REND_MOVE_LIMIT)
            y = round(math.sqrt(REND_MOVE_LIMIT ** 2 - x ** 2))
            self.move_x = random.choice((-1, 1)) * x
            self.move_y = random.choice((-1, 1)) * y
            self.start = True
        # рикошет от границ
        if (self.move_x + canvas.coords(self.figure)[0] < 0) or (
                self.move_x + canvas.coords(self.figure)[2] > WINDOW_SIZE):
            self.move_x *= -1
        if (self.move_y + canvas.coords(self.figure)[1] < 0) or (
                self.move_y + canvas.coords(self.figure)[3] > WINDOW_SIZE):
            self.move_y *= -1


class Army:
    def __init__(self, armyname):
        self.armyname = armyname
        self.warriors = {}


def priziv(armyname, count, tarrget=None):
    # army = Army(army)
    all_armys.update({armyname: Army(armyname)})
    for i in range(count):
        unitname = name_gen()
        all_armys[armyname].warriors.update({unitname: Warrior(armyname=armyname, unitname=unitname)})

        if tarrget is None:
            all_armys[armyname].warriors[unitname].save_your_life()
        else:
            all_armys[armyname].warriors[unitname].find_and_kill()


def main():
    hare = Victim(unitname=name_gen(), armyname="yellow")

    wolf = Hunter(unitname=name_gen(), armyname="red", tarrget=hare)

    # wolf = Hunter(tarrget=)

    # army = random.choice(["white", "red", "green", "blue", "cyan", "yellow", "magenta"])

    # priziv("cyan", 1)
    # army = random.choice(["red", "green", "blue", "cyan", "yellow", "magenta"])
    # priziv(army, 3)
    # army = random.choice(["red", "green", "blue", "cyan", "yellow", "magenta"])
    # priziv(army, 3)

    # t1 = all_armys["cyan"].warriors[list(all_armys["cyan"].warriors.keys())[0]]
    # t2 = all_armys["cyan"].warriors[list(all_armys["cyan"].warriors.keys())[1]]

    # print(list(all_armys["cyan"].warriors.keys()))


FIGURE_SIZE1 = 10

print(FIGURE_SIZE1)

##########################################################

if __name__ == '__main__':
    all_armys = {}

    WINDOW_SIZE = 600

    # PRIZIV_LIMIT = (1, 1)

    FIGURE_SIZE = 10

    # START_COORD_LIMIT = 100

    REND_MOVE_LIMIT = 3

    AFTER_PAUSE = 30  # ms

    root = Tk()
    canvas = Canvas(width=WINDOW_SIZE, height=WINDOW_SIZE, bg='white')
    canvas.pack()

    main()

    root.mainloop()
