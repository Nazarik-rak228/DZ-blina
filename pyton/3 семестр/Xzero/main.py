from game_logic import (create_board, show_board, make_move, check_end, save_stats)
import random

def get_board_size():
    while True:
        try:
            size = int(input("Введите размер поля (3+): "))
            if size >= 3 and size <=9:
                return size
            print("Размер должен быть >= 3 и <=9!")
        except ValueError:
            print("Введите целое число!")

def get_player_move(board, size, current):
    while True:
        try:
            move = input(f"Ход {current} (строка, столбец, 1-минимум): ").strip().split(',')
            if len(move) != 2:
                raise ValueError
            row, col = int(move[0]) - 1, int(move[1]) - 1
            if make_move(board, row, col, current, size):
                return
            print("Неверный ход! Поле занято или вне доски.")
        except (ValueError, IndexError):
            print("Формат: число,число (например, 1,1)")

def play_game():
    size = get_board_size()
    board = create_board(size)
    
    # Рандомный первый игрок
    first_player = random.choice(['X', 'O'])
    current = first_player
    print(f"Первый игрок: {first_player}")
    
    while True:
        show_board(board, size)
        
        get_player_move(board, size, current)
        
        end = check_end(board, size, current)
        if end:
            show_board(board, size)
            if end == 'draw':
                print("Патовая ситуация (ничья)!")
                winner = 'draw'
            else:
                print(f"Победил {end}!")
                winner = end
            save_stats(first_player, winner)
            print("Статистика сохранена в stats.txt")
            break
        
        # Смена
        current = 'O' if current == 'X' else 'X'

def main():
    while True:
        play_game()
        if input("Новая игра? (y/n): ").lower() != 'y':
            break
    print("Пока!")

if __name__ == "__main__":
    main()