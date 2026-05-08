import sys
import os

sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

from unittest.mock import patch, MagicMock
import pytest
from tests_generator.agregator import get_objects


@pytest.fixture
def mock_get_aggregation_objects():
    with patch("tests_generator.agregator.get_aggregation_objects") as mock:
        yield mock


def test_empty_objects(mock_get_aggregation_objects):
    db = MagicMock()
    station = "StationA"
    mock_get_aggregation_objects.return_value = []

    result = get_objects(db, station)

    mock_get_aggregation_objects.assert_called_once_with(db, station)
    assert result == []


def test_objects_is_none(mock_get_aggregation_objects):
    db = MagicMock()
    station = "StationA"
    mock_get_aggregation_objects.return_value = None

    result = get_objects(db, station)

    mock_get_aggregation_objects.assert_called_once_with(db, station)
    assert result == []


def test_single_object_with_all_fields(mock_get_aggregation_objects):
    db = MagicMock()
    station = "StationA"
    objects = [
        {
            "type": "sensor",
            "objects": ["obj1", "obj2", "obj3"],
            "variables": {
                "temperature": [
                    {"value": 25, "description": "Температура в градусах"},
                    {"value": 30, "description": "Высокая температура"},
                ],
                "humidity": [{"value": 60, "description": "Влажность"}],
            },
        }
    ]
    mock_get_aggregation_objects.return_value = objects

    result = get_objects(db, station)

    assert len(result) == 1
    obj = result[0]
    assert obj["type"] == "sensor"
    assert obj["_meta"]["count"] == 3
    assert obj["_meta"]["variables_count"] == 2
    assert set(obj["_meta"]["variable_names"]) == {"temperature", "humidity"}
    assert obj["_summary"]["default_variable"] == "temperature"
    assert obj["_summary"]["default_value"] == 25
    assert obj["_summary"]["default_description"] == "Температура в градусах"


def test_object_without_variables(mock_get_aggregation_objects):
    db = MagicMock()
    station = "StationA"
    objects = [{"type": "actuator", "objects": ["act1", "act2"], "variables": {}}]
    mock_get_aggregation_objects.return_value = objects

    result = get_objects(db, station)

    assert len(result) == 1
    obj = result[0]
    assert obj["type"] == "actuator"
    assert obj["_meta"]["count"] == 2
    assert obj["_meta"]["variables_count"] == 0
    assert "_summary" not in obj


def test_object_without_objects_and_variables(mock_get_aggregation_objects):
    db = MagicMock()
    station = "StationA"
    objects = [{"type": "unknown_type"}]
    mock_get_aggregation_objects.return_value = objects

    result = get_objects(db, station)

    assert len(result) == 1
    obj = result[0]
    assert obj["type"] == "unknown_type"
    assert obj["_meta"]["count"] == 0
    assert obj["_meta"]["variables_count"] == 0
    assert "_summary" not in obj


def test_multiple_objects(mock_get_aggregation_objects):
    db = MagicMock()
    station = "StationA"
    objects = [
        {
            "type": "sensor",
            "objects": ["s1"],
            "variables": {"temp": [{"value": 20, "description": "Температура"}]},
        },
        {
            "type": "actuator",
            "objects": ["a1", "a2"],
            "variables": {"state": [{"value": "on", "description": "Включен"}]},
        },
    ]
    mock_get_aggregation_objects.return_value = objects

    result = get_objects(db, station)

    assert len(result) == 2
    assert result[0]["type"] == "sensor"
    assert result[0]["_meta"]["count"] == 1
    assert result[1]["type"] == "actuator"
    assert result[1]["_meta"]["count"] == 2


def test_variable_with_empty_values(mock_get_aggregation_objects):
    db = MagicMock()
    station = "StationA"
    objects = [{"type": "sensor", "objects": ["s1"], "variables": {"temp": []}}]
    mock_get_aggregation_objects.return_value = objects

    result = get_objects(db, station)

    assert len(result) == 1
    obj = result[0]
    assert obj["_meta"]["variables_count"] == 1
    assert "_summary" not in obj


def test_variable_without_value_and_description(mock_get_aggregation_objects):
    db = MagicMock()
    station = "StationA"
    objects = [{"type": "sensor", "objects": ["s1"], "variables": {"temp": [{}]}}]
    mock_get_aggregation_objects.return_value = objects

    result = get_objects(db, station)

    assert len(result) == 1
    obj = result[0]
    assert obj["_summary"]["default_value"] == "UNKNOWN"
    assert obj["_summary"]["default_description"] == "Нет данных"


def test_original_object_not_mutated(mock_get_aggregation_objects):
    db = MagicMock()
    station = "StationA"
    original_obj = {
        "type": "sensor",
        "objects": ["s1"],
        "variables": {"temp": [{"value": 20, "description": "Температура"}]},
    }
    objects = [original_obj]
    mock_get_aggregation_objects.return_value = objects

    result = get_objects(db, station)

    assert "_meta" not in original_obj
    assert "_summary" not in original_obj
    assert "_meta" in result[0]
