import json
import os, sys
import pytest
sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

from unittest.mock import mock_open, patch, call, MagicMock

from data_extractor.extractor import (
    parsing_objects, get_filenames, 
    parsing_object, add_objects_into_type,
    save_to_file, aggregation,
)


def test_parsing_objects_typical(tmp_path):
    """Корректный парсинг списка объектов из JSON."""
    conf = {
        "items": [
            {"name": "1", "type": "Point"},
            {"name": "1НП", "type": "Section"},
            {"name": "ДДН", "type": "DayNightSensor"}
        ]
    }
    file_path = tmp_path / "objects.json"
    file_path.write_text(json.dumps(conf, ensure_ascii=False), encoding="utf-8")

    result = parsing_objects(str(file_path))
    expected = [
        {"object": "1", "type": "Point"},
        {"object": "1НП", "type": "Section"},
        {"object": "ДДН", "type": "DayNightSensor"}
    ]
    assert result == expected


def test_parsing_objects_empty(tmp_path):
    """Пустой список items – возвращается пустой список."""
    conf = {"items": []}
    file_path = tmp_path / "empty.json"
    file_path.write_text(json.dumps(conf), encoding="utf-8")
    result = parsing_objects(str(file_path))
    assert result == []


def test_get_filenames_valid_extensions(tmp_path):
    """Файлы только с расширениями .dm и .json."""
    (tmp_path / "a.json").touch()
    (tmp_path / "b.dm").touch()
    (tmp_path / "c.json").touch()
    result = get_filenames(str(tmp_path))
    expected = [
        str(tmp_path / "a.json"),
        str(tmp_path / "b.dm"),
        str(tmp_path / "c.json")
    ]
    assert sorted(result) == sorted(expected)


def test_get_filenames_with_invalid_extension(tmp_path):
    """При наличии файла с недопустимым расширением возникает ValueError."""
    (tmp_path / "good.json").touch()
    (tmp_path / "bad.txt").touch()
    with pytest.raises(ValueError, match="не является файлом объекта станции"):
        get_filenames(str(tmp_path))


def test_get_filenames_not_a_directory(tmp_path):
    """Если передан путь к файлу, а не к каталогу, возникает ValueError."""
    file_path = tmp_path / "somefile.txt"
    file_path.touch()
    with pytest.raises(ValueError, match="не является директорией"):
        get_filenames(str(file_path))


def test_get_filenames_empty_directory(tmp_path):
    """Пустой каталог возвращает пустой список."""
    result = get_filenames(str(tmp_path))
    assert result == []


SIGNAL_JSON = """
{
    "name": "Signal",
    "extend": "SignalBase",
    "variables": [
        {
            "name": "Status",
            "type": "enum",
            "values": [
                {"name": "UNDEF", "description": "Нет данных"},
                {"name": "RED", "description": "Красный"}
            ],
            "default": "UNDEF"
        },
        {
            "name": "Blocking",
            "type": "enum",
            "default": "UNDEF",
            "values": [
                {"name": "UNDEF", "description": "Нет данных"},
                {"name": "SIGNAL_NOT_BLOCKED", "description": "Сигнал не блокирован"}
            ]
        }
    ]
}
"""


def test_parsing_object_typical(tmp_path):
    """Парсинг типового файла объекта."""
    file_path = tmp_path / "Signal.json"
    file_path.write_text(SIGNAL_JSON, encoding="utf-8")
    result = parsing_object(str(file_path))

    expected = {
        "type": "Signal",
        "objects": [],
        "station": "",
        "variables": {
            "Status": [
                {"value": "UNDEF", "description": "Нет данных"},
                {"value": "RED", "description": "Красный"}
            ],
            "Blocking": [
                {"value": "UNDEF", "description": "Нет данных"},
                {"value": "SIGNAL_NOT_BLOCKED", "description": "Сигнал не блокирован"}
            ]
        }
    }
    assert result == expected


def test_parsing_object_no_variables(tmp_path):
    """Объект без variables – в результате пустой словарь переменных."""
    data = {"name": "EmptyObj", "variables": []}
    file_path = tmp_path / "empty.json"
    file_path.write_text(json.dumps(data), encoding="utf-8")
    result = parsing_object(str(file_path))
    assert result["type"] == "EmptyObj"
    assert result["variables"] == {}
    assert result["objects"] == []
    assert result["station"] == ""


