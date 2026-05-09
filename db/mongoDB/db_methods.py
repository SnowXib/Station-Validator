from .db_consts import (
    OBJECTS_COLLECTION,
    BROKER_CONF_COLLECTION,
    TESTS_COLLECTION,
    TESTS_RUN_COLLECTION,
    OBJECTS_TEST_COLLECTION,
)


def get_tests_run(station, db):
    collection = db[TESTS_RUN_COLLECTION]
    if station is not None:
        cursor = collection.find({"station": station}, {"_id": 0})
    else:
        cursor = collection.find({}, {"_id": 0})
    return list(cursor)


def get_tests_run_by_id(db, id_run=None):
    collection = db[TESTS_RUN_COLLECTION]
    return collection.find_one({"id": id_run}, {"_id": 0})


def update_tests_run(db, tests_run):
    collection = db[TESTS_RUN_COLLECTION]
    return collection.update_one(
        {"id": tests_run["id"]}, {"start_time": tests_run["start_time"]}
    )


def send_tests_run(test_run, db):
    collection = db[TESTS_RUN_COLLECTION]
    collection.insert_one(test_run)


def update_tests_results(test, db):
    """
    Обновление результатов тестов в MongoDB

    :param tests: Список тестов с обновленными полями (должны содержать _id для идентификации)
    :param db: база данных
    """
    collection = db[TESTS_COLLECTION]
    test_id = test.get("id")

    if not test_id:
        filter_query = {
            "name": test.get("name"),
            "station": test.get("station"),
            "time_start": {"$exists": False},
        }
    else:
        filter_query = {"id": test_id}

    update_data = {
        "$set": {"result": test.get("result"), "time_start": test.get("time_start")}
    }
    collection.update_one(filter_query, update_data)


def send_tests_cases(tests: list, db):
    """
    Сохранение тестов в монго

    :param tests: Тесты для сохранени
    :param db: база данных
    """
    collection = db[TESTS_COLLECTION]
    collection.insert_many(tests)


def get_tests_cases(station: list, count: int, db, object_name=None, id=None):
    """
    Получение тестов из монго

    :param station: имя станции
    :param db: бд
    """
    collection = db[TESTS_COLLECTION]
    if object_name is not None:
        cursor = collection.find(
            {"station": station, "object_name": object_name}, {"_id": 0}
        )
    else:
        cursor = collection.find({"station": station}, {"_id": 0})

    if count:
        cursor = cursor.limit(count)
    return list(cursor)


def get_tests_by_ids_db(db, ids_list):
    """
    Получить несколько тестов по списку ID

    :param db: база данных
    :param ids_list: список ID тестов
    :return: список найденных тестов
    """
    collection = db["tests"]
    cursor = collection.find({"id": {"$in": ids_list}}, {"_id": 0})
    return list(cursor)


def get_test_by_id(db, id_test):
    """
    Получение тестов из монго

    :param station: имя станции
    :param db: бд
    """
    collection = db[TESTS_COLLECTION]
    return collection.find_one({"id": id_test}, {"_id": 0})


def send_aggregating_objects(objects_types: list, db):
    """
    Сохранение объектов тестирования.
    Если объект с таким же 'type' уже существует - обновляет его,
    если нет - вставляет новый.

    :param objects_types: список объектов тестирования (каждый объект должен иметь поле 'type')
    :param db: база данных
    """
    collection = db[OBJECTS_COLLECTION]

    for obj in objects_types:
        if "type" not in obj:
            print(f"Предупреждение: объект {obj} не имеет поля 'type', пропускаем")
            continue

        collection.update_one({"type": obj["type"]}, {"$set": obj}, upsert=True)


def get_aggregation_objects(db, station: str, limit=None):
    """
    Получить агрегированные объекты

    :param db: база данных
    :param station: имя станции
    :param limit: количество объекты
    """
    collection = db[OBJECTS_COLLECTION]
    cursor = collection.find({"station": station}, {"_id": 0})
    if limit is not None:
        cursor = cursor.limit(limit)
    return list(cursor)


def send_object_test(db, test):
    collection = db[OBJECTS_TEST_COLLECTION]

    print(test)
    if test["test_type"] == "script":
        return

    object = {
        "name": test["object_name"],
        "station": test["station"],
        "variable": test["variable"],
        "value": test["value"],
        "result": test["result"],
    }

    collection.update_one(
        {
            "name": object["name"],
            "station": object["station"],
            "variable": object["variable"],
            "value": object["value"],
            "result": object["result"],
        },
        {"$set": object},
        upsert=True,
    )


def save_test_to_db(db, test_data):
    """
    Сохраняет новый тест в базу данных

    :param db: база данных
    :param test_data: данные теста
    """
    collection = db["tests"]
    collection.insert_one(test_data)


def get_objects_test(db, station):
    collection = db[OBJECTS_TEST_COLLECTION]
    return list(collection.find({"station": station}, {"_id": 0}))


def get_conf_broker(db, station: str) -> dict[str, str]:
    """
    Получение конфигурации брокера для указанной станции

    :param db: База данных
    :param station: Название станции
    :type station: str
    :return: Конфигурация брокера
    :rtype: dict[str, str]
    """
    collection = db[BROKER_CONF_COLLECTION]
    conf = collection.find_one({"station": station})
    return conf if conf else {}


def send_conf_broker(db, station: str, broker_conf: dict[str, str]):
    """
    Сохранение конфигурации брокера для указанной станции

    :param db: База данных
    :param station: Название станции
    :type station: str
    :param broker_conf: Конфигурация брокера
    :type broker_conf: dict[str, str]
    """
    collection = db[BROKER_CONF_COLLECTION]
    collection.replace_one({"station": station}, broker_conf, upsert=True)


def drop_tests_collection(db):
    """
    Полное удаление коллекции TESTS_COLLECTION

    :param db: база данных
    :return: True если коллекция существовала и была удалена, False если коллекции не существовало
    """
    collection = db[TESTS_COLLECTION]

    if TESTS_COLLECTION in db.list_collection_names():
        collection.drop()
        return True
    else:
        return False
