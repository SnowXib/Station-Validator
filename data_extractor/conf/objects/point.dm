{
    "name": "Point",
    "variables": [
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
                    "name": "NOT_BLOCK",
                    "description": "Не блокирована",
                    "contexts": [
                        {
                            "eventId": "0x2E",
                            "name": "armCpEl"
                        },
                        {
                            "name": "apkDk",
                            "functionName": "Стрелка_блокировка",
                            "value": 0
                        }
                    ]
                },
                {
                    "name": "BLOCK",
                    "description": "Стрелка блокирована",
                    "contexts": [
                        {
                            "eventId": "0x2F",
                            "name": "armCpEl"
                        },
                        {
                            "name": "apkDk",
                            "functionName": "Стрелка_блокировка",
                            "value": 1
                        }
                    ]
                }
            ]
        },
        {
            "name": "Position",
            "type": "enum",
            "default": "UNDEF",
            "values": [
                {
                    "name": "UNDEF",
                    "description": "Нет данных"
                },
                {
                    "name": "SWITCH",
                    "description": "Выполняется перевод стрелки",
                    "contexts": [
                        {
                            "eventId": "0x88",
                            "name": "armCpEl"
                        },
                        {
                            "name": "apkDk",
                            "functionName": "Стрелка_состояние",
                            "value": 0
                        }
                    ]
                },
                {
                    "name": "PLUS",
                    "description": "Стрелка в плюсовом положении",
                    "contexts": [
                        {
                            "eventId": "0x51",
                            "name": "armCpEl"
                        },
                        {
                            "name": "apkDk",
                            "functionName": "Стрелка_состояние",
                            "value": 1
                        }
                    ]
                },
                {
                    "name": "MINUS",
                    "description": "Стрелка в минусовом положении",
                    "contexts": [
                        {
                            "eventId": "0x52",
                            "name": "armCpEl"
                        },
                        {
                            "name": "apkDk",
                            "functionName": "Стрелка_состояние",
                            "value": 2
                        }
                    ]
                },
                {
                    "name": "LOST",
                    "description": "Потеря контроля или недоход стрелки",
                    "alarmTo": [
                        "DSP",
                        "SHN"
                    ],
                    "contexts": [
                        {
                            "eventId": "0x50",
                            "name": "armCpEl"
                        },
                        {
                            "name": "apkDk",
                            "functionName": "Стрелка_состояние",
                            "value": 3
                        }
                    ]
                }
            ]
        },
        {
            "name": "FlankLocking",
            "type": "enum",
            "default": "UNDEF",
            "values": [
                {
                    "name": "UNDEF",
                    "description": "Нет данных"
                },
                {
                    "name": "NOT_LOCKED",
                    "description": "Стрелка не замкнута в маршруте как охранная",
                    "contexts": [
                        {
                            "eventId": "0x56",
                            "name": "armCpEl"
                        },
                        {
                            "name": "apkDk",
                            "functionName": "Стрелка_замкнутость_как_охранная",
                            "value": 0
                        }
                    ]
                },
                {
                    "name": "LOCK",
                    "description": "Стрелка замкнута в маршруте как охранная",
                    "contexts": [
                        {
                            "eventId": "0x55",
                            "name": "armCpEl"
                        },
                        {
                            "name": "apkDk",
                            "functionName": "Стрелка_замкнутость_как_охранная",
                            "value": 1
                        }
                    ]
                }
            ]
        },
        {
            "name": "FlankProtection",
            "type": "enum",
            "default": "UNDEF",
            "values": [
                {
                    "name": "UNDEF",
                    "description": "Нет данных"
                },
                {
                    "name": "PROTECTION",
                    "description": "Охранность соблюдена",
                    "contexts": [
                        {
                            "eventId": "0x54",
                            "name": "armCpEl"
                        },
                        {
                            "name": "apkDk",
                            "functionName": "Стрелка_охранность",
                            "value": 0
                        }
                    ]
                },
                {
                    "name": "NOT_INSTALLED",
                    "description": "Охранная стрелка для данной не установлена или негабаритность",
                    "contexts": [
                        {
                            "eventId": "0x53",
                            "name": "armCpEl"
                        },
                        {
                            "name": "apkDk",
                            "functionName": "Стрелка_охранность",
                            "value": 1
                        }
                    ]
                }
            ]
        },
        {
            "name": "Autoreverse",
            "type": "enum",
            "default": "UNDEF",
            "values": [
                {
                    "name": "UNDEF",
                    "description": "Нет данных"
                },
                {
                    "name": "NOT_NECESSARY",
                    "description": "Не требуется перевод стрелки в охранное положение",
                    "contexts": [
                        {
                            "eventId": "0x57",
                            "name": "armCpEl"
                        },
                        {
                            "name": "apkDk",
                            "functionName": "Стрелка_автовозврат",
                            "value": 0
                        }
                    ]
                },
                {
                    "name": "ENABLED",
                    "description": "Автовозврат включен, стрелка не в охранном положении",
                    "contexts": [
                        {
                            "eventId": "0x58",
                            "name": "armCpEl"
                        },
                        {
                            "name": "apkDk",
                            "functionName": "Стрелка_автовозврат",
                            "value": 1
                        }
                    ]
                },
                {
                    "name": "OFF",
                    "description": "Автовозврат выключен, стрелка не в охранном положении",
                    "contexts": [
                        {
                            "eventId": "0x74",
                            "name": "armCpEl"
                        },
                        {
                            "name": "apkDk",
                            "functionName": "Стрелка_автовозврат",
                            "value": 2
                        }
                    ]
                }
            ]
        },
        {
            "name": "CriticalCommand",
            "type": "enum",
            "values": [
                {
                    "name": "UNDEF",
                    "description": "Нет данных"
                },
                {
                    "name": "NO_RESPONSIBLE_COMMAND",
                    "description": "Ответственная команда отсутствует",
                    "contexts": [
                        {
                            "eventId": "0x2C",
                            "name": "armCpEl"
                        },
                        {
                            "name": "apkDk",
                            "functionName": "Стрелка_команда_требующая_подтверждения",
                            "value": 0
                        }
                    ]
                },
                {
                    "name": "RESPONSIBLE_COMMAND",
                    "description": "Задана ответственная команда",
                    "contexts": [
                        {
                            "eventId": "0x2D",
                            "name": "armCpEl"
                        },
                        {
                            "name": "apkDk",
                            "functionName": "Стрелка_команда_требующая_подтверждения",
                            "value": 1
                        }
                    ]
                }
            ],
            "default": "UNDEF"
        },
        {
            "name": "ControlInRoute",
            "type": "enum",
            "default": "UNDEF",
            "values": [
                {
                    "name": "UNDEF",
                    "description": "Нет данных"
                },
                {
                    "name": "CONTROL",
                    "description": "Стрелка в маршруте не замкнута или имеет контроль положения",
                    "contexts": [
                        {
                            "eventId": "0x70",
                            "name": "armCpEl"
                        },
                        {
                            "name": "apkDk",
                            "functionName": "Стрелка_контроль_в_маршруте",
                            "value": 0
                        }
                    ]
                },
                {
                    "name": "LOST_CONTROL",
                    "description": "Потеря контроля положения стрелки в установленном маршруте",
                    "alarmTo": [
                        "DSP",
                        "SHN"
                    ],
                    "contexts": [
                        {
                            "eventId": "0x71",
                            "name": "armCpEl"
                        },
                        {
                            "name": "apkDk",
                            "functionName": "Стрелка_контроль_в_маршруте",
                            "value": 1
                        }
                    ]
                }
            ]
        },
        {
            "name": "SpeedMode",
            "type": "enum",
            "default": "UNDEF",
            "values": [
                {
                    "name": "UNDEF",
                    "description": "Нет данных"
                },
                {
                    "name": "SPEED_LOCK",
                    "description": "Стрелка замкнута в режиме скоростного пропуска",
                    "contexts": [
                        {
                            "eventId": "0x59",
                            "name": "armCpEl"
                        }
                    ]
                },
                {
                    "name": "NO_SPEED_LOCK",
                    "description": "Стрелка не замкнута в режиме скоростного пропуска",
                    "contexts": [
                        {
                            "eventId": "0x5A",
                            "name": "armCpEl"
                        }
                    ]
                }
            ]
        },
        {
            "name": "NeedForSwitch",
            "type": "enum",
            "default": "UNDEF",
            "values": [
                {
                    "name": "UNDEF",
                    "description": "Нет данных"
                },
                {
                    "name": "STATE_0",
                    "description": "Не требуется перевод стрелки",
                    "contexts": [
                        {
                            "eventId": "1500",
                            "name": "armCpEl"
                        },
                        {
                            "name": "apkDk",
                            "functionName": "Перевод_стрелки_в_охранное_положение",
                            "value": 0
                        }
                    ]
                },
                {
                    "name": "STATE_1",
                    "description": "Необходимо перевести стрелку",
                    "contexts": [
                        {
                            "eventId": "1501",
                            "name": "armCpEl"
                        },
                        {
                            "name": "apkDk",
                            "functionName": "Перевод_стрелки_в_охранное_положение",
                            "value": 1
                        }
                    ]
                }
            ]
        },
        {
            "name": "LostFlankProtection",
            "type": "enum",
            "default": "UNDEF",
            "values": [
                {
                    "name": "UNDEF",
                    "description": "Нет данных"
                },
                {
                    "name": "STATE_0",
                    "description": "Данная стрелка в маршруте не замкнута или охранная к ней имеет контроль положения",
                    "contexts": [
                        {
                            "eventId": "0x72",
                            "name": "armCpEl"
                        },
                        {
                            "name": "apkDk",
                            "functionName": "Стрелка_охранная",
                            "value": 0
                        }
                    ]
                },
                {
                    "name": "STATE_1",
                    "description": "К данной стрелке в маршруте нарушена габаритность или охранность",
                    "alarmTo": [
                        "DSP",
                        "SHN"
                    ],
                    "contexts": [
                        {
                            "eventId": "0x73",
                            "name": "armCpEl"
                        },
                        {
                            "name": "apkDk",
                            "functionName": "Стрелка_охранная",
                            "value": 1
                        }
                    ]
                }
            ]
        },
        {
            "name": "BlockedMiddleTrack",
            "type": "enum",
            "default": "UNDEF",
            "values": [
                {
                    "name": "UNDEF",
                    "description": "Нет данных"
                },
                {
                    "name": "UNBLOCK_TIME_DELAY_IN_TRACK_MIDDLE",
                    "description": "Выдержка времени для разблокировки стрелки в середине пути",
                    "contexts": [
                        {
                            "eventId": "0x66",
                            "name": "armCpEl"
                        },
                        {
                            "name": "apkDk",
                            "functionName": "Блокировка_стрелки_в_середине_пути",
                            "value": 1
                        }
                    ]
                },
                {
                    "name": "BLOCK_IN_TRACK_MIDDLE",
                    "description": "Заблокирована как стрелка в середине пути",
                    "contexts": [
                        {
                            "eventId": "0x67",
                            "name": "armCpEl"
                        },
                        {
                            "name": "apkDk",
                            "functionName": "Блокировка_стрелки_в_середине_пути",
                            "value": 2
                        }
                    ]
                },
                {
                    "name": "NOT_BLOCK_IN_TRACK_MIDDLE",
                    "description": "Не заблокирована как стрелка в середине пути",
                    "contexts": [
                        {
                            "eventId": "0x65",
                            "name": "armCpEl"
                        },
                        {
                            "name": "apkDk",
                            "functionName": "Блокировка_стрелки_в_середине_пути",
                            "value": 3
                        }
                    ]
                }
            ]
        },
        {
            "name": "ControlMaket",
            "type": "enum",
            "default": "UNDEF",
            "values": [
                {
                    "name": "UNDEF",
                    "description": "Нет данных"
                },
                {
                    "name": "MAKET_NOT_USED",
                    "description": "Не используется",
                    "contexts": [
                        {
                            "eventId": "128",
                            "name": "armCpEl"
                        },
                        {
                            "name": "apkDk",
                            "functionName": "Стрелка_макет",
                            "value": 0
                        }
                    ]
                },
                {
                    "name": "MAKET_ACTIVATED_STRM",
                    "description": "Активирована функция макета командой СТРМ",
                    "contexts": [
                        {
                            "eventId": "129",
                            "name": "armCpEl"
                        },
                        {
                            "name": "apkDk",
                            "functionName": "Стрелка_макет",
                            "value": 1
                        }
                    ]
                },
                {
                    "name": "MAKET_ESTABLISHED_STMA",
                    "description": "Стрелка установлена на макет командой СТМА",
                    "contexts": [
                        {
                            "eventId": "130",
                            "name": "armCpEl"
                        },
                        {
                            "name": "apkDk",
                            "functionName": "Стрелка_макет",
                            "value": 2
                        }
                    ]
                },
                {
                    "name": "MAKET_ESTABLISHED_STMR",
                    "description": "Стрелка на макете, разрешена установка маршрута командой СТМР",
                    "contexts": [
                        {
                            "eventId": "131",
                            "name": "armCpEl"
                        },
                        {
                            "name": "apkDk",
                            "functionName": "Стрелка_макет",
                            "value": 3
                        }
                    ]
                },
                {
                    "name": "MAKET_NOT_ESTABLISHED",
                    "description": "Макет не подключен",
                    "contexts": [
                        {
                            "eventId": "132",
                            "name": "armCpEl"
                        },
                        {
                            "name": "apkDk",
                            "functionName": "Стрелка_макет",
                            "value": 4
                        }
                    ]
                }
            ]
        },
        {
            "name": "PointCommutator",
            "type": "enum",
            "default": "UNDEF",
            "values": [
                {
                    "name": "UNDEF",
                    "description": "Нет данных"
                },
                {
                    "name": "STATE_0",
                    "description": "Стрелка в состоянии полного покоя",
                    "contexts": [
                        {
                            "eventId": "0x60",
                            "name": "armCpEl"
                        }
                    ]
                },
                {
                    "name": "STATE_1",
                    "description": "Стрелка в + маршрутом",
                    "contexts": [
                        {
                            "eventId": "0x61",
                            "name": "armCpEl"
                        }
                    ]
                },
                {
                    "name": "STATE_2",
                    "description": "Стрелка в - маршрутом",
                    "contexts": [
                        {
                            "eventId": "0x62",
                            "name": "armCpEl"
                        }
                    ]
                },
                {
                    "name": "STATE_3",
                    "description": "Стрелка в + командой",
                    "contexts": [
                        {
                            "eventId": "0x63",
                            "name": "armCpEl"
                        }
                    ]
                },
                {
                    "name": "STATE_4",
                    "description": "Стрелка в - командой",
                    "contexts": [
                        {
                            "eventId": "0x64",
                            "name": "armCpEl"
                        }
                    ]
                }
            ]
        }
    ]
}