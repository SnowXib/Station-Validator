import random

from typing import Generator, Any

from datetime import datetime


def simple_test_generator(
    objects: list, test_run_id: str
) -> Generator[dict[str, Any], None, None]:
    """
    Генерация простого теста

    :param objects: объекты станции
    :type objects: list
    :return: тест
    :rtype: Generator[dict[str, Any], None, None]
    """
    all_types = [station_object["type"] for station_object in objects]
    type_for_test = random.choice(all_types)

    obj_for_test = {}
    for obj_for_test in objects:
        if obj_for_test["type"] == type_for_test:
            break

    object_for_test = random.choice(obj_for_test["objects"])

    variable_for_test = random.choice(list(obj_for_test["variables"].keys()))

    value_for_test = random.choice(obj_for_test["variables"][variable_for_test])
    while value_for_test["value"] == "UNDEF":
        value_for_test = random.choice(obj_for_test["variables"][variable_for_test])

    value_for_setup = random.choice(obj_for_test["variables"][variable_for_test])
    while True:
        value_for_setup = random.choice(obj_for_test["variables"][variable_for_test])
        if (
            value_for_setup["value"] != "UNDEF"
            and value_for_setup["value"] != value_for_test["value"]
        ):
            print("value_for_setup", value_for_setup)
            print("value_for_test", value_for_test)
            break

    wait_seconds = random.uniform(2, 5)

    test = {
        "id": f"{obj_for_test['station']}_simple_{type_for_test}_{object_for_test}_{datetime.now().timestamp()}",
        "station": obj_for_test["station"],
        "test_run_id": test_run_id,
        "test_type": "simple",
        "type": type_for_test,
        "object_name": object_for_test,
        "variable": variable_for_test,
        "value": value_for_test["value"],
        "description": value_for_test["description"],
        "value_for_setup": value_for_setup["value"],
        "time_start": "",
        "info": "",
        "test_interval": random.uniform(wait_seconds, 10),
        "wait_seconds": wait_seconds,
        "result": "generated",
    }

    yield test


def script_test_generator(
    objects: list, test_run_id: id
) -> Generator[dict[str, Any], None, None]:
    """
    Генерация сложного теста

    :param objects: Описание
    :type objects: list
    :return: Описание
    :rtype: Generator[dict[str, Any], None, None]
    """
    count_of_test = random.randint(2, 5)
    wait_seconds = random.uniform(count_of_test, 30)
    tests = []

    for _ in range(count_of_test):
        test = next(simple_test_generator(objects, test_run_id))
        tests.append(
            {
                "object_name": test["object_name"],
                "variable": test["variable"],
                "value": test["value"],
                "value_for_setup": test["value_for_setup"],
                "description": test["description"],
                "test_interval": random.uniform(0.1, 1),
                "wait_seconds": random.uniform(1, wait_seconds / count_of_test),
                "time_start": "",
            }
        )

    test = {
        "id": f"{objects[0]['station']}_scripts_{len(tests)}_{datetime.now().timestamp()}",
        "station": objects[0]["station"],
        "test_run_id": test_run_id,
        "test_type": "script",
        "tests": tests,
        "count_of_test": len(tests),
        "time_start": "",
        "info": "",
        "test_interval": random.uniform(0.1, wait_seconds),
        "wait_seconds": wait_seconds,
        "result": "generated",
    }

    yield test


def generate_normalized_percentage(count_of_tests: int) -> int:
    """
    Генерация количества скриптовых тестов на основе нормального распределения

    :param objects: Описание
    :type objects: list
    :return: Описание
    :rtype: Generator[dict[str, Any], None, None]
    """
    min_percent = 0.10
    max_percent = 0.30
    mean_percent = 0.20
    std_percent = (max_percent - mean_percent) / 3

    percent = random.gauss(mean_percent, std_percent)

    percent = max(min_percent, min(max_percent, percent))

    result = int(percent * count_of_tests)

    return max(1, result)
