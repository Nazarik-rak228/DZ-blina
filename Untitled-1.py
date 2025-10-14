Num1 = input("Введите первое значение: ")
Num2 = input("Введите второе значение: ")
Znak = input("Введите оператор (+, -, , /, //, %, **, ==, !=, >, <, >=, <=, and, or, not, in, not in, is, is not): ")

if Znak == "+": 
  print("Результат:", Num1 + Num2)
elif Znak == "-": 
  print("Результат:", Num1 - Num2)
elif Znak == "": 
  print("Результат:", Num1 * Num2)
elif Znak == "/":
 if Num2 == 0:
   print("Ошибка: деление на ноль!")
 else: 
   print("Результат:", Num1 / Num2)
elif Znak == "//":
 if Num2 == 0: 
   print("Ошибка: деление на ноль!") 
 else: 
   print("Результат:", Num1 // Num2)
elif Znak == "%":
 if Num2 == 0: 
   print("Ошибка: деление на ноль!")
 else:
   print("Результат:", Num1 % Num2)
elif Znak == "":
  print("Результат:", Num1 ** Num2)
elif Znak == "==": 
  print("Результат:", Num1 == Num2)
elif Znak == "!=":
  print("Результат:", Num1 != Num2)
elif Znak == ">": 
  print("Результат:", Num1 > Num2)
elif Znak == "<": 
  print("Результат:", Num1 < Num2)
elif Znak == ">=":
  print("Результат:", Num1 >= Num2)
elif Znak == "<=": 
  print("Результат:", Num1 <= Num2)
elif Znak == "and": 
  print("Результат:", bool(Num1) and bool(Num2))
elif Znak == "or": 
  print("Результат:", bool(Num1) or bool(Num2))
elif Znak == "not": 
  print("Результат:", not bool(Num1))
elif Znak == "in": 
  print("Результат:", str(Num1) in str(Num2))
elif Znak == "not in": 
  print("Результат:", str(Num1) not in str(Num2))
elif Znak == "is": 
  print("Результат:", Num1 is Num2)
elif Znak == "is not": 
  print("Результат:", Num1 is not Num2)

else: print("Такого оператора нет!")