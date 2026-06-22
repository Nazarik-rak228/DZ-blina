import requests
import sys

API_KEY = "9453c45410ce418599757266e73ca4a4"
def news(query = "python", language = "ru", page_size = 5):
    url="https://newsapi.org/v2/everything"
    param = {
        "q":query,
        "sortBy":"publishedAt",
        "pageSize":page_size,
        "language": language
    }
    try:
        response = requests.get(url ,params= param, timeout=10) # без таймаута програ зависнет и набесконечно весеть, а так через 10 сек просто скажет фиг
        response.raise_for_status()
        data = response.json()
        
        if data("status") != "ok":
            print( F"ошибка апи {data.get('message', "неизвестно")}")
            return None
    
        return data["articles"]
    except requests.exceptions.RequestException as e:
        print(F"Erro http {e}")
        return None
def main():
    if len(sys.argv>1):
        query = " ".join(sys.argv[1:])
    else:
        query = input("Введите тему ").strip
        if not query:
            query="python"
    print("иЩЕМ")
    art = news(query = query, language = "ru", page_size = 5)

    if not art:
        print("нету")
        return
    print(F"найденно статей {len(art)}\n")
    for i,art in enumerate(art,start=1):
        title=art.get("title","njt name")
        description=art.get("description","not des")
        url=art.get("url","#")
        publishedAt=art.get("publishedAt", "data not faund")

        print(F"{i} , {title}")
        print(F"Data , {publishedAt[:10]}")
        print(F"desc , {description[:120] if len(description)> 120 else ''} ")
        print(F"url , {url}\n")
        