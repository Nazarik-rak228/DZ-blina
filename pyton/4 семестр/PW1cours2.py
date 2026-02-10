import os
from abc import ABC, abstractmethod


# Абстрактный класс 
class Person:
    def __init__(self, name):
        self.name = name
    @abstractmethod
    def menu(self):
        pass  


# Класс Книга (Инкапсуляция через простые атрибуты + метод)
class Book:
    def __init__(self, title, author):
        self.title = title.strip()
        self.author = author.strip()
        self.status = "доступна"          # доступна / выдана
        self.borrowed_by = None           # кто взял (имя пользователя или None)

    def __str__(self):
        if self.status == "доступна":
            return f'"{self.title}" — {self.author} (доступна)'
        else:
            return f'"{self.title}" — {self.author} (выдана {self.borrowed_by})'


# Пользователь (Наследование + Полиморфизм)
class User(Person):
    def __init__(self, name):
        super().__init__(name)
        self.borrowed = []  # список взятых книг

    def menu(self):
        while True:
            print(f"\n=== {self.name} (читатель) ===")
            print("1. Показать доступные книги")
            print("2. Взять книгу")
            print("3. Вернуть книгу")
            print("4. Мои книги")
            print("0. Выход")
            choice = input("→ ")

            if choice == "0": break
            elif choice == "1": show_available()
            elif choice == "2": take_book(self)
            elif choice == "3": return_book(self)
            elif choice == "4": show_my_books(self)
            else: print("Неверный выбор")


# Библиотекарь (Полиморфизм — другой menu)
class Librarian(Person):
    def menu(self):
        while True:
            print(f"\n=== {self.name} (библиотекарь) ===")
            print("1. Добавить книгу")
            print("2. Удалить книгу")
            print("3. Зарегистрировать читателя")
            print("4. Показать всех читателей")
            print("5. Показать все книги")
            print("0. Выход")
            choice = input("→ ")

            if choice == "0": break
            elif choice == "1": add_book()
            elif choice == "2": remove_book()
            elif choice == "3": register_user()
            elif choice == "4": show_users()
            elif choice == "5": show_all_books()
            else: print("Неверный выбор")


# Глобальные списки - а то не будут доступны где то вдруг
books = []
users = []
librarians = []


# ─── Файлы ────────────────────────────────────────────────
def load():
    global books, users, librarians

    if os.path.exists("books.txt"):
        with open("books.txt", encoding="utf-8") as f:
            for line in f:
                line = line.strip()
                if not line: continue
                title, author, status, borrowed_by = line.split("|")
                b = Book(title, author)
                b.status = status.strip()
                b.borrowed_by = borrowed_by.strip() if borrowed_by.strip() else None
                books.append(b)

    if os.path.exists("users.txt"):
        with open("users.txt", encoding="utf-8") as f:
            for line in f:
                name = line.strip()
                if name:
                    users.append(User(name))

    if os.path.exists("librarians.txt"):
        with open("librarians.txt", encoding="utf-8") as f:
            for line in f:
                name = line.strip()
                if name:
                    librarians.append(Librarian(name))


def save():
    with open("books.txt", "w", encoding="utf-8") as f:
        for b in books:
            borrowed = b.borrowed_by if b.borrowed_by else ""
            f.write(f"{b.title}|{b.author}|{b.status}|{borrowed}\n")

    with open("users.txt", "w", encoding="utf-8") as f:
        for u in users:
            f.write(f"{u.name}\n")

    with open("librarians.txt", "w", encoding="utf-8") as f:
        for l in librarians:
            f.write(f"{l.name}\n")


# -------------------------действия для людей---------------------------------------------------------------------------------------------------------------------------------------------------------------------
def show_available():
    avail = [b for b in books if b.status == "доступна"]
    if not avail:
        print("Нет доступных книг")
        return
    print("\nДоступные книги:")
    for i, b in enumerate(avail, 1):
        print(f"{i}. {b}")


