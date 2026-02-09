def vse_operations(vvod1, operator, vvod2):
    # обработка переменных
    try:
        if isinstance(vvod2, str) and vvod2.startswith('[') and vvod2.endswith(']'):
            vvod1 = int(vvod1)
            vvod2 = eval(vvod2) #превращение в список
            vvod2 = [int(x) for x in vvod2] #в списке переводим строки в числа
        elif operator in ['+', '-', '*', '/', '//', '%', '**']:
            vvod1 = float(vvod1)
            vvod2 = float(vvod2)
        elif vvod1 in ['True', 'False']:
            vvod1 = True if vvod1 == 'True' else False
            if vvod2 in ['True', 'False']:
                vvod2 = True if vvod2 == 'True' else False
        elif vvod2 in ['True', 'False']:
             vvod2 = True if vvod2 == 'True' else False
             if vvod1 in ['True', 'False']:
                vvod1 = True if vvod1 == 'True' else False
    except ValueError:
        return "Ошибка: неверный формат чисел или списка!"

    # действия калькулятора
    if operator == '+':
        return vvod1 + vvod2
    elif operator == '-':
        return vvod1 - vvod2
    elif operator == '*':
        return vvod1 * vvod2
    elif operator == '/':
        if vvod2 == 0:
            return "На ноль делить нельзя!"
        return vvod1 / vvod2
    elif operator == '//':
        if vvod2 == 0:
            return "На ноль делить нельзя!"
        return vvod1 // vvod2
    elif operator == '%':
        if vvod2 == 0:
            return "На ноль делить нельзя!"
        return vvod1 % vvod2
    elif operator == '**':
        return vvod1 ** vvod2
    elif operator == '==':
        return vvod1 == vvod2
    elif operator == '!=':
        return vvod1 != vvod2
    elif operator == '>':
        return vvod1 > vvod2
    elif operator == '<':
        return vvod1 < vvod2
    elif operator == '>=':
        return vvod1 >= vvod2
    elif operator == '<=':
        return vvod1 <= vvod2
    elif operator == 'and':
        return vvod1 and vvod2
    elif operator == 'or':
        return vvod1 or vvod2
    elif operator == 'not':
        return not vvod1
    elif operator == 'in':
        return vvod1 in vvod2
    elif operator == 'not in':
        return vvod1 not in vvod2
    elif operator == 'is':
        return vvod1 is vvod2
    elif operator == 'is not':
        return vvod1 is not vvod2
    else:
        return "Ошибка: неизвестный оператор!"

def main():
    print("Калькулятор поддерживает:")
    print("- Арифметические: +, -, *, /, //, %, **")
    print("- Логические: and, or, not")
    print("- Тождество: is, is not")
    print("- Принадлежность: in, not in")
    print("- Сравнение: ==, !=, >, <, >=, <=")
    print("Формат ввода: vvod1 operator vvod2 (например, '5 + 3' или '3 in [1, 2, 3]')")
    print("для логических vvod1 всегда или 'True' или 'False', для тождественных 'True', 'False'")
    print("Введите 'выход' для завершения")

    while True:
        vvod1 = input("\nВведите первое число/значение: ")
        operator = input("\nВведите оператор: ")
        vvod2 = input("\nВведите второе число/значение: ")
        if vvod1.lower() == 'выход': # если введем "ВЫХОД" ТО ПРОГРАММА ОСТАНОВИТСЯ, lower нужен,         
            print("Программа завершена")# чтобы слово выход игнорировалось проверкой на неправельный ввод и код делал команду заверения цикла вместо выдачи ошибки
            break
        print(vse_operations(vvod1, operator, vvod2))
        

if __name__ == "__main__":
    main()