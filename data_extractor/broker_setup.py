import paho.mqtt.client as mqtt
from colorama import init, Fore, Style

from db.mongoDB.db_methods import get_conf_broker

def setup_broker(broker, port: int, username: str, password: str, db, station: str):
    """
    Настраивает и возвращает MQTT клиента
    
    :param broker: Брокер MQTT
    :param port: Порт
    :type port: int
    :param username: Имя пользователя
    :type username: str
    :param password: Пароль
    :type password: str
    :param db: База данных
    :param station: Название станции
    :type station: str
    """
    conf = get_conf_broker(db, station)
    if not conf:
        client = mqtt.Client()
        if username and password:
            client.username_pw_set(username, password)

        client.connect(broker, port, 60)
        print(f"{Fore.LIGHTGREEN_EX}STEP:{Style.RESET_ALL} Успешное подключение к брокеру: {broker}")
        return client
    
    client = mqtt.Client()
    
    conf_broker = conf.get('broker')
    conf_port = conf.get('port', port)
    conf_username = conf.get('username', username)
    conf_password = conf.get('password', password)
    
    if conf_username and conf_password and conf_broker:
        client.username_pw_set(conf_username, conf_password)
    
        client.connect(conf_broker, int(conf_port), 60)
        print(f"{Fore.LIGHTGREEN_EX}STEP:{Style.RESET_ALL} Успешное подключение к брокеру: {conf_broker}")

    
    return client