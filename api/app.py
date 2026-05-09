from fastapi import FastAPI, Request, Depends, HTTPException, Query
from fastapi.responses import JSONResponse
from fastapi.middleware.cors import CORSMiddleware

from db.mongoDB.db_methods import (
    get_aggregation_objects,
    send_tests_cases,
    get_tests_cases,
    drop_tests_collection,
    update_tests_results,
    send_tests_run,
    get_tests_run,
    get_test_by_id,
    get_tests_run_by_id,
    send_object_test,
    get_objects_test,
    get_tests_by_ids_db,
    save_test_to_db,
)
from station_test_server.tests_sender import run_test
from tests_generator.tests_generator import (
    simple_test_generator,
    script_test_generator,
    generate_normalized_percentage,
)
from api.models import TestCreateRequest

from datetime import datetime
import random


def get_db(request: Request):
    db = request.app.state.db
    if db is None:
        raise HTTPException(status_code=500, detail="БД не инициализирована")
    return db


def get_broker(request: Request):
    broker = request.app.state.broker
    if broker is None:
        raise HTTPException(status_code=500, detail="Брокер не инициализирован")
    return broker


app = FastAPI(
    title="Station_test_server",
    description="Информационная система автоматизированной проверки работоспособности ПАК железнодорожных станций",
)

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


@app.get("/")
def root():
    """Главная страница"""
    return {"message": "Добро пожаловать на мой FastAPI сервер!"}


@app.get("/api/get_aggregation_objects")
def get_objects(station, limit=0, db=Depends(get_db)):
    """
    Получить агрегированные объекты

    :param station: Название станции
    :param limit: количество объектов
    :param db: база данных
    """
    objects = get_aggregation_objects(db, station, int(limit))
    return JSONResponse(content=objects, status_code=200)


@app.post("/api/generate_simple_tests_case")
def generate_simple_tests_case(station, test_run_id="TEST", count=1, db=Depends(get_db)):
    """
    Создание тестов на станции

    :param station: Имя станции
    :param count: количество объектов
    :param db: база данных
    """
    objects = get_aggregation_objects(db, station)
    tests = [
        next(simple_test_generator(objects, test_run_id)) for _ in range(int(count))
    ]
    send_tests_cases(tests, db)
    for test in tests:
        test.pop("_id", None)

    return JSONResponse(content=tests, status_code=200)


@app.post("/api/generate_script_tests_case")
def generate_script_tests_case(station, test_run_id="TEST", count=1, db=Depends(get_db)):

    objects = get_aggregation_objects(db, station)
    tests = [
        next(script_test_generator(objects, test_run_id)) for _ in range(int(count))
    ]
    send_tests_cases(tests, db)
    for test in tests:
        test.pop("_id", None)

    return JSONResponse(content=tests, status_code=200)


@app.get("/api/get_tests_case")
def get_tests_case(station, object_name=None, count=1, db=Depends(get_db)):
    """
    Получить тесты

    :param station: Название станции
    :param count: количество объектов
    :param db: база данных
    """
    tests = get_tests_cases(station, int(count), db, object_name)

    return JSONResponse(content=tests, status_code=200)


@app.get("/api/get_test_by_id")
def get_test_by_id_api(id_test, db=Depends(get_db)):
    """
    Получить тесты

    :param station: Название станции
    :param count: количество объектов
    :param db: база данных
    """
    tests = get_test_by_id(db, id_test)

    return JSONResponse(content=tests, status_code=200)


@app.get("/api/get_tests_by_ids")
def get_tests_by_ids(
    id_test: str = Query(description="ID тестов через запятую"), db=Depends(get_db)
):
    """
    Получить тесты по списку ID

    :param id_test: ID тестов через запятую (например: "id1,id2,id3")
    :param db: база данных
    """
    ids_list = [id.strip() for id in id_test.split(",") if id.strip()]

    tests = get_tests_by_ids_db(db, ids_list)
    result = []
    for test in tests:
        if test["test_type"] == "simple":
            result.append(test)
            continue
        objects = []
        variables = []
        for test_in_test in test["tests"]:
            objects.append(test_in_test["object_name"])
            variables.append(test_in_test["variable"])
        test["object_name"] = ", ".join(objects)
        test["variable"] = ", ".join(variables)
        test["value"] = "Множество"
        result.append(test)
    return JSONResponse(content=result, status_code=200)


