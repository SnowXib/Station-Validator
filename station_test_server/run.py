import os
import sys
from pathlib import Path

from dotenv import load_dotenv
import paho.mqtt.client as mqtt
import uvicorn

sys.path.insert(0, str(Path(__file__).parent.parent))

from db.mongoDB.db_connect import mongo_connect
from data_extractor.broker_setup import setup_broker
from data_extractor.core_init import core

load_dotenv()

MQTT_BROKER = "localhost"
MQTT_PORT = 1883
MQTT_USER = "server"
MQTT_PASSWORD = "server"
MQTT_CLIENT_ID = "probe"

MONGO_DB_URI = os.getenv("MONGODB_URI", "")
DATABASE_NAME = os.getenv("MONGODB_DB", "")
BROKER = os.getenv("MQTT_BROKER", "localhost")
BROKER_PORT = int(os.getenv("MQTT_PORT", 1883))
BROKER_USERNAME = os.getenv("MQTT_USERNAME", "")
BROKER_PASSWORD = os.getenv("MQTT_PASSWORD", "")
STATION_NAME = os.getenv("STATION_NAME", "TEST_STATION")
OBJECTS_PATH = os.getenv("OBJECTS_PATH", "data_extractor/conf/CPU.json")
OBJECT_TYPES_PATH = os.getenv("OBJECT_TYPES_PATH", "data_extractor/conf/objects")
COUNT_OF_TESTS = os.getenv("COUNT_OF_TESTS", "10")


def pipeline():
    client_mongo = None
    client_broker = None

    client_mongo, db = mongo_connect(MONGO_DB_URI, DATABASE_NAME)
    broker = setup_broker(
        BROKER, BROKER_PORT, BROKER_USERNAME, BROKER_PASSWORD, db, STATION_NAME
    )
    client = mqtt.Client(client_id=MQTT_CLIENT_ID)
    client.username_pw_set(MQTT_USER, MQTT_PASSWORD)

    client.connect(MQTT_BROKER, MQTT_PORT, 60)

    app = core(OBJECTS_PATH, OBJECT_TYPES_PATH, STATION_NAME, db, broker)

    uvicorn.run(app, host="127.0.0.1", port=8000, log_level="info")

    if client_mongo:
        client_mongo.close()
    if client_broker:
        client_broker.disconect()


if __name__ == "__main__":
    pipeline()
