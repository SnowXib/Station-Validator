{
    "name": "Signal",
    "extend": "SignalBase",
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
                            "functionName": "Сигнал_состояние",
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
                            "functionName": "Сигнал_состояние",
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
                            "functionName": "Сигнал_состояние",
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
                            "functionName": "Сигнал_состояние",
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
                            "functionName": "Сигнал_состояние",
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
                            "functionName": "Сигнал_состояние",
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
                            "functionName": "Сигнал_состояние",
                            "value": 6
                        }
                    ]
                },
                {
                    "name": "GREEN_YELLOW",
                    "description": "Зеленый + желтый",
                    "contexts": [
                        {
                            "eventId": "0x47",
                            "name": "armCpEl"
                        },
                        {
                            "name": "apkDk",
                            "functionName": "Сигнал_состояние",
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
                            "functionName": "Сигнал_состояние",
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
                            "functionName": "Сигнал_состояние",
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
                            "functionName": "Сигнал_состояние",
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
                            "functionName": "Сигнал_состояние",
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
                            "functionName": "Сигнал_состояние",
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
                            "functionName": "Сигнал_состояние",
                            "value": 13
                        }
                    ]
                },
                {
                    "name": "WHITE_YELLOW_FLASHING_2",
                    "description": "Белый + желтый мигающий",
                    "contexts": [
                        {
                            "eventId": "0x4E",
                            "name": "armCpEl"
                        },
                        {
                            "name": "apkDk",
                            "functionName": "Сигнал_состояние",
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
                        },
                        {
                            "name": "apkDk",
                            "functionName": "Сигнал_состояние",
                            "value": 15
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
                        },
                        {
                            "name": "apkDk",
                            "functionName": "Сигнал_состояние",
                            "value": 16
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
            "name": "FilamentIntegrity",
            "type": "enum",
            "values": [
                {
                    "name": "UNDEF",
                    "description": "Нет данных"
                },
                {
                    "name": "NOT_FAULTY_INTEGRITY",
                    "description": "Отсутствие неисправности мигания и соответствия огней",
                    "contexts": [
                        {
                            "name": "armCpEl",
                            "eventId": "0x9A"
                        }
                    ]
                },
                {
                    "name": "FAULTY_INTEGRITY",
                    "description": "Наличие неисправности мигания или соответствия огней",
                    "contexts": [
                        {
                            "name": "armCpEl",
                            "eventId": "0x9B"
                        }
                    ]
                },
                {
                    "name": "SHORT_CIRCUIT_INTEGRITY",
                    "description": "Наличие короткого замыкания кабеля",
                    "contexts": [
                        {
                            "name": "armCpEl",
                            "eventId": "0x9C"
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
                    "name": "SIGNAL_NOT_BLOCKED",
                    "description": "Сигнал не блокирован",
                    "contexts": [
                        {
                            "eventId": "0x2E",
                            "name": "armCpEl"
                        },
                        {
                            "name": "apkDk",
                            "functionName": "Сигнал_блокировка",
                            "value": 0
                        }
                    ]
                },
                {
                    "name": "SIGNAL_BLOCKED",
                    "description": "Сигнал блокирован",
                    "contexts": [
                        {
                            "eventId": "0x2F",
                            "name": "armCpEl"
                        },
                        {
                            "name": "apkDk",
                            "functionName": "Сигнал_блокировка",
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
                    "name": "NO_ROUTE_WO_SIGNAL",
                    "description": "Нет маршрута без открытия сигнала",
                    "contexts": [
                        {
                            "eventId": "0x28",
                            "name": "armCpEl"
                        },
                        {
                            "name": "apkDk",
                            "functionName": "Сигнал_маршрут_без_открытия",
                            "value": 0
                        }
                    ]
                },
                {
                    "name": "ROUTE_WO_SIGNAL_SET",
                    "description": "Установлен режим маршрута без открытия сигнала",
                    "contexts": [
                        {
                            "eventId": "0x29",
                            "name": "armCpEl"
                        },
                        {
                            "name": "apkDk",
                            "functionName": "Сигнал_маршрут_без_открытия",
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
                            "functionName": "Сигнал_автодействие",
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
                            "functionName": "Сигнал_автодействие",
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
                    "name": "CRITICAL_CMD_ABSENT",
                    "description": "Ответственная команда отсутствует",
                    "contexts": [
                        {
                            "eventId": "0x2C",
                            "name": "armCpEl"
                        },
                        {
                            "name": "apkDk",
                            "functionName": "Сигнал_команда_требующая_подтверждения",
                            "value": 0
                        }
                    ]
                },
                {
                    "name": "CRITICAL_CMD_SET",
                    "description": "Задана ответственная команда",
                    "contexts": [
                        {
                            "eventId": "0x2D",
                            "name": "armCpEl"
                        },
                        {
                            "name": "apkDk",
                            "functionName": "Сигнал_команда_требующая_подтверждения",
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
                    "name": "DELAY_OFF",
                    "description": "Таймер задержки открытия выключен",
                    "contexts": [
                        {
                            "eventId": "0x36",
                            "name": "armCpEl"
                        },
                        {
                            "name": "apkDk",
                            "functionName": "Сигнал_задержка_открытия",
                            "value": 0
                        }
                    ]
                },
                {
                    "name": "DELAY_ON",
                    "description": "Таймер задержки открытия включен",
                    "contexts": [
                        {
                            "eventId": "0x37",
                            "name": "armCpEl"
                        },
                        {
                            "name": "apkDk",
                            "functionName": "Сигнал_задержка_открытия",
                            "value": 1
                        }
                    ]
                }
            ]
        },
        {
            "name": "TrapCancelRouteOccupiedApproaching",
            "type": "enum",
            "default": "UNDEF",
            "values": [
                {
                    "name": "UNDEF",
                    "description": "Нет данных"
                },
                {
                    "name": "TRAP_CANCEL_ROUTE_RESET",
                    "description": "Фиксация отмены маршрута при занятом участке приближения - снятие",
                    "contexts": [
                        {
                            "eventId": "0x72",
                            "name": "armCpEl"
                        },
                        {
                            "name": "apkDk",
                            "functionName": "Сигнал_фиксация_отмены_маршрута",
                            "value": 0
                        }
                    ]
                },
                {
                    "name": "TRAP_CANCEL_ROUTE_SET",
                    "description": "Фиксация отмены маршрута при занятом участке приближения",
                    "contexts": [
                        {
                            "eventId": "0x73",
                            "name": "armCpEl"
                        },
                        {
                            "name": "apkDk",
                            "functionName": "Сигнал_фиксация_отмены_маршрута",
                            "value": 1
                        }
                    ]
                }
            ]
        },
        {
            "name": "TrapOccupiedFirstRecessiveSection",
            "type": "enum",
            "default": "UNDEF",
            "values": [
                {
                    "name": "UNDEF",
                    "description": "Нет данных"
                },
                {
                    "name": "TRAP_FIRST_SECTION_FREE",
                    "description": "Нет занятости первого участка приближения-удаления при установке выходного маршрута",
                    "contexts": [
                        {
                            "eventId": "0x74",
                            "name": "armCpEl"
                        }
                    ]
                },
                {
                    "name": "TRAP_FIRST_SECTION_OCCUPIED",
                    "description": "Первый участок приближения-удаления занят при установки выходного маршрута",
                    "contexts": [
                        {
                            "eventId": "0x75",
                            "name": "armCpEl"
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
                    "name": "NO_INVITING_INDICATION",
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
        }
    ]
}