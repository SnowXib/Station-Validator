import sys
import os

sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

import pytest
from unittest.mock import Mock
from datetime import datetime

from db.mongoDB.db_methods import (
    get_tests_run,
    get_tests_run_by_id,
    update_tests_run,
    send_tests_run,
    update_tests_results,
    get_test_by_id,
    send_tests_cases,
    get_tests_cases,
    get_tests_by_ids_db,
    send_aggregating_objects,
    get_aggregation_objects,
    send_object_test,
    save_test_to_db,
    get_objects_test,
    get_conf_broker,
    send_conf_broker,
    drop_tests_collection,
)


@pytest.fixture
def mock_db():
    """Создает мок базы данных"""
    db = Mock()
    db.__getitem__ = Mock()
    return db


@pytest.fixture
def mock_collection():
    """Создает мок коллекции"""
    collection = Mock()
    collection.find = Mock()
    collection.find_one = Mock()
    collection.insert_one = Mock()
    collection.insert_many = Mock()
    collection.update_one = Mock()
    collection.replace_one = Mock()
    collection.drop = Mock()
    return collection


@pytest.fixture
def sample_test():
    """Образец теста"""
    return {
        "id": "test_001",
        "name": "CPU Test",
        "station": "StationA",
        "object_name": "CPU1",
        "variable": "temperature",
        "value": 75,
        "value_for_setup": 70,
        "test_type": "simple",
        "result": "NOT_STARTED",
        "time_start": None,
    }


@pytest.fixture
def sample_tests_run():
    """Образец запуска тестов"""
    return {
        "id": "run_001",
        "station": "StationA",
        "start_time": datetime.now().isoformat(),
        "status": "running",
    }


def test_get_tests_run_with_station(mock_db, mock_collection):
    """Тест получения запусков тестов для конкретной станции"""
    mock_db.__getitem__.return_value = mock_collection
    expected_runs = [
        {"id": "run_001", "station": "StationA"},
        {"id": "run_002", "station": "StationA"},
    ]
    mock_collection.find.return_value = expected_runs

    result = get_tests_run("StationA", mock_db)

    assert result == expected_runs
    mock_collection.find.assert_called_once_with({"station": "StationA"}, {"_id": 0})


def test_get_tests_run_without_station(mock_db, mock_collection):
    """Тест получения всех запусков тестов"""
    mock_db.__getitem__.return_value = mock_collection
    expected_runs = [
        {"id": "run_001", "station": "StationA"},
        {"id": "run_002", "station": "StationB"},
    ]
    mock_collection.find.return_value = expected_runs

    result = get_tests_run(None, mock_db)

    assert result == expected_runs
    mock_collection.find.assert_called_once_with({}, {"_id": 0})


def test_get_tests_run_by_id_found(mock_db, mock_collection):
    """Тест получения запуска теста по ID (найден)"""
    mock_db.__getitem__.return_value = mock_collection
    expected_run = {"id": "run_001", "station": "StationA", "status": "running"}
    mock_collection.find_one.return_value = expected_run

    result = get_tests_run_by_id(mock_db, "run_001")

    assert result == expected_run
    mock_collection.find_one.assert_called_once_with({"id": "run_001"}, {"_id": 0})


def test_get_tests_run_by_id_not_found(mock_db, mock_collection):
    """Тест получения запуска теста по ID (не найден)"""
    mock_db.__getitem__.return_value = mock_collection
    mock_collection.find_one.return_value = None

    result = get_tests_run_by_id(mock_db, "non_existent")

    assert result is None


def test_update_tests_run(mock_db, mock_collection, sample_tests_run):
    """Тест обновления запуска теста"""
    mock_db.__getitem__.return_value = mock_collection
    mock_update_result = Mock()
    mock_update_result.modified_count = 1
    mock_collection.update_one.return_value = mock_update_result

    result = update_tests_run(mock_db, sample_tests_run)

    assert result == mock_update_result
    mock_collection.update_one.assert_called_once_with(
        {"id": sample_tests_run["id"]}, {"start_time": sample_tests_run["start_time"]}
    )


def test_send_tests_run(mock_db, mock_collection, sample_tests_run):
    """Тест сохранения запуска теста"""
    mock_db.__getitem__.return_value = mock_collection

    send_tests_run(sample_tests_run, mock_db)

    mock_collection.insert_one.assert_called_once_with(sample_tests_run)


def test_update_tests_results_with_id(mock_db, mock_collection, sample_test):
    """Тест обновления результатов теста по ID"""
    mock_db.__getitem__.return_value = mock_collection
    sample_test["result"] = "VALID"
    sample_test["time_start"] = datetime.now().isoformat()

    update_tests_results(sample_test, mock_db)

    mock_collection.update_one.assert_called_once()
    call_args = mock_collection.update_one.call_args[0][0]
    assert call_args == {"id": sample_test["id"]}


