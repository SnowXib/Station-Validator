{
    "name": "DirectionArrow",
    "variables": [
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
                    "name": "NOT_BLOCK",
                    "description": "Перегон не блокирован",
                    "contexts": [
                        {
                            "eventId": "0x2B",
                            "name": "armCpEl"
                        },
                        {
                            "name": "apkDk",
                            "functionName": "Скоростной_режим",
                            "value": 1
                        }
                    ]
                },
                {
                    "name": "BLOCK",
                    "description": "Перегон блокирован",
                    "contexts": [
                        {
                            "eventId": "0x2A",
                            "name": "armCpEl"
                        },
                        {
                            "name": "apkDk",
                            "functionName": "Скоростной_режим",
                            "value": 0
                        }
                    ]
                }
            ]
        },
        {
            "name": "SettingDirectionChangeCommands",
            "type": "enum",
            "values": [
                {
                    "name": "UNDEF",
                    "description": "Нет данных"
                },
                {
                    "name": "NO_INFO",
                    "description": "Команда отсутствует",
                    "contexts": [
                        {
                            "eventId": "0x34",
                            "name": "armCpEl"
                        },
                        {
                            "name": "apkDk",
                            "functionName": "Направление_задание_команды",
                            "value": 0
                        }
                    ]
                },
                {
                    "name": "OFF",
                    "description": "Задана команда смены направления",
                    "contexts": [
                        {
                            "eventId": "0x35",
                            "name": "armCpEl"
                        },
                        {
                            "name": "apkDk",
                            "functionName": "Направление_задание_команды",
                            "value": 1
                        }
                    ]
                },
                {
                    "name": "BLINK",
                    "description": "Задана команда вспомогательного приема",
                    "contexts": [
                        {
                            "eventId": "0x37",
                            "name": "armCpEl"
                        },
                        {
                            "name": "apkDk",
                            "functionName": "Направление_задание_команды",
                            "value": 2
                        }
                    ]
                },
                {
                    "name": "ON",
                    "description": "Задана команда вспомогательного отправления",
                    "contexts": [
                        {
                            "eventId": "0x36",
                            "name": "armCpEl"
                        },
                        {
                            "name": "apkDk",
                            "functionName": "Направление_задание_команды",
                            "value": 3
                        }
                    ]
                }
            ],
            "default": "UNDEF"
        },
        {
            "name": "KeyStaff",
            "type": "enum",
            "values": [
                {
                    "name": "UNDEF",
                    "description": "Нет данных"
                },
                {
                    "name": "NO_INFO",
                    "description": "Ключ-жезл - нет информации",
                    "contexts": [
                        {
                            "eventId": "0x60",
                            "name": "armCpEl"
                        },
                        {
                            "name": "apkDk",
                            "functionName": "Ключ_жезл",
                            "value": 0
                        }
                    ]
                },
                {
                    "name": "OFF_NO_TRAIN",
                    "description": "Ключ-жезл изъят. Отсутствие хозяйственного поезда на перегоне.",
                    "contexts": [
                        {
                            "eventId": "0x61",
                            "name": "armCpEl"
                        }
                    ]
                },
                {
                    "name": "IN",
                    "description": "Ключ-жезл в замке",
                    "contexts": [
                        {
                            "eventId": "0x62",
                            "name": "armCpEl"
                        },
                        {
                            "name": "apkDk",
                            "functionName": "Ключ_жезл",
                            "value": 2
                        }
                    ]
                },
                {
                    "name": "OFF_IS_TRAIN",
                    "description": "Ключ-жезл изъят. Хозяйственный поезд на перегоне.",
                    "contexts": [
                        {
                            "eventId": "0x56",
                            "name": "armCpEl"
                        }
                    ]
                }
            ],
            "default": "UNDEF"
        },
        {
            "name": "GreenArrow",
            "type": "enum",
            "values": [
                {
                    "name": "UNDEF",
                    "description": "Нет данных"
                },
                {
                    "name": "NO_INFO",
                    "description": "Направление АБ «отправление», нет информации входов",
                    "contexts": [
                        {
                            "eventId": "0x6C",
                            "name": "armCpEl"
                        },
                        {
                            "name": "apkDk",
                            "functionName": "Зеленая_стрела_станция_на_отправлении",
                            "value": 0
                        }
                    ]
                },
                {
                    "name": "OFF",
                    "description": "Отсутствует направление АБ «отправление»",
                    "contexts": [
                        {
                            "eventId": "0x6D",
                            "name": "armCpEl"
                        },
                        {
                            "name": "apkDk",
                            "functionName": "Зеленая_стрела_станция_на_отправлении",
                            "value": 1
                        }
                    ]
                },
                {
                    "name": "BLINK",
                    "description": "Направление АБ «отправление», дана команда согласия на смену направления",
                    "contexts": [
                        {
                            "eventId": "0x6E",
                            "name": "armCpEl"
                        },
                        {
                            "name": "apkDk",
                            "functionName": "Зеленая_стрела_станция_на_отправлении",
                            "value": 2
                        }
                    ]
                },
                {
                    "name": "ON",
                    "description": "Направление АБ «отправление»",
                    "contexts": [
                        {
                            "eventId": "0x6F",
                            "name": "armCpEl"
                        },
                        {
                            "name": "apkDk",
                            "functionName": "Зеленая_стрела_станция_на_отправлении",
                            "value": 3
                        }
                    ]
                }
            ],
            "default": "UNDEF"
        },
        {
            "name": "YellowArrow",
            "type": "enum",
            "values": [
                {
                    "name": "UNDEF",
                    "description": "Нет данных"
                },
                {
                    "name": "NO_INFO",
                    "description": "Направление АБ «приём», нет информации входов",
                    "contexts": [
                        {
                            "eventId": "0x40",
                            "name": "armCpEl"
                        },
                        {
                            "name": "apkDk",
                            "functionName": "Желтая_стрела_станция_на_приеме",
                            "value": 0
                        }
                    ]
                },
                {
                    "name": "OFF",
                    "description": "Отсутствует направление АБ «приём»",
                    "contexts": [
                        {
                            "eventId": "0x41",
                            "name": "armCpEl"
                        },
                        {
                            "name": "apkDk",
                            "functionName": "Желтая_стрела_станция_на_приеме",
                            "value": 1
                        }
                    ]
                },
                {
                    "name": "BLINK",
                    "description": "Направление АБ «приём», дана команда смены направления",
                    "contexts": [
                        {
                            "eventId": "0x42",
                            "name": "armCpEl"
                        },
                        {
                            "name": "apkDk",
                            "functionName": "Желтая_стрела_станция_на_приеме",
                            "value": 2
                        }
                    ]
                },
                {
                    "name": "ON",
                    "description": "Направление АБ «приём»",
                    "contexts": [
                        {
                            "eventId": "0x43",
                            "name": "armCpEl"
                        },
                        {
                            "name": "apkDk",
                            "functionName": "Желтая_стрела_станция_на_приеме",
                            "value": 3
                        }
                    ]
                }
            ],
            "default": "UNDEF"
        },
        {
            "name": "WhiteSquare",
            "type": "enum",
            "values": [
                {
                    "name": "UNDEF",
                    "description": "Нет данных"
                },
                {
                    "name": "NO_INFO",
                    "description": "Свободность перегона - нет информации",
                    "contexts": [
                        {
                            "eventId": "0x44",
                            "name": "armCpEl"
                        },
                        {
                            "name": "apkDk",
                            "functionName": "Белый_квадрат",
                            "value": 0
                        }
                    ]
                },
                {
                    "name": "OFF",
                    "description": "Белый квадрат - погашен",
                    "contexts": [
                        {
                            "eventId": "0x45",
                            "name": "armCpEl"
                        },
                        {
                            "name": "apkDk",
                            "functionName": "Белый_квадрат",
                            "value": 1
                        }
                    ]
                },
                {
                    "name": "BLINK",
                    "description": "Неисправность цепи вспомогательной смены направления",
                    "contexts": [
                        {
                            "eventId": "0x46",
                            "name": "armCpEl"
                        },
                        {
                            "name": "apkDk",
                            "functionName": "Белый_квадрат",
                            "value": 2
                        }
                    ]
                },
                {
                    "name": "ON",
                    "description": "Перегон свободен",
                    "contexts": [
                        {
                            "eventId": "0x47",
                            "name": "armCpEl"
                        },
                        {
                            "name": "apkDk",
                            "functionName": "Белый_квадрат",
                            "value": 3
                        }
                    ]
                }
            ],
            "default": "UNDEF"
        },
        {
            "name": "RedSquare",
            "type": "enum",
            "values": [
                {
                    "name": "UNDEF",
                    "description": "Нет данных"
                },
                {
                    "name": "NO_INFO",
                    "description": "Занятость перегона - нет информации",
                    "contexts": [
                        {
                            "eventId": "0x48",
                            "name": "armCpEl"
                        },
                        {
                            "name": "apkDk",
                            "functionName": "Красный_квадрат",
                            "value": 0
                        }
                    ]
                },
                {
                    "name": "OFF",
                    "description": "Красный квадрат - погашен",
                    "contexts": [
                        {
                            "eventId": "0x49",
                            "name": "armCpEl"
                        },
                        {
                            "name": "apkDk",
                            "functionName": "Красный_квадрат",
                            "value": 1
                        }
                    ]
                },
                {
                    "name": "BLINK",
                    "description": "Перегон свободен, на соседней станции открыт выходной светофор или изъят из замка ключ-жезл",
                    "contexts": [
                        {
                            "eventId": "0x4A",
                            "name": "armCpEl"
                        },
                        {
                            "name": "apkDk",
                            "functionName": "Красный_квадрат",
                            "value": 2
                        }
                    ]
                },
                {
                    "name": "ON",
                    "description": "Перегон занят",
                    "contexts": [
                        {
                            "eventId": "0x4B",
                            "name": "armCpEl"
                        },
                        {
                            "name": "apkDk",
                            "functionName": "Красный_квадрат",
                            "value": 3
                        }
                    ]
                }
            ],
            "default": "UNDEF"
        },
        {
            "name": "SecondArrivalDeparture",
            "type": "enum",
            "values": [
                {
                    "name": "UNDEF",
                    "description": "Нет данных"
                },
                {
                    "name": "NO_INFO",
                    "description": "Второй участок приближения (удаления) - нет информации",
                    "contexts": [
                        {
                            "eventId": "0x66",
                            "name": "armCpEl"
                        },
                        {
                            "name": "apkDk",
                            "functionName": "Второй_участок_приближения_удаления",
                            "value": 0
                        }
                    ]
                },
                {
                    "name": "ON",
                    "description": "Второйй участок приближения (удаления) занят",
                    "contexts": [
                        {
                            "eventId": "0x67",
                            "name": "armCpEl"
                        },
                        {
                            "name": "apkDk",
                            "functionName": "Второй_участок_приближения_удаления",
                            "value": 1
                        }
                    ]
                },
                {
                    "name": "OFF",
                    "description": "Второй участок приближения (удаления) свободен",
                    "contexts": [
                        {
                            "eventId": "0x68",
                            "name": "armCpEl"
                        },
                        {
                            "name": "apkDk",
                            "functionName": "Второй_участок_приближения_удаления",
                            "value": 2
                        }
                    ]
                },
                {
                    "name": "HIDE",
                    "description": "Второй участок приближения-удаления не отображается",
                    "contexts": [
                        {
                            "eventId": "0x5F",
                            "name": "armCpEl"
                        },
                        {
                            "name": "apkDk",
                            "functionName": "Второй_участок_приближения_удаления",
                            "value": 3
                        }
                    ]
                }
            ],
            "default": "UNDEF"
        },
        {
            "name": "FirstArrivalDeparture",
            "type": "enum",
            "values": [
                {
                    "name": "UNDEF",
                    "description": "Нет данных"
                },
                {
                    "name": "NO_INFO",
                    "description": "Первый участок приближения (удаления) - нет информации",
                    "contexts": [
                        {
                            "eventId": "0x63",
                            "name": "armCpEl"
                        },
                        {
                            "name": "apkDk",
                            "functionName": "Первый_участок_приближения_удаления",
                            "value": 0
                        }
                    ]
                },
                {
                    "name": "ON",
                    "description": "Первый участок приближения (удаления) занят",
                    "contexts": [
                        {
                            "eventId": "0x64",
                            "name": "armCpEl"
                        },
                        {
                            "name": "apkDk",
                            "functionName": "Первый_участок_приближения_удаления",
                            "value": 1
                        }
                    ]
                },
                {
                    "name": "OFF",
                    "description": "Первый участок приближения (удаления) свободен",
                    "contexts": [
                        {
                            "eventId": "0x65",
                            "name": "armCpEl"
                        },
                        {
                            "name": "apkDk",
                            "functionName": "Первый_участок_приближения_удаления",
                            "value": 2
                        }
                    ]
                }
            ],
            "default": "UNDEF"
        },
        {
            "name": "HighSpeedMode",
            "type": "enum",
            "values": [
                {
                    "name": "UNDEF",
                    "description": "Нет данных"
                },
                {
                    "name": "OFF",
                    "description": "Выдержки времени нет для скоростного движения",
                    "contexts": [
                        {
                            "eventId": "0x4E",
                            "name": "armCpEl"
                        }
                    ]
                },
                {
                    "name": "ON",
                    "description": "Установлена выдержка времени для скоростного движения",
                    "contexts": [
                        {
                            "eventId": "0x4F",
                            "name": "armCpEl"
                        }
                    ]
                }
            ],
            "default": "UNDEF"
        },
        {
            "name": "FalseOccupied",
            "type": "enum",
            "values": [
                {
                    "name": "UNDEF",
                    "description": "Нет данных"
                },
                {
                    "name": "OFF",
                    "description": "Первый участок удаления свободен или выходной светофор на перегон закрыт",
                    "contexts": [
                        {
                            "eventId": "0x74",
                            "name": "armCpEl"
                        }
                    ]
                },
                {
                    "name": "ON",
                    "description": "Фиксация ложной занятости участка удаления в маршруте",
                    "contexts": [
                        {
                            "eventId": "0x75",
                            "name": "armCpEl"
                        }
                    ]
                }
            ],
            "default": "UNDEF"
        },
        {
            "name": "FirstArrivalDepartureBlocking",
            "type": "enum",
            "values": [
                {
                    "name": "UNDEF",
                    "description": "Нет данных"
                },
                {
                    "name": "ON",
                    "description": "Первый участок удаления блокирован",
                    "contexts": [
                        {
                            "eventId": "0x70",
                            "name": "armCpEl"
                        },
                        {
                            "name": "apkDk",
                            "functionName": "Направление_команда_требующая_подтверждения",
                            "value": 1
                        }
                    ]
                },
                {
                    "name": "OFF",
                    "description": "Первый участок удаления не блокирован",
                    "contexts": [
                        {
                            "eventId": "0x71",
                            "name": "armCpEl"
                        }
                    ]
                }
            ],
            "default": "UNDEF"
        },
        {
            "name": "SecondArrivalDepartureBlocking",
            "type": "enum",
            "values": [
                {
                    "name": "UNDEF",
                    "description": "Нет данных"
                },
                {
                    "name": "ON",
                    "description": "Второй участок удаления блокирован",
                    "contexts": [
                        {
                            "eventId": "0x20",
                            "name": "armCpEl"
                        }
                    ]
                },
                {
                    "name": "OFF",
                    "description": "Второй участок удаления не блокирован",
                    "contexts": [
                        {
                            "eventId": "0x21",
                            "name": "armCpEl"
                        }
                    ]
                }
            ],
            "default": "UNDEF"
        },
        {
            "name": "CableLineControl",
            "type": "enum",
            "values": [
                {
                    "name": "UNDEF",
                    "description": "Нет данных"
                },
                {
                    "name": "NO_INFO",
                    "description": "Кабельная линия - нет информации",
                    "contexts": [
                        {
                            "eventId": "0x30",
                            "name": "armCpEl"
                        }
                    ]
                },
                {
                    "name": "CRASH",
                    "description": "Кабельная линия - авария",
                    "contexts": [
                        {
                            "eventId": "0x31",
                            "name": "armCpEl"
                        }
                    ]
                },
                {
                    "name": "FAULT",
                    "description": "Кабельная линия - неисправна",
                    "contexts": [
                        {
                            "eventId": "0x32",
                            "name": "armCpEl"
                        }
                    ]
                },
                {
                    "name": "OK",
                    "description": "Кабельная линия - исправна",
                    "contexts": [
                        {
                            "eventId": "0x33",
                            "name": "armCpEl"
                        }
                    ]
                }
            ],
            "default": "UNDEF"
        },
        {
            "name": "S_R_R0",
            "type": "enum",
            "default": "UNDEF",
            "values": [
                {
                    "name": "UNDEF",
                    "description": "Нет данных"
                },
                {
                    "name": "NO_APPROACH_OCCUPANCY",
                    "description": "Нет занятия участков приближения",
                    "contexts": [
                        {
                            "eventId": "0x23",
                            "name": "armCpEl"
                        }
                    ]
                },
                {
                    "name": "CODE_36",
                    "description": "code 36",
                    "contexts": [
                        {
                            "eventId": "0x24",
                            "name": "armCpEl"
                        }
                    ]
                },
                {
                    "name": "CODE_37",
                    "description": "code 37",
                    "contexts": [
                        {
                            "eventId": "0x25",
                            "name": "armCpEl"
                        }
                    ]
                },
                {
                    "name": "CODE_38",
                    "description": "code 38",
                    "contexts": [
                        {
                            "eventId": "0x26",
                            "name": "armCpEl"
                        }
                    ]
                }
            ]
        },
        {
            "name": "FirstSection",
            "type": "enum",
            "default": "UNDEF",
            "values": [
                {
                    "name": "UNDEF",
                    "description": "Нет данных"
                },
                {
                    "name": "FIRST_SECTION_FREE_OR_DEPARTURE",
                    "description": "Первый участок приближения свободен или установлено направление на отправление",
                    "contexts": [
                        {
                            "eventId": "0x3E9",
                            "name": "armCpEl"
                        }
                    ]
                },
                {
                    "name": "FIRST_SECTION_OCCUPIED_ARRIVAL",
                    "description": "Занятие первого участка приближения прибывающим поездом",
                    "contexts": [
                        {
                            "eventId": "0x3E8",
                            "name": "armCpEl"
                        }
                    ]
                }
            ]
        },
        {
            "name": "SecondSection",
            "type": "enum",
            "default": "UNDEF",
            "values": [
                {
                    "name": "UNDEF",
                    "description": "Нет данных"
                },
                {
                    "name": "SECOND_SECTION_FREE_OR_DEPARTURE",
                    "description": "Второй участок приближения свободен или установлено направление на отправление",
                    "contexts": [
                        {
                            "eventId": "0x3EB",
                            "name": "armCpEl"
                        }
                    ]
                },
                {
                    "name": "SECOND_SECTION_OCCUPIED_ARRIVAL",
                    "description": "Занятие второго участка приближения прибывающим поездом",
                    "contexts": [
                        {
                            "eventId": "0x3EA",
                            "name": "armCpEl"
                        }
                    ]
                }
            ]
        },
        {
            "name": "ThirdSection",
            "type": "enum",
            "default": "UNDEF",
            "values": [
                {
                    "name": "UNDEF",
                    "description": "Нет данных"
                },
                {
                    "name": "THIRD_SECTION_FREE_OR_DEPARTURE",
                    "description": "Третий участок приближения свободен или установлено направление на отправление",
                    "contexts": [
                        {
                            "eventId": "0x3ED",
                            "name": "armCpEl"
                        }
                    ]
                },
                {
                    "name": "THIRD_SECTION_OCCUPIED_ARRIVAL",
                    "description": "Занятие третьего участка приближения прибывающим поездом",
                    "contexts": [
                        {
                            "eventId": "0x3EC",
                            "name": "armCpEl"
                        }
                    ]
                }
            ]
        }
    ]
}