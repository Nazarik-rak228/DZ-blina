import os
from abc import ABC, abstractmethod
import gzip;
import pickle;


class Person(ABC):
    def __init__(self, name):
        self.name = name

    @abstractmethod
    def menu(self):
        pass  



class Book:
    def __init__(self, title, author):
        self.__title = title.strip()
        self.__author = author.strip()
        self.__status = "доступна"          
        self.__borrowed_by = None           

    @property
    def title(self):
        return self.__title

    @property
    def author(self):
        return self.__author

    @property
    def status(self):
        return self.__status

    @status.setter
    def status(self, value):
        if value not in ("доступна", "выдана"):
            raise ValueError("Статус может быть только 'доступна' или 'выдана'")
        self.__status = value

    @property
    def borrowed_by(self):
        return self.__borrowed_by

    @borrowed_by.setter
    def borrowed_by(self, value):
        self.__borrowed_by = value

    def __str__(self):
        if self.__status == "доступна":
            return f'"{self.__title}" — {self.__author} (доступна)'
        else:
            borrowed = self.__borrowed_by if self.__borrowed_by else "кем-то"
            return f'"{self.__title}" — {self.__author} (выдана {borrowed})'



class User(Person):
    def __init__(self, name):
        super().__init__(name)
        self.borrowed = []  

    def show_my_books(self):
        if not self.borrowed:
            print("У вас нет книг")
            return
        print(f"\nКниги читателя {self.name}:")
        for i, b in enumerate(self.borrowed, 1):
            print(f"{i}. {b.title}")

    def take_book(self):
        avail = [b for b in books if b.status == "доступна"]
        if not avail:
            print("Нет доступных книг")
            return

        show_available()
        try:
            n = int(input("Номер книги: "))
            if 1 <= n <= len(avail):
                book = avail[n-1]
                book.status = "выдана"
                book.borrowed_by = self.name
                self.borrowed.append(book)
                print(f"Вы взяли: {book.title}")
            else:
                print("Неверный номер")
        except ValueError:
            print("Введите число")

    def return_book(self):
        self.show_my_books()
        if not self.borrowed:
            return
        try:
            n = int(input("Номер книги для возврата: "))
            if 1 <= n <= len(self.borrowed):
                book = self.borrowed[n-1]
                book.status = "доступна"
                book.borrowed_by = None
                self.borrowed.remove(book)
                print(f"Книга {book.title} возвращена")
            else:
                print("Неверный номер")
        except ValueError:
            print("Введите число")

    def menu(self):
        while True:
            print(f"\n=== {self.name} (читатель) ===")
            print("1. Показать доступные книги")
            print("2. Взять книгу")
            print("3. Вернуть книгу")
            print("4. Мои книги")
            print("0. Выход")
            choice = input("→ ")

            if choice == "0":
                break
            elif choice == "1":
                show_available()
            elif choice == "2":
                self.take_book()
            elif choice == "3":
                self.return_book()
            elif choice == "4":
                self.show_my_books()
            else:
                print("Неверный выбор")



class Librarian(Person):
    def add_book(self):
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

    def show_all_books(self):
        if not books:
            print("Книг пока нет")
            return
        print("\nВсе книги в библиотеке:")
        for i, b in enumerate(books, 1):
            print(f"{i}. {b}")
            
    def remove_book(self):

        if not books:
            return
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
        except ValueError:
            print("Введите число")

    def register_user(self):
        name = input("Имя нового читателя: ").strip()
        if not name:
            print("Имя не может быть пустым")
            return
        if any(u.name.lower() == name.lower() for u in users):
            print("Такой читатель уже есть")
            return
        users.append(User(name))
        print(f"Читатель {name} зарегистрирован")

    

    def show_users(self):
        if not users:
            print("Читателей нет")
            return
        print("\nЗарегистрированные читатели:")
        for i, u in enumerate(users, 1):
            print(f"{i}. {u.name}")

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

            if choice == "0":
                break
            elif choice == "1":
                self.add_book()
            elif choice == "2":
                self.remove_book()
            elif choice == "3":
                self.register_user()
            elif choice == "4":
                self.show_users()
            elif choice == "5":
                self.show_all_books()
            else:
                print("Неверный выбор")


# Глобальные списки
books = []
users = []
librarians = []



def load():
    global books, users, librarians

    try:
        with open("saveFull.gz","rb") as title:
            books,users,librarians=pickle.load(title)
    
    except(FileNotFoundError):
        books = []
        users = []
        librarians = []
    # if os.path.exists("saveBook.gz"):
    #     with open("saveBook.gz","rb") as title:
    #         a=pickle.load(title)
    #         books.append(a)
        # with open("books.txt", encoding="utf-8") as f:
        #     for line in f:
        #         line = line.strip()
        #         if not line:
        #             continue
        #         try:
        #             title, author, status, borrowed_by = line.split("|", 3)
        #             b = Book(title, author)
        #             b.status = status.strip()
        #             b.borrowed_by = borrowed_by.strip() or None
        #             books.append(b)
        #         except:
        #             continue  # пропускаем битые строки

    # if os.path.exists("saveUsers.gz"):
    #     with open("saveUsers.gz","rb") as title:
    #         a=pickle.load(title)
    #         users.append(a)
        # with open("users.txt", encoding="utf-8") as f:
        #     for line in f:
        #         name = line.strip()
        #         if name:
        #             users.append(User(name))

    # if os.path.exists("saveLibrarians.gz"):
    #     with open("saveLibrarians.gz","rb") as title:
    #         a=pickle.load(title)
    #         librarians.append(a)
        # with open("librarians.txt", encoding="utf-8") as f:
        #     for line in f:
        #         name = line.strip()
        #         if name:
        #             librarians.append(Librarian(name))


def save():
    with open("saveFull.gz","wb") as title:
        pickle.dump((books,users,librarians), title)

    # with open("books.txt", "w", encoding="utf-8") as f:
    #     for b in books:
    #         borrowed = b.borrowed_by if b.borrowed_by else ""
    #         f.write(f"{b.title}|{b.author}|{b.status}|{borrowed}\n")

    # with open("users.txt", "w", encoding="utf-8") as f:
    #     for u in users:
    #         f.write(f"{u.name}\n")

    # with open("librarians.txt", "w", encoding="utf-8") as f:
    #     for l in librarians:
    #         f.write(f"{l.name}\n")


def show_available():
    avail = [b for b in books if b.status == "доступна"]
    if not avail:
        print("Нет доступных книг")
        return
    print("\nДоступные книги:")
    for i, b in enumerate(avail, 1):
        print(f"{i}. {b}")



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
            if not librarians:
                print("Библиотекарей нет")
                continue
            print("\nБиблиотекари:")
            for i, lib in enumerate(librarians, 1):
                print(f"{i}. {lib.name}")
            try:
                n = int(input("Выберите → "))
                if 1 <= n <= len(librarians):
                    librarians[n-1].menu()
                else:
                    print("Нет такого")
            except ValueError:
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
            except ValueError:
                print("Введите число")

    save()
    print("До свидания!")


if __name__ == "__main__":
    main()