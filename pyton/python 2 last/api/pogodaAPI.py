import requests
import sys
import os
# from dotenv import load_dotenv
# load_dotenv() 
# API_KEY = os.getenv("API_KEY")
API_KEY="34f4430e5b572d713cd9fd95a52c4088"
FIND_URL = "http://api.openweathermap.org/geo/1.0/direct"
URL ="https://api.openweathermap.org/data/2.5/weather"
def getPosition(city="Moscow"):
    params={
        "q": city,
        "limit":1,
        "appid":API_KEY
    }
    
    response = requests.get(url=FIND_URL, params=params)
    if response.status_code == 401:
        print("Ошибка: неверный API ключ")
        return None
    response.raise_for_status()
    data2 = response.json()
    if not data2:
        print("Ошибка: город не найден  ")
        return None
    else:
        return data2[0]["lat"], data2[0]["lon"]


def news(find="Moscow",language="ru"):
    url=URL
    coord  = getPosition(find)
    if coord is None:
        print("Ошибка координат")
        return None
    else:
        lat = coord[0]
        lot = coord[1]
    
    params={
        "lat":lat,
        "lon":lot,
        "lang":language,
        "appid":API_KEY,
        "units": "metric"
    }
    try:
        response=requests.get(url,params=params,timeout=5)
        
        if response.status_code == 401:
            print("Ошибка: неверный API ключ")
            return None

        if response.status_code == 404:
            print("Ошибка: город не найден")
            return None
        response.raise_for_status()
        data=response.json()
        if "weather" not in data:   
            print("Ошибка API")
            return None
        return data
    except requests.exceptions.Timeout as e:
        print("Слишком медленное подключение к интернету")
        return None
    except requests.exceptions.RequestException as e:
        print(f"Ошибка http {e}")
        return None
def main():
    if len(sys.argv)>1:
        query= " ".join(sys.argv[1:])
    else:
        query=input("введите тнему для поиска ").strip()
        if not query:
            query="Moscow"
        
    print(f"Ищем погоду по запросу {query}")
    
    weather=news(find=query,language="ru")
    
    if weather is None:
        print("Новости не найдены или произошла ошибка")
        return
    
    print(f"   Город   : {query}")
    print(f"   Описание: {weather['weather'][0]['description']}")  
    print(f"   Погода: {weather['main']['temp']}°C")        

main()