def test_update_tests_results_without_id(mock_db, mock_collection):
    """Тест обновления результатов теста без ID (по имени и станции)"""
    mock_db.__getitem__.return_value = mock_collection
    test = {
        "name": "Test Name",
        "station": "StationA",
        "result": "VALID",
        "time_start": datetime.now().isoformat(),
    }

    update_tests_results(test, mock_db)

    expected_filter = {
        "name": test["name"],
        "station": test["station"],
        "time_start": {"$exists": False},
    }
    mock_collection.update_one.assert_called_once()
    call_filter = mock_collection.update_one.call_args[0][0]
    assert call_filter == expected_filter


def test_get_test_by_id_found(mock_db, mock_collection, sample_test):
    """Тест получения теста по ID (найден)"""
    mock_db.__getitem__.return_value = mock_collection
    mock_collection.find_one.return_value = sample_test

    result = get_test_by_id(mock_db, "test_001")

    assert result == sample_test
    mock_collection.find_one.assert_called_once_with({"id": "test_001"}, {"_id": 0})


def test_get_test_by_id_not_found(mock_db, mock_collection):
    """Тест получения теста по ID (не найден)"""
    mock_db.__getitem__.return_value = mock_collection
    mock_collection.find_one.return_value = None

    result = get_test_by_id(mock_db, "non_existent")

    assert result is None


def test_send_tests_cases(mock_db, mock_collection):
    """Тест сохранения нескольких тестов"""
    mock_db.__getitem__.return_value = mock_collection
    tests = [{"id": "test_001", "name": "Test1"}, {"id": "test_002", "name": "Test2"}]

    send_tests_cases(tests, mock_db)

    mock_collection.insert_many.assert_called_once_with(tests)


def test_get_tests_cases_with_count_limit(mock_db, mock_collection):
    mock_db.__getitem__.return_value = mock_collection
    expected_tests = [{"id": "test_001"}, {"id": "test_002"}]
    mock_cursor = Mock()
    mock_cursor.limit.return_value = expected_tests
    mock_collection.find.return_value = mock_cursor

    result = get_tests_cases("StationA", 2, mock_db)

    assert result == expected_tests
    mock_cursor.limit.assert_called_once_with(2)


def test_get_tests_by_ids_db(mock_db, mock_collection):
    """Тест получения тестов по списку ID"""
    mock_db.__getitem__.return_value = mock_collection
    ids_list = ["test_001", "test_002", "test_003"]
    expected_tests = [
        {"id": "test_001", "name": "Test1"},
        {"id": "test_002", "name": "Test2"},
        {"id": "test_003", "name": "Test3"},
    ]
    mock_collection.find.return_value = expected_tests

    result = get_tests_by_ids_db(mock_db, ids_list)

    assert result == expected_tests
    mock_collection.find.assert_called_once_with({"id": {"$in": ids_list}}, {"_id": 0})


def test_send_aggregating_objects(mock_db, mock_collection):
    """Тест сохранения агрегированных объектов"""
    mock_db.__getitem__.return_value = mock_collection
    objects = [
        {"type": "CPU", "name": "CPU1", "station": "StationA"},
        {"type": "Memory", "name": "MEM1", "station": "StationA"},
    ]

    send_aggregating_objects(objects, mock_db)

    assert mock_collection.update_one.call_count == 2
    for obj in objects:
        mock_collection.update_one.assert_any_call(
            {"type": obj["type"]}, {"$set": obj}, upsert=True
        )


def test_send_aggregating_objects_without_type(mock_db, mock_collection):
    """Тест сохранения объектов без поля type (должен пропустить)"""
    mock_db.__getitem__.return_value = mock_collection
    objects = [
        {"type": "CPU", "name": "CPU1"},
        {"name": "Invalid", "station": "StationA"},
    ]

    send_aggregating_objects(objects, mock_db)

    assert mock_collection.update_one.call_count == 1


def test_get_aggregation_objects_with_limit(mock_db, mock_collection):
    """Тест получения агрегированных объектов с лимитом"""
    mock_db.__getitem__.return_value = mock_collection
    expected_objects = [
        {"type": "CPU", "name": "CPU1"},
        {"type": "CPU", "name": "CPU2"},
    ]
    mock_cursor = Mock()
    mock_cursor.limit.return_value = expected_objects
    mock_collection.find.return_value = mock_cursor

    result = get_aggregation_objects(mock_db, "StationA", limit=2)

    assert result == expected_objects
    mock_cursor.limit.assert_called_once_with(2)


def test_get_aggregation_objects_without_limit(mock_db, mock_collection):
    """Тест получения агрегированных объектов без лимита"""
    mock_db.__getitem__.return_value = mock_collection
    expected_objects = [
        {"type": "CPU", "name": "CPU1"},
        {"type": "Memory", "name": "MEM1"},
    ]
    mock_collection.find.return_value = expected_objects

    result = get_aggregation_objects(mock_db, "StationA")

    assert result == expected_objects
    mock_collection.find.assert_called_once_with({"station": "StationA"}, {"_id": 0})
    assert not hasattr(expected_objects, "limit")


