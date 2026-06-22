from sqlalchemy import func
from sqlalchemy import create_engine, Column, Integer, String, ForeignKey
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker, relationship

engine = create_engine(
    "sqlite:///library.db",
    echo = True
)
Base = declarative_base()
print(engine)


class Author (Base):
    __tablename__ = "authors"
    id = Column(Integer, primary_key=True)
    name = Column(String, nullable=False)
    birth_year = Column(Integer, nullable=False)
    books = relationship("Book", back_populates="author")

class Book(Base):
    __tablename__ = "books"
    id = Column(Integer, primary_key=True)
    title = Column(String, nullable=False)
    year = Column(Integer, nullable=False)
    author_id = Column(Integer, ForeignKey("authors.id"))
    author = relationship("Author", back_populates="books")
Base.metadata.create_all(engine)

Session = sessionmaker(bind=engine)
session=Session()


# дальше будет CRUD

author1 = Author(name="Пушкин", birth_year=1799)
author2 = Author(name="Толстой", birth_year=1828 )
author3 = Author(name="Маяковский", birth_year=1893 )

session.add(author1)
session.commit()

session.add(author2)
session.commit()

session.add(author3)
session.commit()


book1 = Book(title="Евгений Онегин",year=1833,author_id=author1.id)
book2 = Book(title="Капитанская дочка",year=1836,author_id=author1.id)
book3 = Book(title="Война и мир",year=1869,author_id=author2.id)
book4 = Book(title="Анна Каренина",year=1877,author_id=author2.id)
book5 = Book(title="Облако в штанах",year=1915,author_id=author3.id)
session.add_all([
    book1,
    book2,
    book3,
    book4,
    book5
])
session.commit()

Base.metadata.create_all(engine)

authors = session.query(Author).all()
for a in authors:
    print(a.name, a.birth_year)
input("Далее")
author = session.query(Author).filter(Author.name == "Пушкин").first()
author.name = "Александр Пушкин"
session.commit()
input("Далее")
book = session.query(Book).filter(Book.title == "Анна Каренина").first()
session.delete(book)
session.commit()
input("Далее")
books = session.query(Book).order_by(Book.year.desc()).all()
for b in books:
    print(b.title, b.year)
input("Далее")
books = session.query(Book).filter(Book.year > 1950).all()
for b in books:
    print(b.title, b.year)
input("Далее")
author = session.query(Author).filter(Author.name == "Толстой").first()
print(author.name, author.birth_year)

input("Далее")
count = session.query(func.count(Book.id)).scalar()
print(count)
input("Далее")
books = session.query(Book).order_by(Book.title.asc()).limit(3).all()
for b in books:
    print(b.title)
input("Далее")
Base.metadata.drop_all(engine)