@app.post("/api/generate_test_run")
def generate_test_run(station, count, db=Depends(get_db)):
    test_run_id = f"{station}_{count}_{datetime.now().timestamp()}"
    objects = get_aggregation_objects(db, station)
    tests = []
    count_script_tests = generate_normalized_percentage(int(count))
    simple_tests = [
        next(simple_test_generator(objects, test_run_id))
        for _ in range(int(count) - count_script_tests)
    ]
    script_tests = [
        next(script_test_generator(objects, test_run_id))
        for _ in range(count_script_tests)
    ]
    tests = simple_tests + script_tests
    random.shuffle(tests)
    send_tests_cases(tests, db)

    tests_id = []
    for simple_test in tests:
        tests_id.append(simple_test["id"])

    tests_run = {
        "id": test_run_id,
        "station": station,
        "tests_id": tests_id,
        "start_time": datetime.now().timestamp(),
        "count": count,
    }

    send_tests_run(tests_run, db)
    tests_run.pop("_id", None)

    return JSONResponse(content=tests_run, status_code=200)


@app.get("/api/get_tests_runs")
def get_test_run(station=None, id_run=None, db=Depends(get_db)):
    if id_run is None:
        tests_run = get_tests_run(station, db)
    else:
        tests_run = get_tests_run_by_id(db, id_run)
    return JSONResponse(content=tests_run, status_code=200)


@app.post("/api/tests_run")
def tests_run(id_run, db=Depends(get_db)):
    tests_run = get_tests_run_by_id(db, id_run)
    tests_run["start_time"] = datetime.now().timestamp()
    for test in tests_run["tests_id"]:
        test = get_test_by_id(db, test)
        test = run_test(test)
        update_tests_results(test, db)
        send_object_test(db, test)

    return JSONResponse(content={}, status_code=200)


@app.get("/api/object_test")
def object_test(station, db=Depends(get_db)):
    objects = get_objects_test(db, station)
    return JSONResponse(content=objects, status_code=200)


@app.post("/api/create_test")
def create_and_run_test(test_data: TestCreateRequest, db=Depends(get_db)):
    """
    Создает новый тест и запускает его выполнение

    :param test_data: данные теста от фронтенда
    :param db: база данных
    """
    try:
        timestamp = datetime.now().timestamp()
        base_id = f"{test_data.station}_simple_{test_data.type}_{timestamp}"

        test_interval_value = test_data.test_interval
        if test_interval_value is not None:
            if isinstance(test_interval_value, str):
                test_interval_value = (
                    float(test_interval_value)
                    if "." in test_interval_value
                    else int(test_interval_value)
                )
        else:
            test_interval_value = None

        wait_seconds_value = test_data.wait_seconds
        if wait_seconds_value is not None:
            if isinstance(wait_seconds_value, str):
                wait_seconds_value = (
                    float(wait_seconds_value)
                    if "." in wait_seconds_value
                    else int(wait_seconds_value)
                )
        else:
            wait_seconds_value = None

        new_test = {
            "station": test_data.station,
            "type": test_data.type,
            "object_name": test_data.object_name,
            "variable": test_data.variable,
            "value": test_data.value,
            "value_for_setup": test_data.value_for_setup,
            "test_interval": test_interval_value,
            "wait_seconds": wait_seconds_value,
            "id": base_id,
            "test_run_id": base_id,
            "test_type": "simple",
            "description": "Одиночный тест",
            "time_start": datetime.now().isoformat(),
            "info": "",
            "result": "generated",
        }

        save_test_to_db(db, new_test)

        test_result = run_test(new_test)

        update_tests_results(test_result, db)

        return JSONResponse(
            content={
                "message": "Тест успешно создан и выполнен",
                "test_id": base_id,
                "result": test_result.get("result"),
                "status": "completed",
            },
            status_code=200,
        )

    except Exception as e:
        raise HTTPException(
            status_code=500, detail=f"Ошибка при создании и запуске теста: {str(e)}"
        )


@app.post("/api/test_run")
def test_run(id_test, db=Depends(get_db)):
    test = get_test_by_id(db, id_test)
    if test is not None:
        test = run_test(test)
        update_tests_results(test, db)
        return JSONResponse(content=test["result"], status_code=200)

    return JSONResponse(content={}, status_code=404)


@app.delete("/api/drop_tests_collection")
def delete_tests_cases(db=Depends(get_db)):
    result = drop_tests_collection(db)
    return JSONResponse(content=result, status_code=200)


if __name__ == "__main__":
    pass
