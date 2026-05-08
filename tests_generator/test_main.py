import sys
import os
sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

from unittest.mock import patch, MagicMock, call
import pytest
from tests_generator.main import generator


@pytest.fixture
def mock_dependencies():
    with patch("tests_generator.main.get_objects") as mock_get_objects, \
         patch("tests_generator.main.generate_normalized_percentage") as mock_gen_perc, \
         patch("tests_generator.main.simple_test_generator") as mock_simple_gen, \
         patch("tests_generator.main.script_test_generator") as mock_script_gen, \
         patch("tests_generator.main.validate_json_schema") as mock_validate, \
         patch("tests_generator.main.send_tests_cases") as mock_send, \
         patch("tests_generator.main.get_simple_test_schema") as mock_get_simple_schema, \
         patch("tests_generator.main.get_script_test_schema") as mock_get_script_schema:
        yield {
            "get_objects": mock_get_objects,
            "gen_perc": mock_gen_perc,
            "simple_gen": mock_simple_gen,
            "script_gen": mock_script_gen,
            "validate": mock_validate,
            "send": mock_send,
            "simple_schema": mock_get_simple_schema,
            "script_schema": mock_get_script_schema,
        }


def test_happy_path(mock_dependencies):
    db = MagicMock()
    station = "StationA"
    count_of_tests = 5
    objects = ["obj1", "obj2"]
    count_of_script_tests = 2
    simple_tests_list = [{"type": "simple1"}, {"type": "simple2"}, {"type": "simple3"}]
    script_tests_list = [{"type": "script1"}, {"type": "script2"}]

    mock_dependencies["get_objects"].return_value = objects
    mock_dependencies["gen_perc"].return_value = count_of_script_tests

    simple_gen_instance = MagicMock()
    simple_gen_instance.__next__.side_effect = simple_tests_list
    mock_dependencies["simple_gen"].return_value = simple_gen_instance

    script_gen_instance = MagicMock()
    script_gen_instance.__next__.side_effect = script_tests_list
    mock_dependencies["script_gen"].return_value = script_gen_instance

    mock_dependencies["validate"].side_effect = [(True, None), (True, None)]
    mock_dependencies["simple_schema"].return_value = "simple_schema"
    mock_dependencies["script_schema"].return_value = "script_schema"

    generator(db, station, count_of_tests)

    mock_dependencies["get_objects"].assert_called_once_with(db, station)
    mock_dependencies["gen_perc"].assert_called_once_with(count_of_tests)
    assert mock_dependencies["simple_gen"].call_count == count_of_tests - count_of_script_tests
    assert mock_dependencies["script_gen"].call_count == count_of_script_tests
    mock_dependencies["validate"].assert_has_calls([
        call(simple_tests_list, "simple_schema"),
        call(script_tests_list, "script_schema")
    ])
    mock_dependencies["send"].assert_has_calls([
        call(simple_tests_list, db),
        call(script_tests_list, db)
    ])


def test_simple_validation_fails(mock_dependencies):
    db = MagicMock()
    station = "StationA"
    count_of_tests = 3
    objects = ["obj1"]
    count_of_script_tests = 1
    simple_tests_list = [{"type": "s1"}, {"type": "s2"}]

    mock_dependencies["get_objects"].return_value = objects
    mock_dependencies["gen_perc"].return_value = count_of_script_tests
    mock_dependencies["simple_gen"].return_value.__next__.side_effect = simple_tests_list
    mock_dependencies["validate"].return_value = (False, "Invalid simple test")
    mock_dependencies["simple_schema"].return_value = "simple_schema"

    with pytest.raises(SystemExit):
        generator(db, station, count_of_tests)

    mock_dependencies["send"].assert_not_called()
    mock_dependencies["script_gen"].assert_not_called()


def test_script_validation_fails(mock_dependencies):
    db = MagicMock()
    station = "StationA"
    count_of_tests = 3
    objects = ["obj1"]
    count_of_script_tests = 1
    simple_tests_list = [{"type": "s1"}, {"type": "s2"}]
    script_tests_list = [{"type": "sc1"}]

    mock_dependencies["get_objects"].return_value = objects
    mock_dependencies["gen_perc"].return_value = count_of_script_tests
    mock_dependencies["simple_gen"].return_value.__next__.side_effect = simple_tests_list
    mock_dependencies["script_gen"].return_value.__next__.side_effect = script_tests_list
    mock_dependencies["validate"].side_effect = [(True, None), (False, "Invalid script test")]
    mock_dependencies["simple_schema"].return_value = "simple_schema"
    mock_dependencies["script_schema"].return_value = "script_schema"

    with pytest.raises(SystemExit):
        generator(db, station, count_of_tests)

    mock_dependencies["send"].assert_called_once_with(simple_tests_list, db)


def test_zero_count_of_tests(mock_dependencies):
    db = MagicMock()
    station = "StationA"
    count_of_tests = 0
    objects = []
    count_of_script_tests = 0

    mock_dependencies["get_objects"].return_value = objects
    mock_dependencies["gen_perc"].return_value = count_of_script_tests
    mock_dependencies["validate"].return_value = (True, None)
    mock_dependencies["simple_schema"].return_value = "simple_schema"
    mock_dependencies["script_schema"].return_value = "script_schema"

    generator(db, station, count_of_tests)

    mock_dependencies["simple_gen"].assert_not_called()
    mock_dependencies["script_gen"].assert_not_called()
    mock_dependencies["validate"].assert_has_calls([
        call([], "simple_schema"),
        call([], "script_schema")
    ])
    mock_dependencies["send"].assert_has_calls([
        call([], db),
        call([], db)
    ])