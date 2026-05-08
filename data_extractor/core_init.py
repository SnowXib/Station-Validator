from data_extractor.extractor import aggregation
from api.app import app


def core(objects_conf_path, objects_dir_path, station_name, db, broker):
    aggregation(objects_conf_path, objects_dir_path, station_name, db)
    app.state.db = db
    app.state.broker = broker
    return app
