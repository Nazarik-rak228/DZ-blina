import os
from datetime import datetime

# Создание доски
def create_board(size):
    return [[' ' for _ in range(size)] for _ in range(size)]

# Показ доски
def show_board(board, size):
    print('\n' + '-' * (size * 4 - 1))
    for row in board:
        print('| ' + ' | '.join(row) + ' |')
        print('-' * (size * 4 - 1))
    print()

# Ход: True если ок
def make_move(board, row, col, player, size):
    if 0 <= row < size and 0 <= col < size and board[row][col] == ' ':
        board[row][col] = player
        return True
    return False

# Проверка конца: 'X'/'O' если победа, 'draw' если ничья, None если продолжаем
def check_end(board, size, current):
    # Строки
    for i in range(size):
        row_ok = True
        for j in range(size):
            if board[i][j] != current:
                row_ok = False
                break
        if row_ok:
            return current
    
    # Столбцы
    for j in range(size):
        col_ok = True
        for i in range(size):
            if board[i][j] != current:
                col_ok = False
                break
        if col_ok:
            return current
    
    # Диагональ 1
    diag1_ok = True
    for i in range(size):
        if board[i][i] != current:
            diag1_ok = False
            break
    if diag1_ok:
        return current
    
    # Диагональ 2
    diag2_ok = True
    for i in range(size):
        if board[i][size - 1 - i] != current:
            diag2_ok = False
            break
    if diag2_ok:
        return current
    
    # Ничья
    full = True
    for i in range(size):
        for j in range(size):
            if board[i][j] == ' ':
                full = False
                break
        if not full:
            break
    if full:
        return 'draw'
    
    return None

# Сохранение статистики
def save_stats(first_player, winner):
    stats_file = 'stats.txt'
    if not os.path.exists(stats_file):
        with open(stats_file, 'w', encoding='utf-8') as f:
            f.write("Статистика игр:\n")
            f.write("Режим | Первый игрок | Победитель | Дата\n")
    
    with open(stats_file, 'a', encoding='utf-8') as f:
        date = datetime.now().strftime("%Y-%m-%d %H:%M")
        result = winner if winner != 'draw' else 'Ничья'
        f.write(f"PvP | {first_player} | {result} | {date}\n")