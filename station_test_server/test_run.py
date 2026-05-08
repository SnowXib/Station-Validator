import sys
import os
sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

from unittest.mock import patch, MagicMock
import pytest
from station_test_server.run import pipeline


@pytest.fixture
def mock_dependencies():
    with patch("station_test_server.run.mongo_connect") as mock_mongo_connect, \
         patch("station_test_server.run.setup_broker") as mock_setup_broker, \
         patch("station_test_server.run.mqtt") as mock_mqtt, \
         patch("station_test_server.run.core") as mock_core, \
         patch("station_test_server.run.uvicorn") as mock_uvicorn, \
         patch("station_test_server.run.MONGO_DB_URI", "mongodb://test"), \
         patch("station_test_server.run.DATABASE_NAME", "test_db"), \
         patch("station_test_server.run.BROKER", "test_broker"), \
         patch("station_test_server.run.BROKER_PORT", 1234), \
         patch("station_test_server.run.BROKER_USERNAME", "broker_user"), \
         patch("station_test_server.run.BROKER_PASSWORD", "broker_pass"), \
         patch("station_test_server.run.STATION_NAME", "TestStation"), \
         patch("station_test_server.run.MQTT_CLIENT_ID", "test_client"), \
         patch("station_test_server.run.MQTT_USER", "mqtt_user"), \
         patch("station_test_server.run.MQTT_PASSWORD", "mqtt_pass"), \
         patch("station_test_server.run.MQTT_BROKER", "mqtt_broker"), \
         patch("station_test_server.run.MQTT_PORT", 5678), \
         patch("station_test_server.run.OBJECTS_PATH", "/path/to/objects"), \
         patch("station_test_server.run.OBJECT_TYPES_PATH", "/path/to/types"):
        yield {
            "mongo_connect": mock_mongo_connect,
            "setup_broker": mock_setup_broker,
            "mqtt": mock_mqtt,
            "core": mock_core,
            "uvicorn": mock_uvicorn,
        }


def test_happy_path(mock_dependencies):
    mock_client_mongo = MagicMock()
    mock_db = MagicMock()
    mock_broker = MagicMock()
    mock_mqtt_client = MagicMock()
    mock_app = MagicMock()

    mock_dependencies["mongo_connect"].return_value = (mock_client_mongo, mock_db)
    mock_dependencies["setup_broker"].return_value = mock_broker
    mock_dependencies["mqtt"].Client.return_value = mock_mqtt_client
    mock_dependencies["core"].return_value = mock_app

    pipeline()

    mock_dependencies["mongo_connect"].assert_called_once_with("mongodb://test", "test_db")
    mock_dependencies["setup_broker"].assert_called_once_with("test_broker", 1234, "broker_user", "broker_pass", mock_db, "TestStation")
    mock_dependencies["mqtt"].Client.assert_called_once_with(client_id="test_client")
    mock_mqtt_client.username_pw_set.assert_called_once_with("mqtt_user", "mqtt_pass")
    mock_mqtt_client.connect.assert_called_once_with("mqtt_broker", 5678, 60)
    mock_dependencies["core"].assert_called_once_with("/path/to/objects", "/path/to/types", "TestStation", mock_db, mock_broker)
    mock_dependencies["uvicorn"].run.assert_called_once_with(mock_app, host="127.0.0.1", port=8000, log_level="info")
    mock_client_mongo.close.assert_called_once()


def test_client_mongo_is_none(mock_dependencies):
    mock_db = MagicMock()
    mock_broker = MagicMock()
    mock_mqtt_client = MagicMock()
    mock_app = MagicMock()

    mock_dependencies["mongo_connect"].return_value = (None, mock_db)
    mock_dependencies["setup_broker"].return_value = mock_broker
    mock_dependencies["mqtt"].Client.return_value = mock_mqtt_client
    mock_dependencies["core"].return_value = mock_app

    pipeline()

    mock_dependencies["mongo_connect"].assert_called_once()
    mock_dependencies["uvicorn"].run.assert_called_once()


def test_uvicorn_run_args(mock_dependencies):
    mock_client_mongo = MagicMock()
    mock_db = MagicMock()
    mock_broker = MagicMock()
    mock_mqtt_client = MagicMock()
    mock_app = MagicMock()

    mock_dependencies["mongo_connect"].return_value = (mock_client_mongo, mock_db)
    mock_dependencies["setup_broker"].return_value = mock_broker
    mock_dependencies["mqtt"].Client.return_value = mock_mqtt_client
    mock_dependencies["core"].return_value = mock_app

    pipeline()

    call_kwargs = mock_dependencies["uvicorn"].run.call_args
    assert call_kwargs[0][0] == mock_app
    assert call_kwargs[1]["host"] == "127.0.0.1"
    assert call_kwargs[1]["port"] == 8000
    assert call_kwargs[1]["log_level"] == "info"