import jsonschema
from jsonschema import ValidationError 


def get_simple_test_schema() -> dict:
    """
    Схема дл простых тестов
    
    :return: json схема
    :rtype: dict[Any, Any]
    """
    return {
        "type": "array",
        "items": {
            "type": "object",
            "required": [
                "id",
                "station", 
                "test_type", 
                "type", 
                "object_name", 
                "variable", 
                "value", 
                "description",
                "time_start",
                "info",
                "test_interval",
                "wait_seconds",
                "result"
            ],
            "properties": {
                "id": {"type": "string"},
                "test_run_id": {"type": "string"},
                "station": {"type": "string"},
                "value_for_setup": {"type": "string"},
                "test_type": {"type": "string", "const": "simple"},
                "type": {"type": "string"},
                "object_name": {"type": "string"},
                "variable": {"type": "string"},
                "value": {"type": ["number", "string"]},
                "description": {"type": "string"},
                "time_start": {"type": "string"},
                "info": {"type": "string"},
                "test_interval": {"type": "number"},
                "wait_seconds": {"type": "number"},
                "result": {"type": "string", "enum": ["not_started", "passed", "failed", "error", "generated"]}
            },
            "additionalProperties": True
        }
    }


def get_script_test_schema() -> dict:
    """
    Схема для скриптовых тестов
    
    :return: json схема
    :rtype: dict[Any, Any]
    """
    return {
        "type": "array",
        "items": {
            "type": "object",
            "required": [
                "id",
                "station",
                "test_type",
                "tests",
                "count_of_test",
                "time_start",
                "info",
                "test_interval",
                "wait_seconds",
                "result"
            ],
            "properties": {
                "station": {"type": "string"},
                "id": {"type": "string"},
                "test_run_id": {"type": "string"},
                "test_type": {"type": "string", "enum": ["script"]},
                "tests": {
                    "type": "array",
                    "minItems": 1,
                    "items": {
                        "type": "object",
                        "required": [
                            "object_name",
                            "variable",
                            "value",
                            "description",
                            "test_interval",
                            "wait_seconds",
                            "time_start"
                        ],
                        "properties": {
                            "object_name": {"type": "string"},
                            "variable": {"type": "string"},
                            "value": {"type": ["number", "string", "boolean"]},
                            "value_for_setup": {"type": "string"},
                            "description": {"type": "string"},
                            "test_interval": {"type": "number", "minimum": 0},
                            "wait_seconds": {"type": "number", "minimum": 0},
                            "time_start": {"type": "string"}
                        },
                        "additionalProperties": False
                    }
                },
                "count_of_test": {"type": "integer", "minimum": 1},
                "time_start": {"type": "string"},
                "info": {"type": "string"},
                "test_interval": {"type": "number", "minimum": 0},
                "wait_seconds": {"type": "number", "minimum": 0},
                "result": {"type": "string", "enum": ["not_started", "running", "completed", "failed", "error", "generated"]}
            },
            "additionalProperties": False
        }
    }


def validate_json_schema(data, schema) -> tuple[bool, str]:
    """
    Валидатор простых тестов
    
    :param data: Описание
    :type data: dict
    :param schema: Описание
    :type schema: dict
    :return: Описание
    :rtype: tuple[bool, str]
    """
    try:
        jsonschema.validate(instance=data, schema=schema)
        return True, "JSON валиден"
    except ValidationError as e:
        return False, f"Ошибка валидации: {e.message}"
        
    except Exception as e:
        return False, f"Непредвиденная ошибка: {str(e)}"