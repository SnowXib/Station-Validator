from tests_generator.agregator import get_objects
from tests_generator.tests_generator import simple_test_generator, script_test_generator, generate_normalized_percentage
from tests_generator.validator import validate_json_schema, get_script_test_schema, get_simple_test_schema

from db.mongoDB.db_methods import send_tests_cases

def generator(db, station, count_of_tests):
    """
    Генераци тестов элементов станции
    
    :param db: База данных
    :param station: Имя станции
    :param count_of_tests: количество тестов
    """
    objects = get_objects(db, station)

    count_of_script_tests = generate_normalized_percentage(count_of_tests)

    simple_tests = [next(simple_test_generator(objects)) for _ in range(count_of_tests - count_of_script_tests)]
    valid, err = validate_json_schema(simple_tests, get_simple_test_schema())
    if not valid:
        print(err)
        exit()

    send_tests_cases(simple_tests, db)

    scipt_tests = [next(script_test_generator(objects)) for _ in range(count_of_script_tests)]
    valid, err = validate_json_schema(scipt_tests, get_script_test_schema())
    if not valid:
      print(err)
      exit()

    send_tests_cases(scipt_tests, db)