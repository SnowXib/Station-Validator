def list_to_dict(arr):
    """
    Генерация словаря из списка

    :param arr: список
    """
    keys = [list(item.keys())[0] for item in arr]
    values = [list(item.values())[0] for item in arr]
    combined_dict = {keys[i]: values[i] for i in range(len(keys))}

    return combined_dict
