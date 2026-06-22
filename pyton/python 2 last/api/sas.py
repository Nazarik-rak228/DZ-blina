import requests
import sys

API_KEY="37b217ab3e8c4a4cadc05f3b45abb090"

def news(query="python",language="ru",page_size=10):
    url="https://newsapi.org/v2/everything"
    params={
        "q":query,
        "language":language,
        "sortBy":"publishedAt",
        "pageSize":page_size,
        "apiKey":API_KEY,
    }
    try:
        response=requests.get(url,params=params,timeout=10)
        response.raise_for_status()
        data=response.json()
        if data["status"] !="ok":
            print(f"Ошибка API {data('message',"Неизвестная ошибка")}")
            return None
        return data["articles"]
    except requests.exceptions.RequestException as e:
        print(f"Ошибка http {e}")
        return None
def main():
    if len(sys.argv)>1:
        query= " ".join(sys.argv[1:])
    else:
        query=input("введите тнему для поиска ").strip()
        if not query:
            query="python"
    print(f"Ищем новости по запросу {query}")
    
    articles=news(query=query,language="ru",page_size=5)
    
    if not articles:
        print("Новости не найдены или произошла ошибка")
        return
    print(f"Найдено статей {len(articles)}\n")
    
    for i,article in enumerate(articles,start=1):
        title=article.get("title","Без название")
        description=article.get("description","Описание отсутствует")
        url=article.get("url","*")
        published=article.get("publishedAt","Дата неизвестна")

        print(f"{i}. {title}")
        print(f"   Дата: {published[:10]}")
        print(f"   Описание: {description[:120]}{'...' if len(description) > 120 else ''}")
        print(f"   Ссылка: {url}\n")

main()