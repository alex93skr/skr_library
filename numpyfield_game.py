import random

import numpy as np


# a = np.array([0, 1, 2, 3, 4], dtype='int64')
# a = np.array([[1, 2, 3], [4, 5, 6]], float)

# size = 10
# a = np.zeros((size, size), dtype='int')


class Game():

    def __init__(self):

        self.debug = True

        self.size = 10
        self.weight = [i for i in range(1, 10)]
        self.field = np.zeros((self.size, self.size), dtype='int')

        self.start()
        # self.move()

    def start(self):

        if self.debug: print(self.field)

        # начальная
        _start_poz_coord = [random.randint(1, self.size - 1) for i in range(2)]
        # хвост для начальной
        _tail_coord = self.tail_coord(_start_poz_coord)

        _start_poz_weight = self.random_weight()
        _tail_coord_weight = self.random_weight()

        if self.debug: print(_start_poz_coord, _start_poz_weight)
        if self.debug: print(_tail_coord, _tail_coord_weight)

        self.field[tuple(_start_poz_coord)] = _start_poz_weight
        self.field[tuple(_tail_coord)] = _tail_coord_weight

        # self.field[_start_poz_coord[0]][_start_poz_coord[1]] = _start_poz_weight
        # self.field[_tail_coord[0]][_tail_coord[1]] = _tail_coord_weight

        if self.debug: print(self.field)

    def move(self):
        """
        случайный вес
        поиск этого веса на поле
        отпредеоение хвоста
        вес для хвоста
        :return:
        """

        _random_weight = self.random_weight()

        _search = self.search(_random_weight)

        # while _search is not None:

    def search(self, weight):
        _result = np.where(self.field == weight)
        if _result[0].size == 0:
            if self.debug: print(f'{_result[0].size=}')
            return None
        else:

            if self.debug: print('search _result', [(_result[0][i], _result[1][i]) for i in range(_result[0].size)])
            return [(_result[0][i], _result[1][i]) for i in range(_result[0].size)]

    def random_weight(self):
        return random.choice(self.weight)

    def random_direction(self):
        return random.choice(['up', 'down', 'left', 'right'])

    def tail_coord(self, coord):
        """
        вход начальная точка
        от нее поиск места для хвоста
        возможные напрвления
        проверка на лимит и равно нулю

        :return:
        """

        _possible_directions = self.possible_directions(coord)
        if self.debug: print(f'{_possible_directions=}')
        result = None

        while _possible_directions:

            _cell = random.choice(_possible_directions)
            if self.debug: print(f'{_cell=}')

            if self.check_coord_zero(_cell):
                if self.debug: print(_cell, 'норм')
                result = _cell
                break
            else:
                _possible_directions.remove(_cell)
                if self.debug: print('_cell del', _possible_directions)

        return result

    def possible_directions(self, coord):
        # возможные хвосты
        return [
            [coord[0] - 1, coord[1]], [coord[0] + 1, coord[1]],
            [coord[0], coord[1] - 1], [coord[0], coord[1] + 1]
        ]

    def check_coord_zero(self, coord):
        try:
            return not bool(self.field[tuple(coord)])
        except IndexError:
            return False

    # def check_coord_limit(self, fn):
    #     try:
    #         fn()
    #     except IndexError:
    #         return False

    # return self.check_coord_limit(bool(self.field[tuple(coord)]))

    # if no_zero:
    #     bool(self.field[tuple(coord)])
    # else:
    #     return bool(self.field[tuple(coord)])

    # print(self.field[tuple(coord)])
    # print(bool(self.field[tuple(coord)]))
    # return bool(self.field[tuple(coord)])
    # if self.field[tuple(coord)]:
    #     return False
    # else:
    #     return False

    def check_coord_limit(self, fn):
        try:
            fn()
        except IndexError:
            return False


game = Game()
