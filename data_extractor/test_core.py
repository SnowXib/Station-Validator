import sys
import os
import pytest
from unittest.mock import Mock, patch

sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

from data_extractor.core_init import core


def test_core_returns_app():
    mock_db = Mock()
    mock_broker = Mock()
    objects_conf_path = "test_conf.json"
    objects_dir_path = "test_dir"
    station_name = "test_station"
    
    with patch('data_extractor.core_init.aggregation') as mock_aggregation:
        result = core(objects_conf_path, objects_dir_path, station_name, mock_db, mock_broker)
        
        mock_aggregation.assert_called_once_with(
            objects_conf_path, objects_dir_path, station_name, mock_db
        )
        assert result.state.db == mock_db
        assert result.state.broker == mock_broker


def test_core_calls_aggregation_with_correct_parameters():
    mock_db = Mock()
    mock_broker = Mock()
    objects_conf_path = "config/path.json"
    objects_dir_path = "objects/dir"
    station_name = "Moscow"
    
    with patch('data_extractor.core_init.aggregation') as mock_aggregation:
        core(objects_conf_path, objects_dir_path, station_name, mock_db, mock_broker)
        
        mock_aggregation.assert_called_once_with(
            objects_conf_path, objects_dir_path, station_name, mock_db
        )


def test_core_sets_attributes_on_app():
    mock_db = Mock(spec=['mock_method'])
    mock_broker = Mock(spec=['mock_method'])
    objects_conf_path = "conf.json"
    objects_dir_path = "dir"
    station_name = "Station"
    
    with patch('data_extractor.core_init.aggregation'):
        result = core(objects_conf_path, objects_dir_path, station_name, mock_db, mock_broker)
        
        assert hasattr(result.state, 'db')
        assert hasattr(result.state, 'broker')
        assert result.state.db is mock_db
        assert result.state.broker is mock_broker


def test_core_returns_same_app_instance():
    mock_db = Mock()
    mock_broker = Mock()
    
    with patch('data_extractor.core_init.aggregation'):
        result1 = core("conf1.json", "dir1", "Station1", mock_db, mock_broker)
        result2 = core("conf2.json", "dir2", "Station2", mock_db, mock_broker)
        
        assert result1 is result2


def test_core_reuses_app_and_updates_state():
    mock_db1 = Mock()
    mock_broker1 = Mock()
    mock_db2 = Mock()
    mock_broker2 = Mock()
    
    with patch('data_extractor.core_init.aggregation'):
        result1 = core("conf1.json", "dir1", "Station1", mock_db1, mock_broker1)
        result2 = core("conf2.json", "dir2", "Station2", mock_db2, mock_broker2)
        
        assert result1 is result2
        assert result1.state.db is mock_db2
        assert result1.state.broker is mock_broker2


def test_core_handles_empty_string_parameters():
    mock_db = Mock()
    mock_broker = Mock()
    
    with patch('data_extractor.core_init.aggregation') as mock_aggregation:
        result = core("", "", "", mock_db, mock_broker)
        
        mock_aggregation.assert_called_once_with("", "", "", mock_db)
        assert result.state.db == mock_db
        assert result.state.broker == mock_broker


def test_core_propagates_aggregation_exception():
    mock_db = Mock()
    mock_broker = Mock()
    
    with patch('data_extractor.core_init.aggregation', side_effect=FileNotFoundError("Config not found")):
        with pytest.raises(FileNotFoundError, match="Config not found"):
            core("invalid.json", "dir", "Station", mock_db, mock_broker)