def test_send_object_test_simple(mock_db, mock_collection):
    """Тест сохранения объекта теста (simple тип)"""
    mock_db.__getitem__.return_value = mock_collection
    test = {
        "test_type": "simple",
        "object_name": "CPU1",
        "station": "StationA",
        "variable": "temperature",
        "value": 75,
        "result": "VALID",
    }

    send_object_test(mock_db, test)

    expected_object = {
        "name": test["object_name"],
        "station": test["station"],
        "variable": test["variable"],
        "value": test["value"],
        "result": test["result"],
    }

    mock_collection.update_one.assert_called_once_with(
        {
            "name": expected_object["name"],
            "station": expected_object["station"],
            "variable": expected_object["variable"],
            "value": expected_object["value"],
            "result": expected_object["result"],
        },
        {"$set": expected_object},
        upsert=True,
    )


def test_send_object_test_script(mock_db, mock_collection):
    """Тест: для script типа не должно быть сохранения"""
    mock_db.__getitem__.return_value = mock_collection
    test = {
        "test_type": "script",
        "object_name": "CPU1",
        "station": "StationA",
        "result": "VALID",
    }

    send_object_test(mock_db, test)

    mock_collection.update_one.assert_not_called()


def test_save_test_to_db(mock_db, mock_collection, sample_test):
    """Тест сохранения нового теста в БД"""
    mock_db.__getitem__.return_value = mock_collection

    save_test_to_db(mock_db, sample_test)

    mock_collection.insert_one.assert_called_once_with(sample_test)


def test_get_objects_test(mock_db, mock_collection):
    """Тест получения объектов тестирования"""
    mock_db.__getitem__.return_value = mock_collection
    expected_objects = [
        {"name": "CPU1", "station": "StationA", "variable": "temp", "result": "VALID"},
        {
            "name": "CPU2",
            "station": "StationA",
            "variable": "temp",
            "result": "INVALID",
        },
    ]
    mock_collection.find.return_value = expected_objects

    result = get_objects_test(mock_db, "StationA")

    assert result == expected_objects
    mock_collection.find.assert_called_once_with({"station": "StationA"}, {"_id": 0})


def test_get_conf_broker_found(mock_db, mock_collection):
    """Тест получения конфигурации брокера (найдена)"""
    mock_db.__getitem__.return_value = mock_collection
    expected_conf = {"station": "StationA", "host": "localhost", "port": 1883}
    mock_collection.find_one.return_value = expected_conf

    result = get_conf_broker(mock_db, "StationA")

    assert result == expected_conf
    mock_collection.find_one.assert_called_once_with({"station": "StationA"})


def test_get_conf_broker_not_found(mock_db, mock_collection):
    """Тест получения конфигурации брокера (не найдена)"""
    mock_db.__getitem__.return_value = mock_collection
    mock_collection.find_one.return_value = None

    result = get_conf_broker(mock_db, "StationA")

    assert result == {}
    mock_collection.find_one.assert_called_once_with({"station": "StationA"})


def test_send_conf_broker(mock_db, mock_collection):
    """Тест сохранения конфигурации брокера"""
    mock_db.__getitem__.return_value = mock_collection
    broker_conf = {"station": "StationA", "host": "localhost", "port": 1883}

    send_conf_broker(mock_db, "StationA", broker_conf)

    mock_collection.replace_one.assert_called_once_with(
        {"station": "StationA"}, broker_conf, upsert=True
    )


def test_drop_tests_collection_exists(mock_db, mock_collection):
    """Тест удаления коллекции тестов (коллекция существует)"""
    mock_db.__getitem__.return_value = mock_collection
    mock_db.list_collection_names.return_value = ["tests", "objects", "runs"]

    result = drop_tests_collection(mock_db)

    assert result is True
    mock_collection.drop.assert_called_once()


def test_drop_tests_collection_not_exists(mock_db, mock_collection):
    """Тест удаления коллекции тестов (коллекция не существует)"""
    mock_db.__getitem__.return_value = mock_collection
    mock_db.list_collection_names.return_value = ["objects", "runs"]

    result = drop_tests_collection(mock_db)

    assert result is False
    mock_collection.drop.assert_not_called()


def test_update_tests_results_missing_fields(mock_db, mock_collection):
    """Тест обновления результатов с отсутствующими полями"""
    mock_db.__getitem__.return_value = mock_collection
    test = {"result": "VALID"}

    update_tests_results(test, mock_db)

    mock_collection.update_one.assert_called_once()


def test_send_aggregating_objects_empty_list(mock_db, mock_collection):
    """Тест сохранения пустого списка объектов"""
    mock_db.__getitem__.return_value = mock_collection

    send_aggregating_objects([], mock_db)

    mock_collection.update_one.assert_not_called()


def test_get_tests_by_ids_db_empty_list(mock_db, mock_collection):
    """Тест получения тестов по пустому списку ID"""
    mock_db.__getitem__.return_value = mock_collection
    mock_collection.find.return_value = []

    result = get_tests_by_ids_db(mock_db, [])

    assert result == []
    mock_collection.find.assert_called_once_with({"id": {"$in": []}}, {"_id": 0})
