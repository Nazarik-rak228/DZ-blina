# # синфронное проганье
# import time;
# print("Начало процесса")
# time.sleep(5)
# print("ПРошло 5 секунд")
# print("Конец") 
# имитируем процесс загрузки из интернета
# import requests; 
# resp = requests.get("https://avatars.mds.yandex.net/i?id=c7c6991858bb18f1a632d724adc6d16c9c68c5ef-5694883-images-thumbs&n=13")
# print("первая картинка")
# resp2 = requests.get("https://avatars.mds.yandex.net/i?id=c7c6991858bb18f1a632d724adc6d16c9c68c5ef-5694883-images-thumbs&n=13")
# print("Вторая картинка")
# print("Готово")


# минусы синхронного - ждем 30 минут у телефона пока пиццу не привезут, типо, процесс одир - ждать, и процесс идет до конца, плохо
#В асиехронном можно просто заказать, ибо висение на трубке не требуется после заказа 


# import asyncio #  ДОБАВЛЯЕМ АСИНХРОННОСТЬ 
# async def say_hello():
#     print("Привет")
#     await asyncio.sleep(1)
#     print("Мир")
# async def main():
#     task1 = asyncio.create_task(say_hello())
#     task2 = asyncio.create_task(say_hello())
#     await task1
#     await task2

# asyncio.run(main())
import asyncio

# import aiohttp
# async def download(session, url,name):
#     print("Start download"+ url)
#     async with session.get(url) as response:
#         image = await response.read()
#         print("Download complate"+ name)
#         return image
# async def main():
#     async with aiohttp.ClientSession as session:
#         task1 = download(session,"https://avatars.mds.yandex.net/i?id=b390f1e88eb8f3a82cf94c025f9db0fb2d2f2eac-5232021-images-thumbs&n=13","Cartinca")
#         task2 = download(session,"https://avatars.mds.yandex.net/i?id=b390f1e88eb8f3a82cf94c025f9db0fb2d2f2eac-5232021-images-thumbs&n=13","Cartinca")
#         task3 = download(session,"https://avatars.mds.yandex.net/i?id=b390f1e88eb8f3a82cf94c025f9db0fb2d2f2eac-5232021-images-thumbs&n=13","Cartinca")

#     await asyncio.gather(task1,task2,task3)

# asyncio.run(main())
        # пока грузится - мы можем спокойно жить ,делать че то 

# поток - диния выполнения процесса
# процесс - программа которая что  то выполняет 
# асинхронность 0 один поток на несколько задачь
# создаем паток
# import threading
# import time
# def vorker():
#     print("НАчали работу")
#     time.sleep(3)
#     print("закончили")

# print ("главная прогамма")
# t = threading.Thread(target=vorker)
# print("запускаем поток")
# t.start()
# print("Ожидание завершения ")
# t.join()
# print("харе ждать")
# # тут два потока, в одном выполняется воркер, а другой создаем 

# def coffe():
#     print("готовим кофе")
#     time.sleep(3)
#     print("все")


# def cook_eg():
#     print("готовим яйца")
#     time.sleep(3)
#     print("все")

# t1 = threading.Thread(target=vorker)    
# t2 = threading.Thread(target=vorker)
# t1.start()
# t2.start()
# t1.join()
# t2.join() джоин говорит - подожди пока поток закончит работу, потом выполняется часть кода ниже

# нахрена потоки - для хзапросов к сайтам, просмотра, задержки. обращению к БД



# #пример где не надо поток
# import threading
# import time
# def une():
#     count=0
#     for i in range(20_000_000):
#         count+=1
# start = time.time()
# une()
# end = time.time()
# print("один поток",round(end-start,2),"sec")



#  сейчас где реально нужен поток, может быть поможет
import time
import threading

# def downl(): 
#     print("Начать загрузку ")
#     time.sleep(2)
#     print("окончено ")
# st = time.time()
# downl()
# en = time.time()
# threads = []
# for i in range(3):
#     t = threading.Thread(target=downl(), args=("fail"))
#     t.start()
#     threads.append(t)
# for i in threads:
#     t.join()
# end = time.time()
# print(f"All time {round(end-st,2)} second" )



# # тут теперь про гонку поговорим:
# count=0
# lock = threading.Lock()
# def f():
#     global count
#     for i in range(20_000):
# #         with lock:
#                 count+=1

# t1=threading.Thread(target=f())
# t2=threading.Thread(target=f())
# t1.start()
# t2.start()
# t1.join()
# t2.join()

import socket
clients=[]    
client_lock=threading.Lock()
# создаем клиент серверное прил, сначало сервер делаем
def hand_server(cliet_socket, client_addres):
    print(f"Подключился:{client_addres}")
    try:
        hello=" Вы подключены к общему чату! exit - для выхода"
        cliet_socket.send(hello.encode("utf-8"))
        forwarding(f"К нам пришел : {client_addres} ",cliet_socket)

        while True:
            data = cliet_socket.recv(1024)
            if not data:          # клиент отключился
                break
            message = data.decode("utf-8")
            print(f"от клиента{client_addres} , {message}")

            forwarding(message,cliet_socket)
    except ConnectionResetError:
        pass
    except Exception as e:
        print(f"Ошибка с клиентом {client_addres}: {e}")
# комменты не везде робят, кал просто с отключением - отключился клиент - все легло
    finally:
        
        with client_lock:
            if cliet_socket in clients:
                clients.remove(cliet_socket)
        try:
            cliet_socket.close()
        except:
            pass
        print(f"Клиент отключился: {client_addres}")
        forwarding(f"Нас покинул {client_addres}")
    # функция рассылки сообщений
def forwarding(message,sender_socket):
    with client_lock:
         for client in clients:
              if client != sender_socket:
                    try:
                        client.send(message.encode("utf-8"))
                    except:
                        try:
                            client.close()
                        except:
                            pass
                        if client in clients:
                            clients.remove(client)
# --------------------------------------- Старт сервера ---------------------------------------
server_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
server_socket.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
server_socket.bind(("127.0.0.1", 5000))
server_socket.listen()
print("сервер запущен, ждем клиента")

while True:
    try:
        cliet_socket, client_addres = server_socket.accept()
        print(f"Accept прошёл: {client_addres}")
        with client_lock:
            clients.append(cliet_socket)
        
        thread = threading.Thread(target=hand_server, args=(cliet_socket, client_addres), daemon=True)
        thread.start()
        print(f"Поток запущен для {client_addres}")
        
    # except KeyboardInterrupt:
    #     print(" Сервер остановлен (Ctrl+C)")
    #     break
    except Exception as e:
        print("Ошибка:", e)
        # break
        continue
server_socket.close()
print("сервер закрыт")