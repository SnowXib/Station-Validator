{
    "name": "Signal_3_head",
    "variables": [
        {
            "name": "Status",
            "type": "enum",
            "values": [
                {
                    "name": "UNDEF",
                    "description": "Нет данных"
                },
                {
                    "name": "NO_INFO",
                    "description": "Нет информации от ОК",
                    "contexts": [
                        {
                            "eventId": "0x40",
                            "name": "armCpEl"
                        },
                        {
                            "name": "apkDk",
                            "functionName": "Сигнал_с_3_головками_Status_состояние",
                            "value": 0
                        }
                    ]
                },
                {
                    "name": "RED",
                    "description": "Красный",
                    "contexts": [
                        {
                            "eventId": "0x41",
                            "name": "armCpEl"
                        },
                        {
                            "name": "apkDk",
                            "functionName": "Сигнал_с_3_головками_Status_состояние",
                            "value": 1
                        }
                    ]
                },
                {
                    "name": "TWO_YELLOW",
                    "description": "Два желтых",
                    "contexts": [
                        {
                            "name": "armCpEl",
                            "eventId": "0x42"
                        },
                        {
                            "name": "apkDk",
                            "functionName": "Сигнал_с_3_головками_Status_состояние",
                            "value": 2
                        }
                    ]
                },
                {
                    "name": "YELLOW",
                    "description": "Желтый",
                    "contexts": [
                        {
                            "name": "armCpEl",
                            "eventId": "0x43"
                        },
                        {
                            "name": "apkDk",
                            "functionName": "Сигнал_с_3_головками_Status_состояние",
                            "value": 3
                        }
                    ]
                },
                {
                    "name": "TWO_YELLOW_UPPER_FLASHING",
                    "description": "Два желтых, из них верхний мигающий",
                    "contexts": [
                        {
                            "name": "armCpEl",
                            "eventId": "0x44"
                        },
                        {
                            "name": "apkDk",
                            "functionName": "Сигнал_с_3_головками_Status_состояние",
                            "value": 4
                        }
                    ]
                },
                {
                    "name": "GREEN",
                    "description": "Зеленый",
                    "contexts": [
                        {
                            "name": "armCpEl",
                            "eventId": "0x45"
                        },
                        {
                            "name": "apkDk",
                            "functionName": "Сигнал_с_3_головками_Status_состояние",
                            "value": 5
                        }
                    ]
                },
                {
                    "name": "CALL_ON_RED",
                    "description": "Пригласительный и красный",
                    "contexts": [
                        {
                            "name": "armCpEl",
                            "eventId": "0x46"
                        },
                        {
                            "name": "apkDk",
                            "functionName": "Сигнал_с_3_головками_Status_состояние",
                            "value": 6
                        }
                    ]
                },
                {
                    "name": "TWO_YELLOW_WHITE",
                    "description": "Два желтых + белый",
                    "contexts": [
                        {
                            "eventId": "0x47",
                            "name": "armCpEl"
                        },
                        {
                            "name": "apkDk",
                            "functionName": "Сигнал_с_3_головками_Status_состояние",
                            "value": 7
                        }
                    ]
                },
                {
                    "name": "YELLOW_FLASHING",
                    "description": "Желтый мигающий",
                    "contexts": [
                        {
                            "eventId": "0x48",
                            "name": "armCpEl"
                        },
                        {
                            "name": "apkDk",
                            "functionName": "Сигнал_с_3_головками_Status_состояние",
                            "value": 8
                        }
                    ]
                },
                {
                    "name": "WHITE",
                    "description": "Белый",
                    "contexts": [
                        {
                            "eventId": "0x49",
                            "name": "armCpEl"
                        },
                        {
                            "name": "apkDk",
                            "functionName": "Сигнал_с_3_головками_Status_состояние",
                            "value": 9
                        }
                    ]
                },
                {
                    "name": "WHITE_YELLOW",
                    "description": "Белый + желтый",
                    "contexts": [
                        {
                            "eventId": "0x4A",
                            "name": "armCpEl"
                        },
                        {
                            "name": "apkDk",
                            "functionName": "Сигнал_с_3_головками_Status_состояние",
                            "value": 10
                        }
                    ]
                },
                {
                    "name": "WHITE_YELLOW_FLASHING",
                    "description": "Белый + желтый мигающий",
                    "contexts": [
                        {
                            "eventId": "0x4B",
                            "name": "armCpEl"
                        },
                        {
                            "name": "apkDk",
                            "functionName": "Сигнал_с_3_головками_Status_состояние",
                            "value": 11
                        }
                    ]
                },
                {
                    "name": "GREEN_WHITE",
                    "description": "Белый + зеленый",
                    "contexts": [
                        {
                            "name": "armCpEl",
                            "eventId": "0x4C"
                        },
                        {
                            "name": "apkDk",
                            "functionName": "Сигнал_с_3_головками_Status_состояние",
                            "value": 12
                        }
                    ]
                },
                {
                    "name": "WHITE_TWO_YELLOW_UPPER_FLASHING",
                    "description": "Два желтых, из них верхний мигающий огонь, белый",
                    "contexts": [
                        {
                            "name": "armCpEl",
                            "eventId": "0x4D"
                        },
                        {
                            "name": "apkDk",
                            "functionName": "Сигнал_с_3_головками_Status_состояние",
                            "value": 13
                        }
                    ]
                },
                {
                    "name": "GREEN_YELLOW",
                    "description": "Зеленый + желтый",
                    "contexts": [
                        {
                            "eventId": "0x4E",
                            "name": "armCpEl"
                        },
                        {
                            "name": "apkDk",
                            "functionName": "Сигнал_с_3_головками_Status_состояние",
                            "value": 14
                        }
                    ]
                },
                {
                    "name": "CALL_ON_RED_FAULT",
                    "description": "Пригласительный, неисправность красного",
                    "contexts": [
                        {
                            "eventId": "0x80",
                            "name": "armCpEl"
                        }
                    ]
                },
                {
                    "name": "RED_CALL_ON_FAULT",
                    "description": "Красный, неисправность пригласительного",
                    "contexts": [
                        {
                            "eventId": "0x81",
                            "name": "armCpEl"
                        }
                    ]
                },
                {
                    "name": "DARK_RED_FAULT_CALL_ON_FAULT",
                    "description": "Темный, неисправность пригласительного и красного",
                    "contexts": [
                        {
                            "eventId": "0x82",
                            "name": "armCpEl"
                        }
                    ]
                },
                {
                    "name": "DARK_RED_FAULT",
                    "description": "Светофор темный, неисправность красного",
                    "contexts": [
                        {
                            "eventId": "0x83",
                            "name": "armCpEl"
                        }
                    ]
                },
                {
                    "name": "YELLOW_FLASH_FAULT",
                    "description": "Желтый, неисправность мигания",
                    "contexts": [
                        {
                            "eventId": "0x84",
                            "name": "armCpEl"
                        }
                    ]
                },
                {
                    "name": "YELLOW_YELLOW_OR_GREEN_FAULT",
                    "description": "Желтый, неисправность желтого или зеленого",
                    "contexts": [
                        {
                            "eventId": "0x85",
                            "name": "armCpEl"
                        }
                    ]
                },
                {
                    "name": "TWO_YELLOW_FLASH_FAULT",
                    "description": "Два желтых, неисправность мигания",
                    "contexts": [
                        {
                            "eventId": "0x86",
                            "name": "armCpEl"
                        }
                    ]
                },
                {
                    "name": "TWO_YELLOW_WHITE_FLASH_FAULT",
                    "description": "Два желтых, белый, неисправность мигания",
                    "contexts": [
                        {
                            "eventId": "0x87",
                            "name": "armCpEl"
                        }
                    ]
                },
                {
                    "name": "DARK_WHITE_FAULT",
                    "description": "Светофор темный, неисправность белого",
                    "contexts": [
                        {
                            "eventId": "0x88",
                            "name": "armCpEl"
                        }
                    ]
                },
                {
                    "name": "YELLOW_WHITE_GREEN_FAULT",
                    "description": "Желтый + белый, неисправность зеленого",
                    "contexts": [
                        {
                            "eventId": "0x89",
                            "name": "armCpEl"
                        }
                    ]
                },
                {
                    "name": "CALL_ON_FAULT",
                    "description": "Неисправность пригласительного",
                    "contexts": [
                        {
                            "eventId": "0x8A",
                            "name": "armCpEl"
                        }
                    ]
                }
            ],
            "default": "UNDEF"
        },
        {
            "name": "Blocking",
            "type": "enum",
            "default": "UNDEF",
            "values": [
                {
                    "name": "UNDEF",
                    "description": "Нет данных"
                },
                {
                    "name": "NOT_BLOCKED",
                    "description": "Сигнал не блокирован",
                    "contexts": [
                        {
                            "eventId": "0x2E",
                            "name": "armCpEl"
                        },
                        {
                            "name": "apkDk",
                            "functionName": "Сигнал_с_3_головками_Blocking_состояние",
                            "value": 0
                        }
                    ]
                },
                {
                    "name": "BLOCKED",
                    "description": "Сигнал блокирован",
                    "contexts": [
                        {
                            "eventId": "0x2F",
                            "name": "armCpEl"
                        },
                        {
                            "name": "apkDk",
                            "functionName": "Сигнал_с_3_головками_Blocking_состояние",
                            "value": 1
                        }
                    ]
                }
            ]
        },
        {
            "name": "RouteWithoutSignal",
            "type": "enum",
            "default": "UNDEF",
            "values": [
                {
                    "name": "UNDEF",
                    "description": "Нет данных"
                },
                {
                    "name": "NO_ROUTE",
                    "description": "Нет маршрута без открытия сигнала",
                    "contexts": [
                        {
                            "eventId": "0x28",
                            "name": "armCpEl"
                        },
                        {
                            "name": "apkDk",
                            "functionName": "Сигнал_с_3_головками_Route_without_signal_состояние",
                            "value": 0
                        }
                    ]
                },
                {
                    "name": "ROUTE_SET",
                    "description": "Установлен режим маршрута без открытия сигнала",
                    "contexts": [
                        {
                            "eventId": "0x29",
                            "name": "armCpEl"
                        },
                        {
                            "name": "apkDk",
                            "functionName": "Сигнал_с_3_головками_Route_without_signal_состояние",
                            "value": 1
                        }
                    ]
                }
            ]
        },
        {
            "name": "Fleeting",
            "type": "enum",
            "default": "UNDEF",
            "values": [
                {
                    "name": "UNDEF",
                    "description": "Нет данных"
                },
                {
                    "name": "AUTO_OFF",
                    "description": "Автодействие выключено",
                    "contexts": [
                        {
                            "eventId": "0x38",
                            "name": "armCpEl"
                        },
                        {
                            "name": "apkDk",
                            "functionName": "Сигнал_с_3_головками_Fleeting_состояние",
                            "value": 0
                        }
                    ]
                },
                {
                    "name": "AUTO_ON",
                    "description": "Автодействие включено",
                    "contexts": [
                        {
                            "eventId": "0x39",
                            "name": "armCpEl"
                        },
                        {
                            "name": "apkDk",
                            "functionName": "Сигнал_с_3_головками_Fleeting_состояние",
                            "value": 1
                        }
                    ]
                }
            ]
        },
        {
            "name": "CriticalCommand",
            "type": "enum",
            "default": "UNDEF",
            "values": [
                {
                    "name": "UNDEF",
                    "description": "Нет данных"
                },
                {
                    "name": "NO_CRITICAL",
                    "description": "Ответственная команда отсутствует",
                    "contexts": [
                        {
                            "eventId": "0x2C",
                            "name": "armCpEl"
                        },
                        {
                            "name": "apkDk",
                            "functionName": "Сигнал_с_3_головками_Critical_command_состояние",
                            "value": 0
                        }
                    ]
                },
                {
                    "name": "CRITICAL_SET",
                    "description": "Задана ответственная команда",
                    "contexts": [
                        {
                            "eventId": "0x2D",
                            "name": "armCpEl"
                        },
                        {
                            "name": "apkDk",
                            "functionName": "Сигнал_с_3_головками_Critical_command_состояние",
                            "value": 1
                        }
                    ]
                }
            ]
        },
        {
            "name": "DelayOpenTimer",
            "type": "enum",
            "default": "UNDEF",
            "values": [
                {
                    "name": "UNDEF",
                    "description": "Нет данных"
                },
                {
                    "name": "TIMER_OFF",
                    "description": "Таймер задержки открытия выключен",
                    "contexts": [
                        {
                            "eventId": "0x36",
                            "name": "armCpEl"
                        },
                        {
                            "name": "apkDk",
                            "functionName": "Сигнал_с_3_головками_Delay_open_timer_состояние",
                            "value": 0
                        }
                    ]
                },
                {
                    "name": "TIMER_ON",
                    "description": "Таймер задержки открытия включен",
                    "contexts": [
                        {
                            "eventId": "0x37",
                            "name": "armCpEl"
                        },
                        {
                            "name": "apkDk",
                            "functionName": "Сигнал_с_3_головками_Delay_open_timer_состояние",
                            "value": 1
                        }
                    ]
                }
            ]
        },
        {
            "name": "TrapToCancelRouteWithOccupiedApproaching",
            "type": "enum",
            "default": "UNDEF",
            "values": [
                {
                    "name": "UNDEF",
                    "description": "Нет данных"
                },
                {
                    "name": "TRAP_CLEAR",
                    "description": "Фиксация отмены маршрута при занятом участке приближения - снятие",
                    "contexts": [
                        {
                            "eventId": "0x72",
                            "name": "armCpEl"
                        },
                        {
                            "name": "apkDk",
                            "functionName": "Сигнал_с_3_головками_Trap_to_cancel_route_with_occupied_approaching_состояние",
                            "value": 0
                        }
                    ]
                },
                {
                    "name": "TRAP_SET",
                    "description": "Фиксация отмены маршрута при занятом участке приближения",
                    "contexts": [
                        {
                            "eventId": "0x73",
                            "name": "armCpEl"
                        },
                        {
                            "name": "apkDk",
                            "functionName": "Сигнал_с_3_головками_Trap_to_cancel_route_with_occupied_approaching_состояние",
                            "value": 1
                        }
                    ]
                }
            ]
        },
        {
            "name": "White",
            "type": "enum",
            "default": "UNDEF",
            "values": [
                {
                    "name": "UNDEF",
                    "description": "Нет данных"
                },
                {
                    "name": "NO_CALL_ON",
                    "description": "нет пригласительно показания",
                    "contexts": [
                        {
                            "eventId": "0x24",
                            "name": "armCpEl"
                        }
                    ]
                },
                {
                    "name": "TIMER_90_SEC",
                    "description": "идет отсчет времени 90 сек",
                    "contexts": [
                        {
                            "eventId": "0x25",
                            "name": "armCpEl"
                        }
                    ]
                },
                {
                    "name": "REPEAT_COMMAND_TIMER_GT_90",
                    "description": "дана повторная команда, таймер > 90 сек",
                    "contexts": [
                        {
                            "eventId": "0x2A",
                            "name": "armCpEl"
                        }
                    ]
                }
            ]
        },
        {
            "name": "FALT",
            "type": "enum",
            "default": "UNDEF",
            "values": [
                {
                    "name": "UNDEF",
                    "description": "Нет данных"
                },
                {
                    "name": "NO_FAULT",
                    "description": "Отсутствие неисправности мигания и соответствия огней",
                    "contexts": [
                        {
                            "eventId": "0x9A",
                            "name": "armCpEl"
                        }
                    ]
                },
                {
                    "name": "FLASH_OR_MATCH_FAULT",
                    "description": "Наличие неисправности мигания или соответствия огней",
                    "contexts": [
                        {
                            "eventId": "0x9B",
                            "name": "armCpEl"
                        }
                    ]
                },
                {
                    "name": "CABLE_SHORT",
                    "description": "Наличие короткого замыкания кабеля",
                    "contexts": [
                        {
                            "eventId": "0x9C",
                            "name": "armCpEl"
                        }
                    ]
                }
            ]
        },
        {
            "name": "EstablishingRoute",
            "type": "enum",
            "values": [
                {
                    "name": "UNDEF",
                    "description": "Нет данных"
                },
                {
                    "name": "NO_ROUTE",
                    "description": "От сигнала не устанавливается маршрут",
                    "contexts": [
                        {
                            "name": "armCpEl",
                            "eventId": "0x20"
                        },
                        {
                            "name": "apkDk",
                            "functionName": "Сигнал_с_3_головками_установка_маршрута",
                            "value": 0
                        }
                    ]
                },
                {
                    "name": "SHUNTING_ROUTE",
                    "description": "От сигнала устанавливается маневровый маршрут",
                    "contexts": [
                        {
                            "name": "armCpEl",
                            "eventId": "0x22"
                        },
                        {
                            "name": "apkDk",
                            "functionName": "Сигнал_с_3_головками_установка_маршрута",
                            "value": 1
                        }
                    ]
                },
                {
                    "name": "TRAIN_ROUTE",
                    "description": "От сигнала устанавливается поездной маршрут",
                    "contexts": [
                        {
                            "name": "armCpEl",
                            "eventId": "0x21"
                        },
                        {
                            "name": "apkDk",
                            "functionName": "Сигнал_с_3_головками_установка_маршрута",
                            "value": 2
                        }
                    ]
                }
            ],
            "default": "UNDEF"
        },
        {
            "name": "CancelRoute",
            "type": "enum",
            "values": [
                {
                    "name": "UNDEF",
                    "description": "Нет данных"
                },
                {
                    "name": "NO_CANCEL_ROUTE",
                    "description": "Нет отмены маршрута",
                    "contexts": [
                        {
                            "name": "armCpEl",
                            "eventId": "0x26"
                        },
                        {
                            "name": "apkDk",
                            "functionName": "Сигнал_с_3_головками_отмена_маршрута",
                            "value": 0
                        }
                    ]
                },
                {
                    "name": "CANCEL_ROUTE",
                    "description": "Выполняется отмена маршрута от сигнала",
                    "contexts": [
                        {
                            "name": "armCpEl",
                            "eventId": "0x27"
                        },
                        {
                            "name": "apkDk",
                            "functionName": "Сигнал_с_3_головками_отмена_маршрута",
                            "value": 1
                        }
                    ]
                }
            ],
            "default": "UNDEF"
        }
    ]
}