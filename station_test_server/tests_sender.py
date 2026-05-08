import time
import requests
import paho.mqtt.client as mqtt


def run_test(test):
    for _ in range(3):
        if test['result'] not in ["VALID", "NOT_STARTED"]:
            if test['test_type'] == 'simple':
                test = run_simple_test(test, test.get('test_interval', 2), test.get('wait_seconds', 2))
            if test['test_type'] == 'script':
                test = run_script_test(test)
    return test


def get_objects_state(test):
    print("Получаем состояние объекта")
    url = "http://localhost:4077/api/v1/get_object_state"
    payload = {
        "objectName": f"CPU/{test['object_name']}",
        "variableName": test['variable'],
    }
    req = requests.get(url, json=payload, timeout=2)

    if req.status_code == 200:
        req = req.json()
        return req.get('objectState')
    print(req.status_code)
    return "ERROR"


def run_simple_test(test, test_interval=2, wait_seconds=5):
    print()
    time.sleep(test_interval)

    if not test.get("object_name", 0):
        return test
    
    print(f"Старт теста для объекта {test['object_name']}")
    
    test['time_start'] = time.time()
    test['result'] = "INVALID"
    received = False

    # Настройки
    url = "http://localhost:4077/api/v1/set_object_state"
    payload = {
        "objectName": f"CPU/{test['object_name']}",
        "variableName": test['variable'],
        "variableValue": test['value_for_setup']
    }

    print(f"Запускаем тест для CPU/{test['object_name']} с variable {test['variable']} и value {test['value']}")
    state = get_objects_state(test)
    print(f"Сейчас объект в состоянии {state}")

    if state != test["value_for_setup"]:
        print(f"Ставим объект в состояние {test['value_for_setup']}")
        req = requests.put(url, json=payload, timeout=2)
        if not req.status_code == 200:
            print(f"Объект CPU/{test['object_name']} не переведен в состояние {test['value_for_setup']}")
            test['result'] = 'ERROR'
            return test
        else:
            print(f"Объект CPU/{test['object_name']} переведен в состояние {test['value_for_setup']}")
        payload['variableValue'] = test['value']
        time.sleep(2)
    elif state == "ERROR":
        print(f"Объект CPU/{test['object_name']} возвращает ошибку по переменной {test['variable']}")
        test['result'] = 'ERROR'
        return test


    topic = f"Client/data/CPU/{test['object_name']}/variables"

    client = mqtt.Client(mqtt.CallbackAPIVersion.VERSION2, client_id="probe")
    client.username_pw_set("server", "server")
    
    def on_message(c, userdata, msg):
        nonlocal received
        received = True

    client.on_message = on_message
    
    try:
        print("Подключение к брокеру")
        client.connect("localhost", 1883, 60)
        client.subscribe(topic)
        client.loop_start()

        # 4. Кидаем запрос на бэкенд
        print("Кидаем запрос на бекенд", payload)
        requests.put(url, json=payload, timeout=2)

        # 5. Пуллим результат (ожидаем флаг из callback)
        print("Пулим результат")
        end_wait = time.time() + wait_seconds
        while time.time() < end_wait:
            if received:
                test['result'] = "VALID"
                break
            time.sleep(0.1)

    except Exception as e:
        print(f"Error during test: {e}")
    finally:
        client.loop_stop()
        client.disconnect()

    # 6. Статус в консоль
    print(f"Test for {test['object_name']}: {test['result']}")
    return test


def run_script_test(script_test):
    print(f"\n=== Запуск скриптового теста: {script_test['count_of_test']} шагов ===")
    
    # 1. Начальная задержка всего скрипта
    time.sleep(script_test['test_interval'])
    script_test['time_start'] = time.time()
    success_count = 0
    steps = script_test['tests']

    for i, step in enumerate(steps, 1):
        print(f"\n--- Шаг {i}/{len(steps)} ---")
        
        # Вызываем нашу базовую функцию для каждого под-теста
        # Передаем параметры ожидания из структуры шага
        result_step = run_simple_test(
            step, 
            test_interval=step.get('test_interval', 0.5), 
            wait_seconds=step.get('wait_seconds', 5)
        )

        # Если один из шагов не прошел или не стартовал — логика скрипта обычно ломается
        if result_step and result_step.get('result') == "VALID":
            success_count += 1
        else:
            print(f"Скрипт прерван на шаге {i}: статус {step.get('result')}")
            script_test['result'] = "INVALID"
            return script_test

    # 3. Финальный результат
    if success_count == len(steps):
        script_test['result'] = "VALID"
    
    print(f"\n=== Итог скрипта: {script_test['result']} ({success_count}/{len(steps)} пройденно) ===")
    return script_test

