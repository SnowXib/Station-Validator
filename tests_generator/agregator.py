from db.mongoDB.db_methods import get_aggregation_objects


def get_objects(db, station):
    """
    Получить и обогатить агрегированные объекты для станции

    :param db: база данных
    :param station: имя станции
    :return: список объектов с добавленной мета-информацией
    """
    objects = get_aggregation_objects(db, station)

    if not objects:
        return []

    enriched_objects = []
    for obj in objects:
        obj_type = obj.get("type", "Unknown")
        obj_list = obj.get("objects", [])
        variables = obj.get("variables", {})

        enriched_obj = obj.copy()

        enriched_obj["_meta"] = {
            "count": len(obj_list),
            "variables_count": len(variables),
            "variable_names": list(variables.keys()),
        }

        if obj_list and variables:
            first_var_name = next(iter(variables.keys()))
            first_var_values = variables[first_var_name]
            if first_var_values:
                default_status = first_var_values[0]
                enriched_obj["_summary"] = {
                    "default_variable": first_var_name,
                    "default_value": default_status.get("value", "UNKNOWN"),
                    "default_description": default_status.get(
                        "description", "Нет данных"
                    ),
                }

        enriched_objects.append(enriched_obj)

    type_groups = {}
    for obj in enriched_objects:
        obj_type = obj.get("type", "Unknown")
        if obj_type not in type_groups:
            type_groups[obj_type] = []
        type_groups[obj_type].append(obj)

    return enriched_objects
