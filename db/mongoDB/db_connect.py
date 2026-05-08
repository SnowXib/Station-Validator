from pymongo import MongoClient
from colorama import Fore, Style


def mongo_connect(mongo_uri: str, mongo_name: str):
    """
    Коннектер к монгодб

    :param mongo_uri: URI для монго
    :type mongo_uri: str
    :param mongo_name: Имя базы данных
    :type mongo_name: str
    """
    print(f"{Fore.GREEN}INFO:{Style.RESET_ALL} Подсоединение к MongoDB")

    try:
        client = MongoClient(mongo_uri)

        client.admin.command("ping")
        print(
            f"{Fore.LIGHTGREEN_EX}STEP:{Style.RESET_ALL} Успешное подключение к mongo c URI:{mongo_uri}"
        )

        db = client[mongo_name]

        return client, db

    except Exception as e:
        print(f"Ошибка подключения к MongoDB: {str(e)}")
        return None, None
