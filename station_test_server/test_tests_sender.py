import sys
import os

sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

import pytest
from unittest.mock import Mock, patch, call

from station_test_server.tests_sender import (
    run_test,
    run_simple_test,
    run_script_test,
    get_objects_state,
)


@pytest.fixture
def simple_test_data():
    return {
        "object_name": "test_object",
        "variable": "test_var",
        "value": "expected_value",
        "value_for_setup": "setup_value",
        "test_type": "simple",
        "result": "NOT_STARTED",
    }


@pytest.fixture
def script_test_data():
    steps = [
        {
            "object_name": "obj1",
            "variable": "var1",
            "value": "val1",
            "value_for_setup": "setup1",
            "test_type": "simple",
            "result": "NOT_STARTED",
            "test_interval": 0.1,
            "wait_seconds": 1,
        },
        {
            "object_name": "obj2",
            "variable": "var2",
            "value": "val2",
            "value_for_setup": "setup2",
            "test_type": "simple",
            "result": "NOT_STARTED",
            "test_interval": 0.2,
            "wait_seconds": 2,
        },
    ]
    return {
        "count_of_test": 2,
        "tests": steps,
        "test_interval": 0.5,
        "test_type": "script",
        "result": "NOT_STARTED",
    }


@patch("station_test_server.tests_sender.requests.get")
def test_get_objects_state_success(mock_get):
    mock_response = Mock()
    mock_response.status_code = 200
    mock_response.json.return_value = {"objectState": "ON"}
    mock_get.return_value = mock_response

    test = {"object_name": "test", "variable": "state"}
    state = get_objects_state(test)
    assert state == "ON"
    mock_get.assert_called_once_with(
        "http://localhost:4077/api/v1/get_object_state",
        json={"objectName": "CPU/test", "variableName": "state"},
        timeout=2,
    )


@patch("station_test_server.tests_sender.requests.get")
def test_get_objects_state_error_status(mock_get):
    mock_response = Mock()
    mock_response.status_code = 500
    mock_get.return_value = mock_response

    test = {"object_name": "test", "variable": "state"}
    state = get_objects_state(test)
    assert state == "ERROR"


@patch("station_test_server.tests_sender.requests.put")
@patch("station_test_server.tests_sender.requests.get")
@patch("station_test_server.tests_sender.mqtt.Client")
@patch("station_test_server.tests_sender.time.sleep")
def test_run_simple_test_invalid(
    mock_sleep, mock_mqtt_client, mock_get, mock_put, simple_test_data
):
    mock_get_response = Mock()
    mock_get_response.status_code = 200
    mock_get_response.json.return_value = {"objectState": "setup_value"}
    mock_get.return_value = mock_get_response

    mock_put_response = Mock()
    mock_put_response.status_code = 200
    mock_put.return_value = mock_put_response

    mock_client_instance = Mock()
    mock_mqtt_client.return_value = mock_client_instance

    on_message_callback = None

    def on_message_setter(c, userdata, msg):
        nonlocal on_message_callback
        on_message_callback = msg

    def put_side_effect(*args, **kwargs):
        if on_message_callback:
            fake_msg = Mock()
            on_message_callback(fake_msg, None, fake_msg)
        return mock_put_response

    mock_put.side_effect = put_side_effect
    mock_client_instance.on_message = on_message_setter

    result = run_simple_test(simple_test_data, test_interval=0, wait_seconds=0.1)

    assert result["result"] == "INVALID"
    mock_get.assert_called()
    assert mock_put.call_count == 1
    mock_client_instance.subscribe.assert_called_once_with(
        "Client/data/CPU/test_object/variables"
    )
    mock_client_instance.connect.assert_called_once_with("localhost", 1883, 60)
    mock_client_instance.loop_start.assert_called_once()
    mock_client_instance.loop_stop.assert_called_once()
    mock_client_instance.disconnect.assert_called_once()


