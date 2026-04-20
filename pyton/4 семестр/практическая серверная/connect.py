import socket
import threading
import time
# надо короче функция чтения и отправки, и будет просто два потока, чтобы одновременно
# получать будем функцией, чисто копиппаст с сервера как там сообщения идут
def readMessage(all_socket):
    while True:
        try:
            data = all_socket.recv(1024)
            if not data:
                print("Отключено!")
                break
            print("\n"+ data.decode("utf-8"))
        except ConnectionResetError:
            print("\nСервер разорвал соединение.")
            break
        except Exception:
            print("\nСоединение прервано!")
            break

"коменты оказывается можно писать чимсто в кавычках, я столько раз переключался на анг чтобы шарп ставит..."
#тут короче будем отправлять 
def sendMessage(all_socket):
    while True:  
        msg = input("введи сообшение : ")
        if msg.lower() in [ "exit"]:
                print("Выходим из чата...")
                break
        all_socket.send(msg.encode("utf-8"))
" --------------------------------------------------------------------- подключение к серверу --------------------------------------------------------------------- "
cliet_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
try:
    cliet_socket.connect(("127.0.0.1", 5000))
    print("Подключились к серверу!")
except Exception as e:
    print("Ошибка подключения:", e)
    exit()

readThread = threading.Thread(target=readMessage, args=(cliet_socket,),daemon=True) 
""" запомни придурок, тут всегда дожна быть запятая                 ↑   """
sendThread = threading.Thread(target=sendMessage,args=(cliet_socket,),daemon=False)
readThread.start()
sendThread.start()
" хз короче как, но чтобы не вылетало все при закрытии одного клиента должно помочь это"
try:
    sendThread.join()      
except KeyboardInterrupt:
    print("\nВыход из чата (Ctrl + C)")



cliet_socket.close()