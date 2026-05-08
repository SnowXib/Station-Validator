import json
import os

from colorama import Fore, Style

from db.mongoDB.db_methods import send_aggregating_objects


def parsing_objects(objects_conf_path: str) -> list[dict[str, str]]:
    """
    Парсинг списка объектов

    :param objects_conf_path: Имя файла
    :type objects_conf_path: str
    :return: Список объектов в формате словаря с ключами имя, тип
    :rtype: list[dict[str, str]]
    """
    print(f"{Fore.BLUE}STEP:{Style.RESET_ALL} Парсинг списка объектов")

    with open(objects_conf_path, "r", encoding="utf-8") as file:
        objects_dict = json.load(file)

    object_list = [
        {"object": x["name"], "type": x["type"]} for x in objects_dict["items"]
    ]

    return object_list


def get_filenames(objects_path: str) -> list[str]:
    """
    Получение списка имен файлов объектов станции

    :param objects_path: директория с объектами
    :type objects_path: str
    :return: список названий файлов объектов
    :rtype: list[str]
    """
    print(
        f"{Fore.BLUE}STEP:{Style.RESET_ALL} Получение списка имен файлов объектов станции"
    )

    file_list = []

    if not os.path.isdir(objects_path):
        print(f"{Fore.BLACK}FATAL{Style.RESET_ALL}")
        raise ValueError(f"Указанный путь '{objects_path}' не является директорией")

    for filename in os.listdir(objects_path):
        full_path = os.path.join(objects_path, filename)

        if os.path.isfile(full_path):
            file_list.append(f"{objects_path}/{filename}")

    for file_name in file_list:
        if file_name.split(".")[-1] not in ["dm", "json"]:
            print(f"{Fore.BLACK}FATAL{Style.RESET_ALL}")
            raise ValueError(f"Файл {file_name} не является файлом объекта станции")

    return file_list


def parsing_object(object_file_path: str) -> dict[str, dict]:
    """
    Парсинг объекта по его пути

    :param object_file_path: путь до объекта
    :type object_file_path: str
    :return: словарь переменных и значений объекта
    :rtype: dict[str, dict[Any, Any]]
    """
    with open(object_file_path, "r", encoding="utf-8") as file:
        object = json.load(file)

    name = object["name"]
    result = {"type": name, "objects": [], "station": "", "variables": {}}

    print(f"{Fore.CYAN}MSG:{Style.RESET_ALL} Парсинг объекта {name}")

    for variable in object["variables"]:
        values = []
        for value in variable["values"]:
            values.append({"value": value["name"], "description": value["description"]})
        result["variables"][variable["name"]] = values

    return result


def add_objects_into_type(
    objects_types: list[dict], object_list: list, station_name: str
):
    """
    Добавление списка объектов в тип

    :param objects: Типы объектов
    :type objects: dict[str, dict]
    :param object_list: Список объектов
    :type object_list: list
    """
    for object_type in objects_types:
        for object in object_list:
            if object_type["type"] == object["type"]:
                object_type["objects"].append(object["object"])
                object_type["station"] = station_name


def save_to_file(objects: list[dict]):
    """
    Сохранение агрегированной информации в файл

    :param objects: Объекты станции
    :type objects: dict[str, dict]
    """
    with open("output.json", "w", encoding="utf-8") as file:
        json.dump(objects, file, ensure_ascii=False, indent=4)


def aggregation(objects_conf_path: str, objects_dir_path: str, station_name: str, db):
    """
    Агрегация объектов станции

    :param objects_conf_path: Путь до конфигурационного файла объектов станции
    :type objects_conf_path: str
    :param objects_dir_path: Директория типов объектов станции
    :type objects_dir_path: str
    """
    print(f"{Fore.GREEN}INFO:{Style.RESET_ALL} Начало функционального блока агрегации")

    object_list = parsing_objects(objects_conf_path)

    filenames = get_filenames(objects_dir_path)

    objects_types = list(map(parsing_object, filenames))

    add_objects_into_type(objects_types, object_list, station_name)

    save_to_file(objects_types)

    send_aggregating_objects(objects_types, db)