@patch("station_test_server.tests_sender.requests.put")
@patch("station_test_server.tests_sender.requests.get")
@patch("station_test_server.tests_sender.mqtt.Client")
@patch("station_test_server.tests_sender.time.sleep")
def test_run_simple_test_state_already_correct(
    mock_sleep, mock_mqtt_client, mock_get, mock_put, simple_test_data
):
    mock_get_response = Mock()
    mock_get_response.status_code = 200
    mock_get_response.json.return_value = {"objectState": "setup_value"}
    mock_get.return_value = mock_get_response

    mock_put_response = Mock()
    mock_put_response.status_code = 200
    mock_put.return_value = mock_put_response

    mock_client_instance = Mock()
    mock_mqtt_client.return_value = mock_client_instance

    on_message_callback = None

    def on_message_setter(c, userdata, msg):
        nonlocal on_message_callback
        on_message_callback = msg

    def put_side_effect(*args, **kwargs):
        if on_message_callback:
            fake_msg = Mock()
            on_message_callback(fake_msg, None, fake_msg)
        return mock_put_response

    mock_put.side_effect = put_side_effect
    mock_client_instance.on_message = on_message_setter

    result = run_simple_test(simple_test_data, test_interval=0, wait_seconds=0.1)
    assert result["result"] == "INVALID"
    assert mock_put.call_count == 1


@patch("station_test_server.tests_sender.requests.put")
@patch("station_test_server.tests_sender.requests.get")
@patch("station_test_server.tests_sender.mqtt.Client")
@patch("station_test_server.tests_sender.time.sleep")
def test_run_simple_test_no_object_name(
    mock_sleep, mock_mqtt_client, mock_get, mock_put, simple_test_data
):
    simple_test_data["object_name"] = 0
    result = run_simple_test(simple_test_data)
    assert result["result"] == "NOT_STARTED"
    mock_get.assert_not_called()
    mock_put.assert_not_called()
    mock_mqtt_client.assert_not_called()


@patch("station_test_server.tests_sender.requests.put")
@patch("station_test_server.tests_sender.requests.get")
@patch("station_test_server.tests_sender.mqtt.Client")
@patch("station_test_server.tests_sender.time.sleep")
def test_run_simple_test_failed_setup(
    mock_sleep, mock_mqtt_client, mock_get, mock_put, simple_test_data
):
    mock_get_response = Mock()
    mock_get_response.status_code = 200
    mock_get_response.json.return_value = {"objectState": "other_value"}
    mock_get.return_value = mock_get_response

    mock_put_response = Mock()
    mock_put_response.status_code = 500
    mock_put.return_value = mock_put_response

    result = run_simple_test(simple_test_data)
    assert result["result"] == "ERROR"
    assert mock_put.call_count == 1


@patch("station_test_server.tests_sender.run_simple_test")
@patch("station_test_server.tests_sender.time.sleep")
def test_run_script_test_all_success(mock_sleep, mock_run_simple, script_test_data):
    mock_run_simple.return_value = {"result": "VALID"}

    result = run_script_test(script_test_data)

    assert result["result"] == "VALID"
    assert mock_run_simple.call_count == 2
    expected_calls = [
        call(script_test_data["tests"][0], test_interval=0.1, wait_seconds=1),
        call(script_test_data["tests"][1], test_interval=0.2, wait_seconds=2),
    ]
    mock_run_simple.assert_has_calls(expected_calls)


@patch("station_test_server.tests_sender.run_simple_test")
@patch("station_test_server.tests_sender.time.sleep")
def test_run_script_test_step_fails(mock_sleep, mock_run_simple, script_test_data):
    mock_run_simple.side_effect = [{"result": "VALID"}, {"result": "INVALID"}]

    result = run_script_test(script_test_data)

    assert result["result"] == "INVALID"
    assert mock_run_simple.call_count == 2


@patch("station_test_server.tests_sender.run_simple_test")
@patch("station_test_server.tests_sender.time.sleep")
def test_run_test_no_retry_on_valid_or_not_started(mock_sleep, mock_run_simple):
    test = {
        "result": "VALID",
        "test_type": "simple",
        "object_name": "obj",
        "variable": "var",
        "value": "val",
        "value_for_setup": "setup",
    }
    result = run_test(test)
    assert result["result"] == "VALID"
    mock_run_simple.assert_not_called()