def show_all_books():
    if not books:
        print("Книг пока нет")
        return
    print("\nВсе книги:")
    for i, b in enumerate(books, 1):
        print(f"{i}. {b}")


def show_users():
    if not users:
        print("Читателей нет")
        return
    print("\nЧитатели:")
    for i, u in enumerate(users, 1):
        print(f"{i}. {u.name}")


def show_my_books(user):
    if not user.borrowed:
        print("У вас нет книг")
        return
    print("\nВаши книги:")
    for i, b in enumerate(user.borrowed, 1):
        print(f"{i}. {b.title}")


def add_book():
    title = input("Название: ").strip()
    author = input("Автор: ").strip()
    if not title or not author:
        print("Заполните оба поля")
        return
    if any(b.title.lower() == title.lower() for b in books):
        print("Такая книга уже есть")
        return
    books.append(Book(title, author))
    print("Книга добавлена")


def remove_book():
    show_all_books()
    if not books: return
    try:
        n = int(input("Номер книги для удаления: "))
        if 1 <= n <= len(books):
            book = books[n-1]
            if book.status == "выдана":
                print("Книгу нельзя удалить — она на руках")
                return
            books.remove(book)
            print("Книга удалена")
        else:
            print("Неверный номер")
    except:
        print("Введите число")


def register_user():
    name = input("Имя нового читателя: ").strip()
    if not name:
        print("Имя не может быть пустым")
        return
    if any(u.name.lower() == name.lower() for u in users):
        print("Такой читатель уже есть")
        return
    users.append(User(name))
    print(f"Читатель {name} зарегистрирован")


def take_book(user):
    show_available()
    avail = [b for b in books if b.status == "доступна"]
    if not avail: return
    try:
        n = int(input("Номер книги: "))
        if 1 <= n <= len(avail):
            book = avail[n-1]
            book.status = "выдана"
            book.borrowed_by = user.name
            user.borrowed.append(book)
            print(f"Вы взяли: {book.title}")
        else:
            print("Неверный номер")
    except:
        print("Введите число")


def return_book(user):
    show_my_books(user)
    if not user.borrowed: return
    try:
        n = int(input("Номер книги для возврата: "))
        if 1 <= n <= len(user.borrowed):
            book = user.borrowed[n-1]
            book.status = "доступна"
            book.borrowed_by = None
            user.borrowed.remove(book)
            print(f"Книга {book.title} возвращена")
        else:
            print("Неверный номер")
    except:
        print("Введите число")


# ─── Главное меню ─────────────────────────────────────────
def main():
    load()

    # Если нет библиотекарей — создаём первого
    if not librarians:
        print("Первый запуск. Создаём библиотекаря.")
        name = input("Имя библиотекаря: ").strip()
        if name:
            librarians.append(Librarian(name))
        else:
            print("Имя не введено → выход")
            save()
            return

    while True:
        print("\n" + "-"*35)
        print("   БИБЛИОТЕКА")
        print("-"*35)
        print("1 — Библиотекарь")
        print("2 — Читатель")
        print("0 — Выход")
        role = input("→ ")

        if role == "0":
            break

        elif role == "1":
            print("\nБиблиотекари:")
            for i, lib in enumerate(librarians, 1):
                print(f"{i}. {lib.name}")
            try:
                n = int(input("Выберите → "))
                if 1 <= n <= len(librarians):
                    librarians[n-1].menu()
                else:
                    print("Нет такого")
            except:
                print("Введите число")

        elif role == "2":
            if not users:
                print("Читателей пока нет")
                continue
            print("\nЧитатели:")
            for i, u in enumerate(users, 1):
                print(f"{i}. {u.name}")
            try:
                n = int(input("Выберите → "))
                if 1 <= n <= len(users):
                    users[n-1].menu()
                else:
                    print("Нет такого")
            except:
                print("Введите число")

    save()
    print("До свидания!")


if __name__ == "__main__":
    main()