def test_add_objects_into_type_matching():
    """Корректное добавление объектов в соответствующие типы."""
    objects_types = [
        {
            "type": "Point",
            "objects": [],
            "station": "",
            "variables": {}
        },
        {
            "type": "Section",
            "objects": [],
            "station": "",
            "variables": {}
        },
        {
            "type": "Signal",
            "objects": [],
            "station": "",
            "variables": {}
        }
    ]
    object_list = [
        {"object": "1", "type": "Point"},
        {"object": "2", "type": "Point"},
        {"object": "1НП", "type": "Section"},
        {"object": "Н", "type": "Signal"}
    ]

    add_objects_into_type(objects_types, object_list, "TestStation")

    assert objects_types[0]["objects"] == ["1", "2"]
    assert objects_types[0]["station"] == "TestStation"
    assert objects_types[1]["objects"] == ["1НП"]
    assert objects_types[1]["station"] == "TestStation"
    assert objects_types[2]["objects"] == ["Н"]
    assert objects_types[2]["station"] == "TestStation"


def test_add_objects_into_type_no_match():
    """Если тип объекта не найден – никакие списки не изменяются."""
    objects_types = [{"type": "Point", "objects": [], "station": ""}]
    object_list = [{"object": "X", "type": "Unknown"}]
    add_objects_into_type(objects_types, object_list, "Station")
    assert objects_types[0]["objects"] == []


def test_save_to_file(mocker):
    """Проверка, что данные правильно сериализуются и записываются в файл."""
    mock_open_obj = mocker.patch("builtins.open", mock_open())
    mock_json_dump = mocker.patch("json.dump")

    test_data = [{"type": "Test", "objects": ["1"]}]
    save_to_file(test_data)

    mock_open_obj.assert_called_once_with("output.json", "w", encoding="utf-8")
    mock_json_dump.assert_called_once_with(
        test_data,
        mock_open_obj.return_value.__enter__.return_value,
        ensure_ascii=False,
        indent=4
    )


def test_aggregation_happy_path(mocker):
    """Интеграционный тест с подменой всех вложенных вызовов."""
    mock_parsing_objects = mocker.patch("data_extractor.extractor.parsing_objects")
    mock_get_filenames = mocker.patch("data_extractor.extractor.get_filenames")
    mock_parsing_object = mocker.patch("data_extractor.extractor.parsing_object")
    mock_add_objects_into_type = mocker.patch("data_extractor.extractor.add_objects_into_type")
    mock_save_to_file = mocker.patch("data_extractor.extractor.save_to_file")
    mock_send_aggregating = mocker.patch("data_extractor.extractor.send_aggregating_objects")

    mock_parsing_objects.return_value = [
        {"object": "1", "type": "Point"},
        {"object": "Н", "type": "Signal"}
    ]
    mock_get_filenames.return_value = ["path/Point.json", "path/Signal.json"]
    mock_parsing_object.side_effect = [
        {"type": "Point", "objects": [], "station": "", "variables": {}},
        {"type": "Signal", "objects": [], "station": "", "variables": {}}
    ]

    mock_client = mocker.MagicMock()
    mock_db = mocker.MagicMock()

    aggregation("objects.json", "types_dir", "CentralStation", mock_db)

    mock_parsing_objects.assert_called_once_with("objects.json")
    mock_get_filenames.assert_called_once_with("types_dir")
    assert mock_parsing_object.call_args_list == [call("path/Point.json"), call("path/Signal.json")]
    mock_add_objects_into_type.assert_called_once_with(
        [
            {"type": "Point", "objects": [], "station": "", "variables": {}},
            {"type": "Signal", "objects": [], "station": "", "variables": {}}
        ],
        mock_parsing_objects.return_value,
        "CentralStation"
    )
    mock_save_to_file.assert_called_once_with(mock_add_objects_into_type.call_args[0][0])
    mock_send_aggregating.assert_called_once_with(mock_add_objects_into_type.call_args[0][0], mock_db)


def test_aggregation_empty_lists(mocker):
    mock_parsing_objects = mocker.patch("data_extractor.extractor.parsing_objects", return_value=[])
    mock_get_filenames = mocker.patch("data_extractor.extractor.get_filenames", return_value=[])
    mock_parsing_object = mocker.patch("data_extractor.extractor.parsing_object")
    mock_add_objects_into_type = mocker.patch("data_extractor.extractor.add_objects_into_type")
    mock_save_to_file = mocker.patch("data_extractor.extractor.save_to_file")
    mock_send_aggregating = mocker.patch("data_extractor.extractor.send_aggregating_objects")
    
    aggregation("conf", "dir", "EmptyStation", "db")
    
    mock_parsing_objects.assert_called_once_with("conf")
    mock_get_filenames.assert_called_once_with("dir")
    mock_parsing_object.assert_not_called()
    mock_add_objects_into_type.assert_called_once_with([], [], "EmptyStation")
    mock_save_to_file.assert_called_once_with([])
    mock_send_aggregating.assert_called_once_with([], "db")